import 'package:flutter/material.dart';
import 'package:wallpaper/screen/home/model/home_model.dart';
import 'package:wallpaper/utils/helper/api_helper.dart';

class HomeProvider with ChangeNotifier {
  Future<WallpaperModel?>? model;
  String search = "car";
  int page = 1;
  int changeWallpaper = 0;
  List<HitsModel> wallpaper = [];

  void searchImage(String s) {
    search = s;
    wallpaper.clear();
    getWallpaperData();
  }

  void changePage() {
    if(wallpaper.length==page*20)
      {
        page++;
        wallpaper.clear();
        getWallpaperData();
      }
  }

  void getWallpaperData() {
    ApiHelper helper = ApiHelper();

    model = helper.getWallpaperApi(q: search, page: page);
    model!.then((value) {
      if (value != null) {
        notifyListeners();
      }
    });
  }
}
