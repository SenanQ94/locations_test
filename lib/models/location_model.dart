class LocationModel {
  String? id;
  String? name;
  List<dynamic>? coord;
  String? type;
  int? matchQuality;
  bool? isBest;
  Map<String, dynamic>? parent;

  LocationModel({
    this.id,
    this.name,
    this.coord,
    this.type,
    this.matchQuality,
    this.isBest,
    this.parent,
  });

  LocationModel.getJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'];
    type = json['type'];
    matchQuality = json['matchQuality'];
    isBest = json['isBest'];
    parent = json['parent'];
  }
}
