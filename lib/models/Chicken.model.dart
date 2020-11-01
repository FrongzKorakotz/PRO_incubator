class ChickenModel {
  String name, detail, pathpic;

  ChickenModel(this.name, this.detail, this.pathpic);

  ChickenModel.fromMap(Map<String, dynamic> map) {
    name = map['Name'];
    detail = map['Detail'];
    pathpic = map['Pathpic'];
  }
}
