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
  TextEditingController txtSearch = TextEditingController();
  HomeProvider? providerR;
  HomeProvider? providerW;
  ScrollController scrollController = ScrollController();
  WallpaperModel? model;

  @override
  void initState() {
    super.initState();

    context.read<HomeProvider>().getWallpaperData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<HomeProvider>().changePage();
      }
    });
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "search",
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    model!.hitsList!.clear();
                    providerR!.searchImage(txtSearch.text);
                  },
                  icon: const Icon(Icons.search),

                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
              ),
              controller: txtSearch,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: providerW!.model,
              builder: (context, snapshot) {
                model = snapshot.data;
                providerW!.wallpaper.addAll(model!.hitsList!);
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
                    controller: scrollController,
                    itemCount: providerW!.wallpaper.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      if (index < providerW!.wallpaper.length) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'wallpaper',
                                  arguments: model!.hitsList![index]);
                            },
                            child: Image.network(
                              providerW!.wallpaper[index].previewURL!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
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
