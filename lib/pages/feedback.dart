import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterandroidappforwordpress/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final _formkey = GlobalKey<FormState>();
  late double _rating;
  String? feedbacktext;
  final double _initialRating = 3.0;

  Future feedbacksend() async {
    String host = Utils.hostName;
    String name = Utils.nameShowInMail;
    bool ignoreBadCertificate = false;
    bool ssl = false;
    bool allowInsecure = false;
    String username = Utils.smtpUsername;
    String password = Utils.smtpPassword;

    final smtpServer = SmtpServer(
      host,
      port: Utils.port,
      name: name,
      allowInsecure: allowInsecure,
      username: username,
      password: password,
      ssl: ssl,
      ignoreBadCertificate: ignoreBadCertificate,
    );
    final message = Message()
      ..from = Address(username, name)
      ..recipients.add(Utils.recipientsMail)
      ..subject = Utils.recipientsSubject
      ..text = "Rating: $_rating\nFeedback Message: $feedbacktext";

    try {
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("FeedBack send successful")));
    } on MailerException catch (e) {
      for (var p in e.problems) {}
    }
  }

  feedbackToast(BuildContext context) {
    Fluttertoast.showToast(
        msg: "Feedback message has been sent successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  validationchack(BuildContext context) {
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      feedbacksend();
      feedbackToast(context);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "FeedBack",
          style: Utils.postListAppbarText,
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                  print(rating);
                },
              ),
            ),
            Text(
              "Rating: $_rating",
              style: GoogleFonts.lato(),
            ),
            Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  onSaved: (newValue) {
                    setState(() {
                      feedbacktext = newValue;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Write Something";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Tell us your opinion",
                      hintStyle: Utils.categorySearchhintText),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                validationchack(context);
              },
              color: Colors.blueAccent,
              child: Text(
                "Send FeedBack",
                style: GoogleFonts.lato(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
