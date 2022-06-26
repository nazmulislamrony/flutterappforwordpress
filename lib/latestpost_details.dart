import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutterandroidappforwordpress/Provider/post_provider.dart';
import 'package:flutterandroidappforwordpress/helper/utils.dart';
import 'package:flutterandroidappforwordpress/web_View/web_view.dart';

class LatestPostDetails extends StatefulWidget {
  final int latestpostid;
  final String latestposttitle;

  final String latestpostpic;

  const LatestPostDetails(
      {Key? key,
      required this.latestpostid,
      required this.latestposttitle,
      required this.latestpostpic})
      : super(key: key);

  @override
  _LatestPostDetailsState createState() => _LatestPostDetailsState();
}

class _LatestPostDetailsState extends State<LatestPostDetails> {
  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false)
        .getlatestpostdetails(widget.latestpostid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    double expanded_heigth = 300;
    double round_container_heigth = 50;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              // widget.latestposttitle,
              widget.latestposttitle,
              style: Utils.entitleCarosal,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    postshare(context, post.postDetails!.link);
                  },
                  icon: const Icon(Icons.share)),
            ],
          ),
          //       SliverPersistentHeader(
          // delegate: DetailsSliverdelegate(
          //     expendedheigth: expanded_heigth,
          //     photourl: widget.latestpostpic,
          //     round_container: round_container_heigth)),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.latestpostpic,
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
                      widget.latestposttitle,
                      style:   Utils.postListAppbarText),
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: post.latestPostdetails == null
                  ? SizedBox(
                      height: 300,
                      child: Center(
                        child:
                            Text("Loading........", style: GoogleFonts.lato()),
                      ),
                    )
                  : Html(
                      data: post.latestPostdetails!.content.rendered,
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
                        // "p": Style(fontSize: FontSize(textsize.textsize), fontFamily: 'SolaimanLipi', letterSpacing: 1.0),

                        "p": Style(
                            fontSize: FontSize(18),
                            fontFamily: 'Lato-Regular',
                            lineHeight: LineHeight(2)),
                        "li": Style(
                            fontSize: FontSize(18),
                            fontFamily: 'Lato-Regular',
                            ),
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
}

class DetailsSliverdelegate extends SliverPersistentHeaderDelegate {
  final double expendedheigth;
  final String photourl;
  final double round_container;

  const DetailsSliverdelegate(
      {required this.photourl,
      required this.expendedheigth,
      required this.round_container});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.network(
          //   photourl,
          //   width: MediaQuery.of(context).size.width,
          //   height: expendedheigth,
          //   fit: BoxFit.cover,
          // ),
          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: photourl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: expendedheigth,
          ),
          Positioned(
            top: expendedheigth - round_container + 25 - shrinkOffset,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: round_container - 10,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expendedheigth;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
