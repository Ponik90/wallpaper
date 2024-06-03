class WallpaperModel {
  int? total, totalHits;
  List<HitsModel>? hitsList = [];

  WallpaperModel({this.total, this.totalHits, this.hitsList});

  factory WallpaperModel.mapToModel(Map m1) {
    List l1 = m1['hits'];
    return WallpaperModel(
        hitsList: l1.map((e) => HitsModel.mapToModel(e)).toList(),
        total: m1['total'],
        totalHits: m1['totalHits'],);
  }
}

class HitsModel {
  String? largeImageURL, previewURL, tags;

  HitsModel({this.largeImageURL, this.previewURL, this.tags});

  factory HitsModel.mapToModel(Map m1) {
    return HitsModel(
        largeImageURL: m1['largeImageURL'],
        previewURL: m1['previewURL'],
        tags: m1['tags'],);
  }
}
