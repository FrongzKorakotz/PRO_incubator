class Logmodel {
  int idColumn;
  String timeColumn;
  String tempColumn;
  String humidityColumn;

  Logmodel(
      {this.idColumn, this.timeColumn, this.tempColumn, this.humidityColumn});

  Logmodel.fromJson(Map<String, dynamic> json) {
    idColumn = json['idColumn'];
    timeColumn = json['timeColumn'];
    tempColumn = json['tempColumn'];
    humidityColumn = json['humidityColumn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idColumn'] = this.idColumn;
    data['timeColumn'] = this.timeColumn;
    data['tempColumn'] = this.tempColumn;
    data['humidityColumn'] = this.humidityColumn;
    return data;
  }
}
