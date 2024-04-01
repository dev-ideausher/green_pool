
// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters

class SendRiderRequestModelDataBookRideDetailsDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  SendRiderRequestModelDataBookRideDetailsDropOffStatus({
    this.isDropOff,
  });
  SendRiderRequestModelDataBookRideDetailsDropOffStatus.fromJson(
      Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class SendRiderRequestModelDataBookRideDetailsPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  SendRiderRequestModelDataBookRideDetailsPickUpStatus({
    this.isPickUp,
  });
  SendRiderRequestModelDataBookRideDetailsPickUpStatus.fromJson(
      Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class SendRiderRequestModelDataBookRideDetails {
/*
{
  "driverRideId": "65e42c95530cc588e3d607ef",
  "riderRideId": "65e467340fa3c056f0f242b1",
  "distance": "0",
  "cancelByDriver": false,
  "cancelByRider": false,
  "confirmByRider": false,
  "confirmByDriver": true,
  "pickUpStatus": {
    "isPickUp": false
  },
  "dropOffStatus": {
    "isDropOff": false
  },
  "isCompleted": false,
  "driverId": "65e429e7530cc588e3d607d8",
  "_id": "65e4731b22af6bbbff13a59a",
  "createdAt": "2024-03-03T12:54:51.385Z",
  "updatedAt": "2024-03-03T12:54:51.385Z"
} 
*/

  String? driverRideId;
  String? riderRideId;
  String? distance;
  bool? cancelByDriver;
  bool? cancelByRider;
  bool? confirmByRider;
  bool? confirmByDriver;
  SendRiderRequestModelDataBookRideDetailsPickUpStatus? pickUpStatus;
  SendRiderRequestModelDataBookRideDetailsDropOffStatus? dropOffStatus;
  bool? isCompleted;
  String? driverId;
  String? _Id;

  String? get Id => _Id;

  set Id(String? value) {
    _Id = value;
  }
  String? createdAt;
  String? updatedAt;

  SendRiderRequestModelDataBookRideDetails({
    this.driverRideId,
    this.riderRideId,
    this.distance,
    this.cancelByDriver,
    this.cancelByRider,
    this.confirmByRider,
    this.confirmByDriver,
    this.pickUpStatus,
    this.dropOffStatus,
    this.isCompleted,
    this.driverId,
    String? Id,
    this.createdAt,
    this.updatedAt,
  }) : _Id = Id;
  SendRiderRequestModelDataBookRideDetails.fromJson(Map<String, dynamic> json) {
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    distance = json['distance']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    pickUpStatus = (json['pickUpStatus'] != null)
        ? SendRiderRequestModelDataBookRideDetailsPickUpStatus.fromJson(
            json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? SendRiderRequestModelDataBookRideDetailsDropOffStatus.fromJson(
            json['dropOffStatus'])
        : null;
    isCompleted = json['isCompleted'];
    driverId = json['driverId']?.toString();
    Id = json['_id']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['driverRideId'] = driverRideId;
    data['riderRideId'] = riderRideId;
    data['distance'] = distance;
    data['cancelByDriver'] = cancelByDriver;
    data['cancelByRider'] = cancelByRider;
    data['confirmByRider'] = confirmByRider;
    data['confirmByDriver'] = confirmByDriver;
    if (pickUpStatus != null) {
      data['pickUpStatus'] = pickUpStatus!.toJson();
    }
    if (dropOffStatus != null) {
      data['dropOffStatus'] = dropOffStatus!.toJson();
    }
    data['isCompleted'] = isCompleted;
    data['driverId'] = driverId;
    data['_id'] = Id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SendRiderRequestModelData {
/*
{
  "bookRideDetails": {
    "driverRideId": "65e42c95530cc588e3d607ef",
    "riderRideId": "65e467340fa3c056f0f242b1",
    "distance": "0",
    "cancelByDriver": false,
    "cancelByRider": false,
    "confirmByRider": false,
    "confirmByDriver": true,
    "pickUpStatus": {
      "isPickUp": false
    },
    "dropOffStatus": {
      "isDropOff": false
    },
    "isCompleted": false,
    "driverId": "65e429e7530cc588e3d607d8",
    "_id": "65e4731b22af6bbbff13a59a",
    "createdAt": "2024-03-03T12:54:51.385Z",
    "updatedAt": "2024-03-03T12:54:51.385Z"
  }
} 
*/

  SendRiderRequestModelDataBookRideDetails? bookRideDetails;

  SendRiderRequestModelData({
    this.bookRideDetails,
  });
  SendRiderRequestModelData.fromJson(Map<String, dynamic> json) {
    bookRideDetails = (json['bookRideDetails'] != null)
        ? SendRiderRequestModelDataBookRideDetails.fromJson(
            json['bookRideDetails'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (bookRideDetails != null) {
      data['bookRideDetails'] = bookRideDetails!.toJson();
    }
    return data;
  }
}

class SendRiderRequestModel {
/*
{
  "status": true,
  "message": "success",
  "data": {
    "bookRideDetails": {
      "driverRideId": "65e42c95530cc588e3d607ef",
      "riderRideId": "65e467340fa3c056f0f242b1",
      "distance": "0",
      "cancelByDriver": false,
      "cancelByRider": false,
      "confirmByRider": false,
      "confirmByDriver": true,
      "pickUpStatus": {
        "isPickUp": false
      },
      "dropOffStatus": {
        "isDropOff": false
      },
      "isCompleted": false,
      "driverId": "65e429e7530cc588e3d607d8",
      "_id": "65e4731b22af6bbbff13a59a",
      "createdAt": "2024-03-03T12:54:51.385Z",
      "updatedAt": "2024-03-03T12:54:51.385Z"
    }
  }
} 
*/

  bool? status;
  String? message;
  SendRiderRequestModelData? data;

  SendRiderRequestModel({
    this.status,
    this.message,
    this.data,
  });
  SendRiderRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? SendRiderRequestModelData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    return data;
  }
}
