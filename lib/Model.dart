class Model {
  final String nm;
  final String dt;
  final String im;
  Model({this.dt, this.nm, this.im});

  Map<String, dynamic> toMap() {
    return {
      "name": this.nm,
      "detail": this.dt,
      "image": this.im,
    };
  }
}
