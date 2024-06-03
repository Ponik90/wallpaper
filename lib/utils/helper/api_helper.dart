import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper/screen/home/model/home_model.dart';

class ApiHelper {
  Future<WallpaperModel?> getWallpaperApi() async {
    String link =
        "https://pixabay.com/api/?key=44142118-05a4148a10ed4c05593397d77&q=car";

    var response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      WallpaperModel model = WallpaperModel.mapToModel(json);

      return model;
    }
    return null;
  }
}
