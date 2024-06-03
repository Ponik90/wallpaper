import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/screen/home/model/home_model.dart';
import 'package:wallpaper/screen/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  void initState() {
    super.initState();

    context.read<HomeProvider>().getWallpaperData();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper "),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: providerW!.model,
              builder: (context, snapshot) {
                WallpaperModel? model = snapshot.data;

                if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off),
                        Text("There is something want to wrong"),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: model!.hitsList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(model.hitsList![index].previewURL!);
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
