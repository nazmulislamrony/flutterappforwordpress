import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutterandroidappforwordpress/navdrawerwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutterandroidappforwordpress/helper/utils.dart';
import 'package:flutterandroidappforwordpress/Provider/category_provider.dart';
import 'package:flutterandroidappforwordpress/Provider/post_provider.dart';
import 'package:flutterandroidappforwordpress/Screen/En_voltagelab/listcategory_page.dart';
import 'package:flutterandroidappforwordpress/latestpost_details.dart';
import 'package:flutterandroidappforwordpress/listcategory_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool switchbtn = false;
  bool lock = true;

  // parmissionhandeler() async {
  //   var status = await Permission.storage.status;
  //   if (status.isDenied) {
  //     await Permission.storage.request();
  //   } else {}
  // }

  Widget freegridviewtool({
    Icon? icon,
    GestureTapCallback? onTap,
    String? name,
    Color? color,
    String? gridTopText}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade100,
          blurRadius: 5.0,
          spreadRadius: 2.0,
          offset: Offset(
            1.0, // horizontal, move right 10
            5.0, // vertical, move down 10
          ),
        )
      ], borderRadius: BorderRadius.circular(24), color: color),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: double.infinity,
                  child: icon,
                )),
            Positioned(
                top: 0,
                right: 10,
                child: Text(gridTopText.toString(), style: Utils.gridtopfont)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(name!, style: Utils.gridTitleName)),
            )
          ],
        ),
      ),
    );
  }


  Future<void> onrefreshlist() async {
    final post = Provider.of<Postprovider>(context, listen: false);
    await Future.delayed(
      Duration(seconds: 5),
          () {
        // Provider.of<>(context, listen: false).getallmybook();
        post.connectivityCheck();
      },
    );
  }

  @override
  void initState() {
    // parmissionhandeler();
    Provider.of<Postprovider>(context, listen: false).getvoltagelablatestpost();
    Provider.of<CategoryProvider>(context, listen: false)
        .get_bn_vl_free_category();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              "Hi",
              style: Utils.titleName,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    playStoreRating();
                  },
                  icon: Icon(
                    Icons.feedback,
                    color: Utils.defaultColor,
                  ))
            ],
          ),

          SliverToBoxAdapter(
            child: post.voltagelablatestpost.isEmpty
                ? SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            )
                : Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08,
              child: CarouselSlider.builder(
                  itemCount: post.voltagelablatestpost.length,
                  itemBuilder: (context, index, realIndex) {
                    var latestpost = post.voltagelablatestpost[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LatestPostDetails(
                                      latestpostid: latestpost.id!,
                                      latestposttitle:
                                      latestpost.title!.rendered,
                                      latestpostpic: latestpost
                                          .yoastHeadJson!.ogImage[0].url!,
                                    )));
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          latestpost.title!.rendered,
                          style: Utils.titleCarosal,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    pageSnapping: false,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
                    aspectRatio: 0,
                  )),
            ),
          ),

          SliverToBoxAdapter(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    childAspectRatio: 3 / 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    freegridviewtool(
                      color: Colors.white,
                      icon: Icon(
                        Icons.chrome_reader_mode_outlined,
                        color: Utils.defaultColor,
                        size: 30,
                      ),
                      name: "পড়াশুনা",
                      gridTopText: "বাংলা",
                      onTap: () {
                        post.getpostcount();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListcategoryPage(),
                            ));
                      },
                    ),
                    freegridviewtool(
                      color: Colors.white,
                      icon: Icon(
                        Icons.chrome_reader_mode_outlined,
                        color: Utils.defaultColor,
                        size: 30,
                      ),
                      name: "পড়াশুনা",
                      gridTopText: "ইংরেজি",
                      onTap: () {
                        post.get_en_voltagelabpostcount();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const En_voltagelabListcategoryPage(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  playStoreRating() {
    try {
      launch("market://details?id=" + "org.voltagelab");
    } on PlatformException catch (e) {
      launch(
          "https://play.google.com/store/apps/details?id=" + "org.voltagelab");
    } finally {
      launch(
          "https://play.google.com/store/apps/details?id=" + "org.voltagelab");
    }
  }
}
