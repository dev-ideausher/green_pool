
// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names

class FindRideResponseModelDataDestination {
/*
{
  "name": "Bandra Terminus",
  "type": "Point",
  "coordinates": [
    72.84047029999999
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  FindRideResponseModelDataDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  FindRideResponseModelDataDestination.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <double>[];
      v.forEach((v) {
        arr0.add(v.toDouble());
      });
      coordinates = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    if (coordinates != null) {
      final v = coordinates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['coordinates'] = arr0;
    }
    return data;
  }
}

class FindRideResponseModelDataOrigin {
/*
{
  "name": "Andheri",
  "type": "Point",
  "coordinates": [
    72.8697339
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  FindRideResponseModelDataOrigin({
    this.name,
    this.type,
    this.coordinates,
  });
  FindRideResponseModelDataOrigin.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <double>[];
      v.forEach((v) {
        arr0.add(v.toDouble());
      });
      coordinates = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    if (coordinates != null) {
      final v = coordinates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['coordinates'] = arr0;
    }
    return data;
  }
}

class FindRideResponseModelData {
/*
{
  "origin": {
    "name": "Andheri",
    "type": "Point",
    "coordinates": [
      72.8697339
    ]
  },
  "destination": {
    "name": "Bandra Terminus",
    "type": "Point",
    "coordinates": [
      72.84047029999999
    ]
  },
  "_id": "65cf11b401e8048d2667d521",
  "riderId": "65c2400c32f497dc57fdf007",
  "date": "2024-02-16T00:00:00.000Z",
  "time": "10 A.M",
  "seatAvailable": 1,
  "createdAt": "2024-02-16T07:41:40.422Z",
  "updatedAt": "2024-02-16T07:41:40.422Z"
} 
*/

  FindRideResponseModelDataOrigin? origin;
  FindRideResponseModelDataDestination? destination;
  String? Id;
  String? riderId;
  String? date;
  String? time;
  int? seatAvailable;
  String? createdAt;
  String? updatedAt;

  FindRideResponseModelData({
    this.origin,
    this.destination,
    this.Id,
    this.riderId,
    this.date,
    this.time,
    this.seatAvailable,
    this.createdAt,
    this.updatedAt,
  });
  FindRideResponseModelData.fromJson(Map<String, dynamic> json) {
    origin = (json['origin'] != null)
        ? FindRideResponseModelDataOrigin.fromJson(json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? FindRideResponseModelDataDestination.fromJson(json['destination'])
        : null;
    Id = json['_id']?.toString();
    riderId = json['riderId']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    seatAvailable = json['seatAvailable']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    data['_id'] = Id;
    data['riderId'] = riderId;
    data['date'] = date;
    data['time'] = time;
    data['seatAvailable'] = seatAvailable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class FindRideResponseModel {
/*
{
  "status": false,
  "message": "Ride Post already exists.",
  "data": [
    {
      "origin": {
        "name": "Andheri",
        "type": "Point",
        "coordinates": [
          72.8697339
        ]
      },
      "destination": {
        "name": "Bandra Terminus",
        "type": "Point",
        "coordinates": [
          72.84047029999999
        ]
      },
      "_id": "65cf11b401e8048d2667d521",
      "riderId": "65c2400c32f497dc57fdf007",
      "date": "2024-02-16T00:00:00.000Z",
      "time": "10 A.M",
      "seatAvailable": 1,
      "createdAt": "2024-02-16T07:41:40.422Z",
      "updatedAt": "2024-02-16T07:41:40.422Z"
    }
  ]
} 
*/

  bool? status;
  String? message;
  List<FindRideResponseModelData?>? data;

  FindRideResponseModel({
    this.status,
    this.message,
    this.data,
  });
  FindRideResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <FindRideResponseModelData>[];
      v.forEach((v) {
        arr0.add(FindRideResponseModelData.fromJson(v));
      });
      data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}
