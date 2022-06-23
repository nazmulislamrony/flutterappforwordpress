// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterandroidappforwordpress/Provider/category_provider.dart';
import 'package:flutterandroidappforwordpress/helper/utils.dart';
import 'package:flutterandroidappforwordpress/pages/post_page.dart';

class CategoryPage extends StatefulWidget {
  final int categoryid;
  final String categoryname;
  final String sitename;
  const CategoryPage({
    Key? key,
    required this.categoryid,
    required this.categoryname,
    required this.sitename,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  double crossAxisSpacing = 8, mainAxisSpacing = 8, aspectRatio = 2;
  int crossAxisCount = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return category.subcategory!.isEmpty
        ? PostPage(
            sitename: widget.sitename,
            categoryid: widget.categoryid,
            categoryname: widget.categoryname)
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                widget.categoryname,
                style: Utils.enPostListAppbarText,
              ),
            ),
            body: category.loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: category.subcategory!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                // height: 80,
                                // width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostPage(
                                                  sitename: widget.sitename,
                                                  categoryid: category
                                                      .subcategory![index].id!,
                                                  categoryname: category
                                                      .subcategory![index]
                                                      .name!)));
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        Utils.categoryicon,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Flexible(
                                child: Text(
                                  category.subcategory![index].name!,
                                  textAlign: TextAlign.center,
                                  style: Utils.enListTitleCategory,
                                  // maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          );
  }
}
