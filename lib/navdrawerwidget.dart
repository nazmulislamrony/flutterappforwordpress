import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterandroidappforwordpress/drawerhelper.dart';
import 'package:flutterandroidappforwordpress/listcategory_page.dart';
import 'package:flutterandroidappforwordpress/pages/contact_form.dart';
import 'package:flutterandroidappforwordpress/pages/feedback.dart';
import 'package:flutterandroidappforwordpress/pages/homepage.dart';
import 'package:flutterandroidappforwordpress/web_View/web_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'helper/utils.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 10);
    String imgloc = 'images/category_icon.png';
    String nameApp = 'WordPress in Flutter';

    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: padding,
          children: [
            buildHeader(contxt: context, name: nameApp, images: imgloc),
            const SizedBox(
              height: 10.0,
            ),
            dividerContainer(),
            const SizedBox(
              height: 10.0,
            ),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            buildMenuItem(
              text: 'Web View',
              icon: Icons.web,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 10.0,
            ),
            buildMenuItem(
              text: 'Facebook Connect',
              icon: Icons.facebook,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: 'Rating',
              icon: Icons.star,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 10.0,
            ),

            buildMenuItem(
              text: 'Contact Us',
              icon: Icons.contact_mail,
              onClicked: () => selectedItem(context, 4),
            ),

            const SizedBox(
              height: 60.0,
            ),
            dividerContainer(),
            // Divider(
            //   color: DrawerHelper.defaultColor,
            // ),

            buildMenuItem(
              text: 'Share',
              icon: Icons.share,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(
              height: 10.0,
            ),
            buildMenuItem(
              text: 'Help and Feedback',
              icon: Icons.help,
              onClicked: () => selectedItem(context, 6),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final hoverColor = Colors.blueAccent;
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: Colors.blue,
      ),
      title: Text(text,
          style:
              GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 17)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ListcategoryPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const WebViewPage(url: Utils.webivewurl),
        ));
        break;
      case 2:
        fbOpen();
        break;
      case 3:
        _launchURL(Utils.playstoreUrl);
        break;
      case 4:
        final snackBar = SnackBar(content: Text("$i"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ContactForm(),
        ));
        break;
      case 5:
        Share.share(Utils.playstoreUrl, subject: Utils.appame);
        break;
      case 6:
        final snackBar = SnackBar(content: Text("$i"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const FeedBackPage()));
        break;
    }
  }

  Widget buildHeader({
    required BuildContext contxt,
    required var images,
    required String name,
  }) {
    return Container(
        margin: EdgeInsets.only(top: 30, left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset(
                    images,
                    height: 50,
                    fit: BoxFit.fill,
                    width: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(name,
                      // style: GoogleFonts.openSans()
                      style: GoogleFonts.balsamiqSans(
                          textStyle: Theme.of(contxt).textTheme.headline6,
                          color: Colors.black87,
                          fontSize: 23,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ));
  }

  Widget dividerContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        color: DrawerHelper.defaultColor,
      ),
    );
  }

  Future<void> fbOpen() async {
    Uri fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = Uri.parse(Utils.fbProtocolUrlios);
    } else {
      fbProtocolUrl = Uri.parse(Utils.fbProtocolUrlandroid);
    }

    Uri fallbackUrl = Uri.parse(Utils.fbFallBackUrl);

    try {
      bool launched = await launchUrl(fbProtocolUrl);

      if (!launched) {
        await launchUrl(fallbackUrl);
      }
    } catch (e) {
      await launchUrl(fallbackUrl);
    }
  }

  _launchURL(String url) async {
    Uri urlLink = Uri.parse(url);
    if (await launchUrl(urlLink)) {
      await launchUrl(urlLink);
    }
    else {
      throw 'Could not launch $urlLink';
    }
  }
}
