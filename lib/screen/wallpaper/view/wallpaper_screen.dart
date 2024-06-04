import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/screen/home/model/home_model.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  Widget build(BuildContext context) {
    HitsModel model = ModalRoute.of(context)!.settings.arguments as HitsModel;
    return Scaffold(
      body: CachedNetworkImage(
        imageUrl: "${model.largeImageURL}",
        fit: BoxFit.cover,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AsyncWallpaper.setWallpaper(
            url: "${model.largeImageURL}",
            goToHome: true,
            toastDetails: ToastDetails.success(),
            errorToastDetails: ToastDetails.error(),
            wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
          );
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
