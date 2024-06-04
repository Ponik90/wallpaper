import 'package:flutter/material.dart';
import 'package:wallpaper/screen/home/view/home_screen.dart';
import 'package:wallpaper/screen/wallpaper/view/wallpaper_screen.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const HomeScreen(),
  'wallpaper': (context) =>  const WallpaperScreen(),
};
