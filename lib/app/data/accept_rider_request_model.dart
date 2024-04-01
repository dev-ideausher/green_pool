
// ignore_for_file: non_constant_identifier_names

class AcceptRiderRequestModelDataDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  AcceptRiderRequestModelDataDropOffStatus({
    this.isDropOff,
  });
  AcceptRiderRequestModelDataDropOffStatus.fromJson(Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class AcceptRiderRequestModelDataPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  AcceptRiderRequestModelDataPickUpStatus({
    this.isPickUp,
  });
  AcceptRiderRequestModelDataPickUpStatus.fromJson(Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class AcceptRiderRequestModelData {
/*
{
  "pickUpStatus": {
    "isPickUp": false
  },
  "dropOffStatus": {
    "isDropOff": false
  },
  "_id": "65e1d75f959c35c13c75508c",
  "driverRideId": "65ddb242e52406bcf4b8cf6d",
  "riderRideId": "65ddbc3f2fa9b062d5748df8",
  "distance": "0",
  "cancelByDriver": false,
  "cancelByRider": false,
  "confirmByRider": true,
  "confirmByDriver": true,
  "isCompleted": false,
  "driverId": "65c228fd32f497dc57fdeff8",
  "createdAt": "2024-03-01T13:25:51.757Z",
  "updatedAt": "2024-03-07T11:54:00.309Z"
} 
*/

  AcceptRiderRequestModelDataPickUpStatus? pickUpStatus;
  AcceptRiderRequestModelDataDropOffStatus? dropOffStatus;
  String? Id;
  String? driverRideId;
  String? riderRideId;
  String? distance;
  bool? cancelByDriver;
  bool? cancelByRider;
  bool? confirmByRider;
  bool? confirmByDriver;
  bool? isCompleted;
  String? driverId;
  String? createdAt;
  String? updatedAt;

  AcceptRiderRequestModelData({
    this.pickUpStatus,
    this.dropOffStatus,
    this.Id,
    this.driverRideId,
    this.riderRideId,
    this.distance,
    this.cancelByDriver,
    this.cancelByRider,
    this.confirmByRider,
    this.confirmByDriver,
    this.isCompleted,
    this.driverId,
    this.createdAt,
    this.updatedAt,
  });
  AcceptRiderRequestModelData.fromJson(Map<String, dynamic> json) {
    pickUpStatus = (json['pickUpStatus'] != null)
        ? AcceptRiderRequestModelDataPickUpStatus.fromJson(json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? AcceptRiderRequestModelDataDropOffStatus.fromJson(
            json['dropOffStatus'])
        : null;
    Id = json['_id']?.toString();
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    distance = json['distance']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    isCompleted = json['isCompleted'];
    driverId = json['driverId']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (pickUpStatus != null) {
      data['pickUpStatus'] = pickUpStatus!.toJson();
    }
    if (dropOffStatus != null) {
      data['dropOffStatus'] = dropOffStatus!.toJson();
    }
    data['_id'] = Id;
    data['driverRideId'] = driverRideId;
    data['riderRideId'] = riderRideId;
    data['distance'] = distance;
    data['cancelByDriver'] = cancelByDriver;
    data['cancelByRider'] = cancelByRider;
    data['confirmByRider'] = confirmByRider;
    data['confirmByDriver'] = confirmByDriver;
    data['isCompleted'] = isCompleted;
    data['driverId'] = driverId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class AcceptRiderRequestModel {
/*
{
  "status": true,
  "message": "success",
  "data": {
    "pickUpStatus": {
      "isPickUp": false
    },
    "dropOffStatus": {
      "isDropOff": false
    },
    "_id": "65e1d75f959c35c13c75508c",
    "driverRideId": "65ddb242e52406bcf4b8cf6d",
    "riderRideId": "65ddbc3f2fa9b062d5748df8",
    "distance": "0",
    "cancelByDriver": false,
    "cancelByRider": false,
    "confirmByRider": true,
    "confirmByDriver": true,
    "isCompleted": false,
    "driverId": "65c228fd32f497dc57fdeff8",
    "createdAt": "2024-03-01T13:25:51.757Z",
    "updatedAt": "2024-03-07T11:54:00.309Z"
  }
} 
*/

  bool? status;
  String? message;
  AcceptRiderRequestModelData? data;

  AcceptRiderRequestModel({
    this.status,
    this.message,
    this.data,
  });
  AcceptRiderRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? AcceptRiderRequestModelData.fromJson(json['data'])
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
