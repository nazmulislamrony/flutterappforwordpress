import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterandroidappforwordpress/models/latest_post.dart';
import 'package:flutterandroidappforwordpress/models/latest_post_details_model.dart';
import 'package:flutterandroidappforwordpress/models/post_details_model.dart';
import 'package:flutterandroidappforwordpress/models/post_model.dart';
import 'package:flutterandroidappforwordpress/models/search_post_model.dart';
import 'package:flutterandroidappforwordpress/models/searchpost_details_model.dart';
import '../utils/utils.dart';

class Postprovider extends ChangeNotifier {
  bool isloading = false;
  bool loadmoredata = false;
  bool searchpostloading = false;
  LatestPostdetails? latestPostdetails;
  List<LatestPostData> latestpost = [];
  List<Postdata> postdata = [];
  List<SearchPost> searchpost = [];
  PostDetails? postDetails;
  SearchPostDetails? searchPostDetails;

  Future getpost(int subcategoryid, int perpage) async {
    isloading = true;
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/posts?categories=${subcategoryid}&_fields[]=id&per_page=${perpage}&_fields[]=title&_fields[]=yoast_head_json.og_image&_fields[]=";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      isloading = false;
      var jsondata = response.body;
      postdata = postdataFromJson(jsondata);

      notifyListeners();
      return postdata;
    }
  }

  loadingmoredata(bool _loading) {
    loadmoredata = _loading;
    notifyListeners();
  }

  Future<PostDetails?> getpostdetails(int postid) async {
    isloading = true;
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      isloading = false;
      notifyListeners();
      return postDetails;
    }
  }

  Future<PostDetails?> firstpostdetails() async {
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/posts/23063?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      notifyListeners();
      return postDetails;
    }
  }

  Future<List<SearchPost>?> getsearchpost(String keyword) async {
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/search?search=${keyword}&_fields[]=id&_fields[]=title";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      searchpost = searchPostFromJson(jsondata);
      notifyListeners();
      return searchpost;
    }
  }

  Future<SearchPostDetails?> getsearchpostdetails(int postid) async {
    searchpostloading = true;
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/posts/${postid}?_fields[]=id&per_page=1&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=link&_fields[]=";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      searchPostDetails = searchPostDetailsFromJson(response.body);
      searchpostloading = false;
      notifyListeners();
      return searchPostDetails;
    }
  }

  Future getlatestpost() async {
    isloading = true;
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/posts?per_page=5&_fields[]=id&_fields[]=title&_fields[]=yoast_head_json.og_image";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      latestpost = latestPostDataFromJson(response.body);
      isloading = false;
      // connectivityCheck();
      notifyListeners();
    } else {
      connectivityCheck();
      notifyListeners();
    }
  }

  Future getlatestpostdetails(int postid) async {
    String url =
        "${Utils.wordpressSiteUrl}wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      latestPostdetails = latestPostDetailsFromJson(jsondata);
      notifyListeners();
    }
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
