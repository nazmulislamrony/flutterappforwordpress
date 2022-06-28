import 'package:flutter/material.dart';
import 'package:flutterandroidappforwordpress/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutterandroidappforwordpress/models/category_model.dart';
import 'package:flutterandroidappforwordpress/models/subcategory.dart';


class CategoryProvider extends ChangeNotifier {
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory>? subcategory = [];
  bool loading = false;

  Future getCategory() async {
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/categories?_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      category = categoriesFromJson(jsondata);
      notifyListeners();
      return category;
    }
  }

  Future getsubcategory(int categoryid) async {
      loading = true;
      String url =
          "${Utils.wordpressSiteUrl}wp-json/wp/v2/categories?parent=${categoryid}&per_page=50&_fields[]=id&_fields[]=name";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        subcategory = subCategoryFromJson(jsondata);
        loading = false;

        notifyListeners();
        return subcategory;
      }
  }
}
