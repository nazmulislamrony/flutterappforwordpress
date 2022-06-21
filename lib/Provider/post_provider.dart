// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutterandroidappforwordpress/model/Latest_Post_Model/latest_post.dart';
import 'package:flutterandroidappforwordpress/model/Latest_Post_Model/latest_post_details_model.dart';
import 'package:flutterandroidappforwordpress/model/post_details_model.dart';
import 'package:flutterandroidappforwordpress/model/post_model.dart';
import 'package:flutterandroidappforwordpress/model/search_post_model.dart';
import 'package:flutterandroidappforwordpress/model/searchpost_details_model.dart';

class Postprovider extends ChangeNotifier {
  bool isloading = false;
  bool loadmoredata = false;
  bool searchpostloading = false;
  int voltagelabsavepostbadge = 0;
  int voltagelabpostcount = 0;
  int? polytechnicsavepostbadge;
  int polytechnicpostcount = 0;
  LatestPostdetails? latestPostdetails;
  List<LatestPostData> voltagelablatestpost = [];
  List<Postdata> postdata = [];
  List<SearchPost> searchpost = [];
  PostDetails? postDetails;
  SearchPostDetails? searchPostDetails;

  Future getpost(int subcategoryid, int perpage, String sitename) async {
    if (sitename == 'voltagelab') {
      isloading = true;
      String url =
          "https://voltagelab.com/wp-json/wp/v2/posts?categories=${subcategoryid}&_fields[]=id&per_page=${perpage}&_fields[]=title&_fields[]=yoast_head_json.og_image&_fields[]=";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        isloading = false;
        var jsondata = response.body;
        postdata = postdataFromJson(jsondata);

        notifyListeners();
        return postdata;
      }
    } else if (sitename == 'polytechnicbd') {
      get_en_voltagelabpost(subcategoryid, perpage);
    }
  }

  loadingmoredata(bool _loading) {
    loadmoredata = _loading;
    notifyListeners();
  }



  //bangla voltage lab post details................................................
  Future<PostDetails?> getpostdetails(int postid, String sitename) async {
    if (sitename == 'voltagelab') {
      isloading = true;
      String url =
          "https://voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        postDetails = postDetailsFromJson(jsondata);
        isloading = false;
        notifyListeners();
        return postDetails;
      }
    } else if (sitename == 'polytechnicbd') {
      print("bdcsabdh${sitename}");
      await get_en_voltagelabpostdetails(postid);
    }
  }

  //bangla voltagelab fast post details...............................................................
  Future<PostDetails?> firstpostdetails() async {
    String url =
        "https://voltagelab.com/wp-json/wp/v2/posts/23063?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      notifyListeners();
      return postDetails;
    }
  }

  //bangla voltagelab search post................................................
  Future<List<SearchPost>?> getsearchpost(
      String keyword, String sitename) async {
    if (sitename == 'voltagelab') {
      String url =
          "https://voltagelab.com/wp-json/wp/v2/search?search=${keyword}&_fields[]=id&_fields[]=title";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        searchpost = searchPostFromJson(jsondata);
        notifyListeners();
        return searchpost;
      }
    } else if (sitename == 'polytechnicbd') {
      await en_voltagelabsearchpost(keyword);
    }
  }

  //bangla voltagelab search post details................................................

  Future<SearchPostDetails?> getsearchpostdetails(
      int postid, String sitename) async {
    if (sitename == 'voltagelab') {
      searchpostloading = true;
      String url =
          "https://voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=id&per_page=1&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=link&_fields[]=";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        searchPostDetails = searchPostDetailsFromJson(response.body);
        searchpostloading = false;
        notifyListeners();
        return searchPostDetails;
      }
    } else if (sitename == 'polytechnicbd') {
      await en_voltagelabsearchpostdetails(postid);
    }
  }

  //bangla voltagelab Latest post................................................
  Future getvoltagelablatestpost() async {
    isloading = true;
    String url =
        "https://voltagelab.com/wp-json/wp/v2/posts?per_page=5&_fields[]=id&_fields[]=title&_fields[]=yoast_head_json.og_image";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      voltagelablatestpost = latestPostDataFromJson(response.body);
      isloading = false;
      // connectivityCheck();
      notifyListeners();
    } else {
      connectivityCheck();
      notifyListeners();
    }
  }

  //bangla voltagelab Latest post details................................................
  Future getlatestpostdetails(int postid) async {
    String url =
        "https://voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      latestPostdetails = latestPostDetailsFromJson(jsondata);
      notifyListeners();
    }
  }

  // english https://www.voltagelab.com/ get post..........................................
  Future get_en_voltagelabpost(int subcategoryid, int perpage) async {
    isloading = true;
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/posts?categories=${subcategoryid}&_fields[]=id&per_page=${perpage}&_fields[]=title&_fields[]=yoast_head_json.og_image&_fields[]=";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      isloading = false;
      var jsondata = response.body;
      postdata = postdataFromJson(jsondata);

      notifyListeners();
      return postdata;
    }
  }

  //english https://www.voltagelab.com/ get post details..........................................
  Future get_en_voltagelabpostdetails(int postid) async {
    isloading = true;
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      isloading = false;
      notifyListeners();
      return postDetails;
    } else {
      isloading = false;
      notifyListeners();
    }
  }

  // Enflish https://www.voltagelab.com/ search post................................................
  Future<List<SearchPost>?> en_voltagelabsearchpost(String keyword) async {
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/search?search=${keyword}&_fields[]=id&_fields[]=title";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      searchpost = searchPostFromJson(jsondata);
      notifyListeners();
      return searchpost;
    }
  }

//https://www.voltagelab.com/ searchpost details
  Future<SearchPostDetails?> en_voltagelabsearchpostdetails(int postid) async {
    searchpostloading = true;
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=id&per_page=1&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=link&_fields[]=";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      searchPostDetails = searchPostDetailsFromJson(response.body);
      searchpostloading = false;
      notifyListeners();
      return searchPostDetails;
    }
  }


  getpostcount() {
    var box = Hive.box('voltagelabbadge');
    voltagelabsavepostbadge = box.get('count') ?? 0;
    notifyListeners();
  }



  get_en_voltagelabpostcount() {
    var box = Hive.box('Polytechnicbadge');
    polytechnicsavepostbadge = box.get('count') ?? 0;
    notifyListeners();
  }

  bool? isInternet;
  Future connectivityCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isInternet = true;
      notifyListeners();
    } else {
      isInternet = false;
    }
  }
}
