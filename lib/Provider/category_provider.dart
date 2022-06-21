import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterandroidappforwordpress/model/En_voltagelab/en_vl_category.dart';
import 'package:flutterandroidappforwordpress/model/En_voltagelab/en_vl_db_free_category.dart';
import 'package:flutterandroidappforwordpress/model/Voltage_Lab/category_model.dart';
import 'package:flutterandroidappforwordpress/model/Voltage_Lab/vl_database_free_category.dart';
import 'package:flutterandroidappforwordpress/model/subcategory.dart';


class CategoryProvider extends ChangeNotifier {
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory>? subcategory = [];

  List<VlDbFreeCategory> vl_db_free_category = [];
  List<EnVlDbFreeCategory> en_vl_db_free_category = [];
  List<En_voltagelabCategory> en_voltagelabcategorylist = [];
  bool loading = false;


  //bangla voltagelap main category.....................................
  Future get_bn_vl_free_category() async {
    //15,16,5323,1741,2908,92,1800
    String url =
        "https://voltagelab.com/wp-json/wp/v2/categories?_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      category = categoriesFromJson(jsondata);
      notifyListeners();
      return category;
    }
  }

  //bangla voltagelap sub category.....................................
  Future getsubcategory(int categoryid, String sitename) async {
    if (sitename == 'voltagelab') {
      loading = true;
      String url =
          "https://voltagelab.com/wp-json/wp/v2/categories?parent=${categoryid}&per_page=50&_fields[]=id&_fields[]=name";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        subcategory = subCategoryFromJson(jsondata);
        loading = false;

        notifyListeners();
        return subcategory;
      }
    } else if (sitename == 'polytechnicbd') {
      await en_voltagelabsubcategory(categoryid);
    }
  }

  setcategoryindex(int index) {
    categoryindex = index;
    notifyListeners();
  }


  // english https://www.voltagelab.com/ main category.............................................

  Future en_voltagelabsubcategory(int categoryid) async {
    subcategory!.clear();
    loading = true;
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/categories?parent=${categoryid}&_fields[]=id&_fields[]=name";
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
