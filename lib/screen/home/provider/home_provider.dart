import 'package:flutter/material.dart';
import 'package:wallpaper/screen/home/model/home_model.dart';
import 'package:wallpaper/utils/helper/api_helper.dart';

class HomeProvider with ChangeNotifier {
  Future<WallpaperModel?>? model;

  void getWallpaperData() {
    ApiHelper helper = ApiHelper();

    model = helper.getWallpaperApi();
  }
}
