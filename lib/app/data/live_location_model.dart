class LiveLocationModel {
  double? latitude;
  double? longitude;

  LiveLocationModel({this.latitude, this.longitude});

  factory LiveLocationModel.fromMap(Map<String, dynamic> map) {
    return LiveLocationModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
