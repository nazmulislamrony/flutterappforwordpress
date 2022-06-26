import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutterandroidappforwordpress/Provider/otherprovider.dart';
import 'package:flutterandroidappforwordpress/Provider/post_provider.dart';
import 'package:flutterandroidappforwordpress/helper/utils.dart';
import 'package:flutterandroidappforwordpress/model/post_model.dart';
import 'package:flutterandroidappforwordpress/web_View/web_view.dart';

class PostDetailsPage extends StatefulWidget {
  final String categoryname;
  final int categoryid;
  final Postdata postdata;
  final String sitename;

  const PostDetailsPage(
      {Key? key,
      required this.postdata,
      required this.categoryname,
      required this.categoryid,
      required this.sitename})
      : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              widget.postdata.title!.rendered,
              style: Utils.postListAppbarText,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    postshare(context, post.postDetails!.link);
                  },
                  icon: const Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.postdata.yoastHeadJson!.ogImage[0].url!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.postdata.title!.rendered,
                      style: Utils.titleOfList,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: const Divider(),
            ),
          ),
          SliverToBoxAdapter(
            child: post.isloading
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        "Loading.......",
                        style: GoogleFonts.lato(),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Html(
                      data: post.postDetails!.content.rendered,
                      onLinkTap: (url, _, __, ___) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(url: url!),
                            ));
                      },
                      onImageTap: (url, context, attributes, element) {
                        CachedNetworkImage(imageUrl: url!);
                      },
                      style: {
                        "p": Style(
                            fontSize: FontSize(18),
                            fontFamily: 'Lato-Regular',
                            lineHeight: LineHeight(2)),
                        "li": Style(
                            fontSize: FontSize(18),
                            fontFamily: 'Lato-Regular',
                            lineHeight: LineHeight(1.8)),
                        // "alt": Style(fontSize: FontSize(textsize.textsize), fontFamily: 'SolaimanLipi'),
                        "strong": Style(
                            fontSize: FontSize(18), fontFamily: 'Lato-Regular'),
                        "h1": Style(
                            fontSize: FontSize(24), fontFamily: 'Lato-Regular'),
                        "h2": Style(
                            fontSize: FontSize(22), fontFamily: 'Lato-Regular'),
                        "h3": Style(
                            fontSize: FontSize(18), fontFamily: 'Lato-Regular'),
                        "h4": Style(
                            fontSize: FontSize(16), fontFamily: 'Lato-Regular'),
                        "h5": Style(
                            fontSize: FontSize(12), fontFamily: 'Lato-Regular'),
                        "h6": Style(
                            fontSize: FontSize(10), fontFamily: 'Lato-Regular')
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }

  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

}
