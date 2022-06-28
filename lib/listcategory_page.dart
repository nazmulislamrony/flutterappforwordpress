import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterandroidappforwordpress/latestpost_details.dart';
import 'package:flutterandroidappforwordpress/navdrawerwidget.dart';
import 'package:provider/provider.dart';
import 'package:flutterandroidappforwordpress/provider/category_provider.dart';
import 'package:flutterandroidappforwordpress/provider/post_provider.dart';
import 'package:flutterandroidappforwordpress/utils/utils.dart';
import 'package:flutterandroidappforwordpress/pages/categories_page.dart';
import 'package:flutterandroidappforwordpress/pages/search_page.dart';

class ListcategoryPage extends StatefulWidget {
  const ListcategoryPage({Key? key}) : super(key: key);

  @override
  _ListcategoryPageState createState() => _ListcategoryPageState();
}

class _ListcategoryPageState extends State<ListcategoryPage> {
  int? categoryindex;
  bool subcategoryshow = false;

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false).firstpostdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            title: Text(
              Utils.categorylist,
              style: Utils.categorytitleOfAppbar,
            ),
          ),
          _latestPostCarousel(post),
          _searchBox(),
          _categoryItem(category)
        ],
      ),
    );
  }

  Widget _latestPostCarousel(Postprovider post) {
    return SliverToBoxAdapter(
      child: post.latestpost.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: CarouselSlider.builder(
                  itemCount: post.latestpost.length,
                  itemBuilder: (context, index, realIndex) {
                    var latestpost = post.latestpost[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LatestPostDetails(
                                      latestpostid: latestpost.id!,
                                      latestposttitle:
                                          latestpost.title!.rendered,
                                      latestpostpic: latestpost
                                          .yoastHeadJson!.ogImage[0].url!,
                                    )));
                      },
                      // borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Colors.indigoAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.all(0),
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
                    height: MediaQuery.of(context).size.height * 0.08,
                    aspectRatio: 0,
                  )),
            ),
    );
  }

  Widget _searchBox() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                              width: 0,
                            )),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                                width: 0, color: Colors.transparent)),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                                width: 0, color: Colors.transparent)),
                        hintText: "Search any topic",
                        hintStyle: Utils.categorySearchhintText,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(CategoryProvider category) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Color color =
                Colors.primaries[Random().nextInt(Colors.primaries.length)];
            return Container(
              margin: EdgeInsets.only(
                  left: index % 2 == 0 ? 15 : 10,
                  bottom: 15,
                  right: index % 2 != 0 ? 15 : 10),
              decoration: BoxDecoration(
                  // color: color.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(40)),
              child: InkWell(
                onTap: () {
                  Provider.of<CategoryProvider>(context, listen: false)
                      .getsubcategory(category.category[index].id!);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          categoryid: category.category[index].id!,
                          categoryname: category.category[index].name!,
                        ),
                      ));
                },
                borderRadius: BorderRadius.circular(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // height: 80,
                      // width: 80,
                      decoration: BoxDecoration(
                        // color: color,
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          Utils.categoryicon,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        category.category[index].name!,
                        overflow: TextOverflow.ellipsis,
                        style: Utils.listTitleCategory,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: category.category.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.98,
        ));
  }
}
