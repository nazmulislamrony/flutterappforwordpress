import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static const wordpressSiteUrl = "https://voltagelab.com/";

  // link and string globally
  static const contactNumber = "+1";
  static const fromWhere = "VoltageLab";
  static const appName = "WordPress for Flutter";
  static const categorylist = "Category List";
  static const webivewurl = "https://voltagelab.com/";
  static const fbProtocolUrlios = 'fb://profile/voltagelabbd';
  static const fbProtocolUrlandroid = 'fb://page/voltagelabbd';
  static const fbFallBackUrl = 'https://www.facebook.com/voltagelabbd';
  static const playtoreUrl =
      'https://play.google.com/store/apps/details?id=org.voltagelab';
  static const yourContactMail = "voltagelabbd@gmail.com";
  static const articleShareSubject = "Voltage Lab";
  static const postShareSubject = "Voltage Lab";

  // Image icon
  static const splashicon = "images/splash.png";
  static const categoryicon = "images/category_icon.png";


  //SMTP server feedback
  static const hostName = ''; // site.com - mail server hostname
  static const port = 0; // 554 - mail server port put here
  static const nameShowInMail = ''; // [APP]Voltage Lab -  mail server hostname
  static const smtpUsername = ''; // put smtp username
  static const smtpPassword = ''; // put smtp password
  // recipients info
  static const recipientsMail = ''; // your mail where user email will be send
  static const recipientsSubject =
      ''; // your mail where user email will be send
  static const defaultFont =
      'Lato-Regular'; // your mail where user email will be send
  // font change
  static TextStyle titleOfList = GoogleFonts.hindSiliguri(
      color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle categorytitleOfAppbar = GoogleFonts.lato(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
  static TextStyle titleCarosal = GoogleFonts.lato(
      color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500);
  static TextStyle titleName = GoogleFonts.lato(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);
  static var bottomSelectedNavText = GoogleFonts.lato(
      color: defaultColor, fontSize: 16.0, fontWeight: FontWeight.bold);
  static TextStyle gridTitleName = GoogleFonts.lato(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);
  static var bottomUnselectedNavText =
      GoogleFonts.hindSiliguri(color: defaultColor, fontSize: 13.0);
  static TextStyle subscriptionFeatureText = GoogleFonts.lato(
      color: defaultColor, fontSize: 20.0, fontWeight: FontWeight.w600);
  static TextStyle gridtopfont = GoogleFonts.lato(
      color: Colors.black45, fontSize: 12.0, fontWeight: FontWeight.normal);

  static TextStyle categorySearchhintText = GoogleFonts.lato(
      color: Colors.black45, fontSize: 16.0, fontWeight: FontWeight.normal);
  static TextStyle listTitleCategory = GoogleFonts.lato(
      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal);
  static TextStyle entitleCarosal = GoogleFonts.lato(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static TextStyle listTitleText = GoogleFonts.lato(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600);
  static TextStyle categoryTitleText = GoogleFonts.lato(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);
  static TextStyle alertText = GoogleFonts.lato(
      color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal);
  static TextStyle postListAppbarText = GoogleFonts.lato(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500);
  static Color defaultColor = const Color.fromRGBO(0, 116, 255, 1);
  static Color appBarColor = Colors.white;
  static Color backgroundColor = Colors.blue.shade50;
}
