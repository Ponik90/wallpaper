import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/screen/home/provider/home_provider.dart';
import 'package:wallpaper/utils/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: screen,
      ),
    ),
  );
}
