import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {

  // link and string globally

  static const contactNumber = "+1";
  static const fromWhere = "VoltageLab";
  static const appame = "WordPress for Flutter";
  static const categoryicon = "images/category_icon.png";
  static const categorylist = "Category List";
  static const splashicon = "images/splash.png";
  static const webivewurl = "https://voltagelab.com/";
  static const fbProtocolUrlios = 'fb://profile/voltagelabbd';
  static const fbProtocolUrlandroid= 'fb://page/voltagelabbd';
  static const fbFallBackUrl ='https://www.facebook.com/voltagelabbd';
  static const playtoreUrl ='https://play.google.com/store/apps/details?id=org.voltagelab';


  // font change globally
  static TextStyle titleOfList = GoogleFonts.hindSiliguri(
      color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle categorytitleOfAppbar = GoogleFonts.lato(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

  static TextStyle titleCarosal = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static TextStyle titleName = GoogleFonts.lato(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

  static var bottomSelectedNavText = GoogleFonts.hindSiliguri(
      color: defaultColor, fontSize: 16.0, fontWeight: FontWeight.bold);

  static TextStyle gridTitleName = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500);

  static var bottomUnselectedNavText =
      GoogleFonts.hindSiliguri(color: defaultColor, fontSize: 13.0);

  static TextStyle subscriptionFeatureText = GoogleFonts.hindSiliguri(
      color: defaultColor, fontSize: 20.0, fontWeight: FontWeight.w600);

  static TextStyle gridtopfont = GoogleFonts.hindSiliguri(
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

  static TextStyle postListAppbarText = GoogleFonts.hindSiliguri(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500);

  static Color defaultColor = Color.fromRGBO(0, 116, 255, 1);
  static Color appBarColor = Colors.white;
  static Color backgroundColor = Colors.blue.shade50;
}
