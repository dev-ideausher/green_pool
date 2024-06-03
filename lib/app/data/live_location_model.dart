class LiveLocationModel {
  double? latitude;
  double? longitude;
  double? heading;
  LiveLocationModel({this.latitude, this.longitude,this.heading});

  factory LiveLocationModel.fromMap(Map<String, dynamic> map) {
    double parsedHeading = double.tryParse(map['heading'].toString()) ?? 0.0;
    double finalHeading = (parsedHeading == -1) ? 0.0 : parsedHeading;
    return LiveLocationModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
      heading: finalHeading,
    );
  }
}
