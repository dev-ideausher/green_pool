
// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names

class MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsProfilePic {
/*
{
  "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
} 
*/

  String? key;
  String? url;

  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsProfilePic({
    this.key,
    this.url,
  });
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsProfilePic.fromJson(
      Map<String, dynamic> json) {
    key = json['key']?.toString();
    url = json['url']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    return data;
  }
}

class MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsIdPic {
/*
{
  "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
} 
*/

  String? key;
  String? url;

  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsIdPic({
    this.key,
    this.url,
  });
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsIdPic.fromJson(
      Map<String, dynamic> json) {
    key = json['key']?.toString();
    url = json['url']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    return data;
  }
}

class MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetails {
/*
{
  "_id": "ObjectId('65c2400c32f497dc57fdf007')",
  "fullName": "Rekha Dutta",
  "phone": "+11234567567",
  "email": "rekha@test.com",
  "dob": "1996-02-22",
  "gender": "Female",
  "isDriver": true,
  "referralCode": "V0280Q1170",
  "profileStatus": true,
  "vehicleStatus": true,
  "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
  "firebaseSignInProvider": "phone",
  "createdAt": "2024-02-06T14:19:56.214Z",
  "updatedAt": "2024-03-05T07:10:31.962Z",
  "idPic": {
    "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
  },
  "profilePic": {
    "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
  },
  "status": "active"
} 
*/

  String? Id;
  String? fullName;
  String? phone;
  String? email;
  String? dob;
  String? gender;
  bool? isDriver;
  String? referralCode;
  bool? profileStatus;
  bool? vehicleStatus;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? createdAt;
  String? updatedAt;
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsIdPic? idPic;
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsProfilePic?
      profilePic;
  String? status;

  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetails({
    this.Id,
    this.fullName,
    this.phone,
    this.email,
    this.dob,
    this.gender,
    this.isDriver,
    this.referralCode,
    this.profileStatus,
    this.vehicleStatus,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.createdAt,
    this.updatedAt,
    this.idPic,
    this.profilePic,
    this.status,
  });
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    fullName = json['fullName']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    dob = json['dob']?.toString();
    gender = json['gender']?.toString();
    isDriver = json['isDriver'];
    referralCode = json['referralCode']?.toString();
    profileStatus = json['profileStatus'];
    vehicleStatus = json['vehicleStatus'];
    firebaseUid = json['firebaseUid']?.toString();
    firebaseSignInProvider = json['firebaseSignInProvider']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    idPic = (json['idPic'] != null)
        ? MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsIdPic
            .fromJson(json['idPic'])
        : null;
    profilePic = (json['profilePic'] != null)
        ? MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetailsProfilePic
            .fromJson(json['profilePic'])
        : null;
    status = json['status']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['dob'] = dob;
    data['gender'] = gender;
    data['isDriver'] = isDriver;
    data['referralCode'] = referralCode;
    data['profileStatus'] = profileStatus;
    data['vehicleStatus'] = vehicleStatus;
    data['firebaseUid'] = firebaseUid;
    data['firebaseSignInProvider'] = firebaseSignInProvider;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (idPic != null) {
      data['idPic'] = idPic!.toJson();
    }
    if (profilePic != null) {
      data['profilePic'] = profilePic!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class MyRidesDetailsModelDataPostsInfoRiderPostsDetailsDestination {
/*
{
  "name": "Borivali,Mumbai,Mumbai Suburban",
  "type": "Point",
  "coordinates": [
    72.856673
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsDestination.fromJson(
      Map<String, dynamic> json) {
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

class MyRidesDetailsModelDataPostsInfoRiderPostsDetailsOrigin {
/*
{
  "name": "Andheri-1,Mumbai Suburban",
  "type": "Point",
  "coordinates": [
    72.8697339
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
  });
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsOrigin.fromJson(
      Map<String, dynamic> json) {
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

class MyRidesDetailsModelDataPostsInfoRiderPostsDetails {
/*
{
  "_id": "ObjectId('65ddbc3f2fa9b062d5748df8')",
  "riderId": "ObjectId('65c2400c32f497dc57fdf007')",
  "origin": {
    "name": "Andheri-1,Mumbai Suburban",
    "type": "Point",
    "coordinates": [
      72.8697339
    ]
  },
  "destination": {
    "name": "Borivali,Mumbai,Mumbai Suburban",
    "type": "Point",
    "coordinates": [
      72.856673
    ]
  },
  "date": "2024-02-29T00:00:00.000Z",
  "time": "6:30 PM",
  "seatAvailable": 1,
  "createdAt": "2024-02-27T10:41:03.152Z",
  "updatedAt": "2024-02-27T10:41:03.152Z",
  "ridersDetails": [
    {
      "_id": "ObjectId('65c2400c32f497dc57fdf007')",
      "fullName": "Rekha Dutta",
      "phone": "+11234567567",
      "email": "rekha@test.com",
      "dob": "1996-02-22",
      "gender": "Female",
      "isDriver": true,
      "referralCode": "V0280Q1170",
      "profileStatus": true,
      "vehicleStatus": true,
      "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
      "firebaseSignInProvider": "phone",
      "createdAt": "2024-02-06T14:19:56.214Z",
      "updatedAt": "2024-03-05T07:10:31.962Z",
      "idPic": {
        "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
      },
      "profilePic": {
        "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
      },
      "status": "active"
    }
  ]
} 
*/

  String? Id;
  String? riderId;
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsOrigin? origin;
  MyRidesDetailsModelDataPostsInfoRiderPostsDetailsDestination? destination;
  String? date;
  String? time;
  int? seatAvailable;
  String? createdAt;
  String? updatedAt;
  List<MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetails?>?
      ridersDetails;

  MyRidesDetailsModelDataPostsInfoRiderPostsDetails({
    this.Id,
    this.riderId,
    this.origin,
    this.destination,
    this.date,
    this.time,
    this.seatAvailable,
    this.createdAt,
    this.updatedAt,
    this.ridersDetails,
  });
  MyRidesDetailsModelDataPostsInfoRiderPostsDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    riderId = json['riderId']?.toString();
    origin = (json['origin'] != null)
        ? MyRidesDetailsModelDataPostsInfoRiderPostsDetailsOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? MyRidesDetailsModelDataPostsInfoRiderPostsDetailsDestination.fromJson(
            json['destination'])
        : null;
    date = json['date']?.toString();
    time = json['time']?.toString();
    seatAvailable = json['seatAvailable']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['ridersDetails'] != null) {
      final v = json['ridersDetails'];
      final arr0 =
          <MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetails>[];
      v.forEach((v) {
        arr0.add(MyRidesDetailsModelDataPostsInfoRiderPostsDetailsRidersDetails
            .fromJson(v));
      });
      ridersDetails = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['riderId'] = riderId;
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    data['date'] = date;
    data['time'] = time;
    data['seatAvailable'] = seatAvailable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ridersDetails != null) {
      final v = ridersDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['ridersDetails'] = arr0;
    }
    return data;
  }
}

class MyRidesDetailsModelDataPostsInfoDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  MyRidesDetailsModelDataPostsInfoDropOffStatus({
    this.isDropOff,
  });
  MyRidesDetailsModelDataPostsInfoDropOffStatus.fromJson(
      Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class MyRidesDetailsModelDataPostsInfoPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  MyRidesDetailsModelDataPostsInfoPickUpStatus({
    this.isPickUp,
  });
  MyRidesDetailsModelDataPostsInfoPickUpStatus.fromJson(
      Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class MyRidesDetailsModelDataPostsInfo {
/*
{
  "_id": "ObjectId('65e1d75f959c35c13c75508c')",
  "driverRideId": "ObjectId('65ddb242e52406bcf4b8cf6d')",
  "riderRideId": "ObjectId('65ddbc3f2fa9b062d5748df8')",
  "distance": "0",
  "cancelByDriver": false,
  "cancelByRider": false,
  "confirmByRider": true,
  "confirmByDriver": false,
  "pickUpStatus": {
    "isPickUp": false
  },
  "dropOffStatus": {
    "isDropOff": false
  },
  "isCompleted": false,
  "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
  "createdAt": "2024-03-01T13:25:51.757Z",
  "updatedAt": "2024-03-07T12:58:31.324Z",
  "riderPostsDetails": [
    {
      "_id": "ObjectId('65ddbc3f2fa9b062d5748df8')",
      "riderId": "ObjectId('65c2400c32f497dc57fdf007')",
      "origin": {
        "name": "Andheri-1,Mumbai Suburban",
        "type": "Point",
        "coordinates": [
          72.8697339
        ]
      },
      "destination": {
        "name": "Borivali,Mumbai,Mumbai Suburban",
        "type": "Point",
        "coordinates": [
          72.856673
        ]
      },
      "date": "2024-02-29T00:00:00.000Z",
      "time": "6:30 PM",
      "seatAvailable": 1,
      "createdAt": "2024-02-27T10:41:03.152Z",
      "updatedAt": "2024-02-27T10:41:03.152Z",
      "ridersDetails": [
        {
          "_id": "ObjectId('65c2400c32f497dc57fdf007')",
          "fullName": "Rekha Dutta",
          "phone": "+11234567567",
          "email": "rekha@test.com",
          "dob": "1996-02-22",
          "gender": "Female",
          "isDriver": true,
          "referralCode": "V0280Q1170",
          "profileStatus": true,
          "vehicleStatus": true,
          "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
          "firebaseSignInProvider": "phone",
          "createdAt": "2024-02-06T14:19:56.214Z",
          "updatedAt": "2024-03-05T07:10:31.962Z",
          "idPic": {
            "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
          },
          "profilePic": {
            "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
          },
          "status": "active"
        }
      ]
    }
  ]
} 
*/

  String? Id;
  String? driverRideId;
  String? riderRideId;
  String? distance;
  bool? cancelByDriver;
  bool? cancelByRider;
  bool? confirmByRider;
  bool? confirmByDriver;
  MyRidesDetailsModelDataPostsInfoPickUpStatus? pickUpStatus;
  MyRidesDetailsModelDataPostsInfoDropOffStatus? dropOffStatus;
  bool? isCompleted;
  String? driverId;
  String? createdAt;
  String? updatedAt;
  List<MyRidesDetailsModelDataPostsInfoRiderPostsDetails?>? riderPostsDetails;

  MyRidesDetailsModelDataPostsInfo({
    this.Id,
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
    this.createdAt,
    this.updatedAt,
    this.riderPostsDetails,
  });
  MyRidesDetailsModelDataPostsInfo.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    distance = json['distance']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    pickUpStatus = (json['pickUpStatus'] != null)
        ? MyRidesDetailsModelDataPostsInfoPickUpStatus.fromJson(
            json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? MyRidesDetailsModelDataPostsInfoDropOffStatus.fromJson(
            json['dropOffStatus'])
        : null;
    isCompleted = json['isCompleted'];
    driverId = json['driverId']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['riderPostsDetails'] != null) {
      final v = json['riderPostsDetails'];
      final arr0 = <MyRidesDetailsModelDataPostsInfoRiderPostsDetails>[];
      v.forEach((v) {
        arr0.add(MyRidesDetailsModelDataPostsInfoRiderPostsDetails.fromJson(v));
      });
      riderPostsDetails = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (riderPostsDetails != null) {
      final v = riderPostsDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['riderPostsDetails'] = arr0;
    }
    return data;
  }
}

class MyRidesDetailsModelDataVehicleDetailsVehiclePic {
/*
{
  "key": "vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
  "_id": "ObjectId('65c23bef32f497dc57fdf003')"
} 
*/

  String? key;
  String? url;
  String? Id;

  MyRidesDetailsModelDataVehicleDetailsVehiclePic({
    this.key,
    this.url,
    this.Id,
  });
  MyRidesDetailsModelDataVehicleDetailsVehiclePic.fromJson(
      Map<String, dynamic> json) {
    key = json['key']?.toString();
    url = json['url']?.toString();
    Id = json['_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    data['_id'] = Id;
    return data;
  }
}

class MyRidesDetailsModelDataVehicleDetails {
/*
{
  "_id": "ObjectId('65c23bef32f497dc57fdf002')",
  "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
  "vehiclePic": {
    "key": "vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
    "_id": "ObjectId('65c23bef32f497dc57fdf003')"
  },
  "model": "ModelY",
  "type": "Sedan",
  "color": "Red",
  "year": 2024,
  "licencePlate": "LA2024",
  "createdAt": "2024-02-06T14:02:23.061Z",
  "updatedAt": "2024-02-06T14:02:23.061Z"
} 
*/

  String? Id;
  String? driverId;
  MyRidesDetailsModelDataVehicleDetailsVehiclePic? vehiclePic;
  String? model;
  String? type;
  String? color;
  int? year;
  String? licencePlate;
  String? createdAt;
  String? updatedAt;

  MyRidesDetailsModelDataVehicleDetails({
    this.Id,
    this.driverId,
    this.vehiclePic,
    this.model,
    this.type,
    this.color,
    this.year,
    this.licencePlate,
    this.createdAt,
    this.updatedAt,
  });
  MyRidesDetailsModelDataVehicleDetails.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    vehiclePic = (json['vehiclePic'] != null)
        ? MyRidesDetailsModelDataVehicleDetailsVehiclePic.fromJson(
            json['vehiclePic'])
        : null;
    model = json['model']?.toString();
    type = json['type']?.toString();
    color = json['color']?.toString();
    year = json['year']?.toInt();
    licencePlate = json['licencePlate']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['driverId'] = driverId;
    if (vehiclePic != null) {
      data['vehiclePic'] = vehiclePic!.toJson();
    }
    data['model'] = model;
    data['type'] = type;
    data['color'] = color;
    data['year'] = year;
    data['licencePlate'] = licencePlate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class MyRidesDetailsModelDataPreferencesOther {
/*
{
  "AppreciatesConversation": false,
  "EnjoysMusic": false,
  "SmokeFree": false,
  "PetFriendly": false,
  "WinterTires": false,
  "CoolingOrHeating": false,
  "BabySeat": false,
  "HeatedSeats": false
} 
*/

  bool? AppreciatesConversation;
  bool? EnjoysMusic;
  bool? SmokeFree;
  bool? PetFriendly;
  bool? WinterTires;
  bool? CoolingOrHeating;
  bool? BabySeat;
  bool? HeatedSeats;

  MyRidesDetailsModelDataPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  MyRidesDetailsModelDataPreferencesOther.fromJson(Map<String, dynamic> json) {
    AppreciatesConversation = json['AppreciatesConversation'];
    EnjoysMusic = json['EnjoysMusic'];
    SmokeFree = json['SmokeFree'];
    PetFriendly = json['PetFriendly'];
    WinterTires = json['WinterTires'];
    CoolingOrHeating = json['CoolingOrHeating'];
    BabySeat = json['BabySeat'];
    HeatedSeats = json['HeatedSeats'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['AppreciatesConversation'] = AppreciatesConversation;
    data['EnjoysMusic'] = EnjoysMusic;
    data['SmokeFree'] = SmokeFree;
    data['PetFriendly'] = PetFriendly;
    data['WinterTires'] = WinterTires;
    data['CoolingOrHeating'] = CoolingOrHeating;
    data['BabySeat'] = BabySeat;
    data['HeatedSeats'] = HeatedSeats;
    return data;
  }
}

class MyRidesDetailsModelDataPreferences {
/*
{
  "seatAvailable": 2,
  "luggageType": "No",
  "other": {
    "AppreciatesConversation": false,
    "EnjoysMusic": false,
    "SmokeFree": false,
    "PetFriendly": false,
    "WinterTires": false,
    "CoolingOrHeating": false,
    "BabySeat": false,
    "HeatedSeats": false
  }
} 
*/

  int? seatAvailable;
  String? luggageType;
  MyRidesDetailsModelDataPreferencesOther? other;

  MyRidesDetailsModelDataPreferences({
    this.seatAvailable,
    this.luggageType,
    this.other,
  });
  MyRidesDetailsModelDataPreferences.fromJson(Map<String, dynamic> json) {
    seatAvailable = json['seatAvailable']?.toInt();
    luggageType = json['luggageType']?.toString();
    other = (json['other'] != null)
        ? MyRidesDetailsModelDataPreferencesOther.fromJson(json['other'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['seatAvailable'] = seatAvailable;
    data['luggageType'] = luggageType;
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class MyRidesDetailsModelDataReturnTrip {
/*
{
  "isReturnTrip": false,
  "returnDate": null,
  "returnTime": ""
} 
*/

  bool? isReturnTrip;
  String? returnDate;
  String? returnTime;

  MyRidesDetailsModelDataReturnTrip({
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  MyRidesDetailsModelDataReturnTrip.fromJson(Map<String, dynamic> json) {
    isReturnTrip = json['isReturnTrip'];
    returnDate = json['returnDate']?.toString();
    returnTime = json['returnTime']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isReturnTrip'] = isReturnTrip;
    data['returnDate'] = returnDate;
    data['returnTime'] = returnTime;
    return data;
  }
}

class MyRidesDetailsModelDataStops {
/*
{
  "name": "Andheri,Mumbai Suburban,Konkan Division",
  "type": "Point",
  "coordinates": [
    72.8697339
  ],
  "_id": "ObjectId('65ddb242e52406bcf4b8cf6e')"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? Id;

  MyRidesDetailsModelDataStops({
    this.name,
    this.type,
    this.coordinates,
    this.Id,
  });
  MyRidesDetailsModelDataStops.fromJson(Map<String, dynamic> json) {
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
    Id = json['_id']?.toString();
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
    data['_id'] = Id;
    return data;
  }
}

class MyRidesDetailsModelDataDestination {
/*
{
  "name": "Borivali,Mumbai,Mumbai Suburban",
  "type": "Point",
  "coordinates": [
    72.856673
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  MyRidesDetailsModelDataDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  MyRidesDetailsModelDataDestination.fromJson(Map<String, dynamic> json) {
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

class MyRidesDetailsModelDataOrigin {
/*
{
  "name": "Bandra Terminus,Naupada,Bandra East",
  "type": "Point",
  "coordinates": [
    72.84047029999999
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  MyRidesDetailsModelDataOrigin({
    this.name,
    this.type,
    this.coordinates,
  });
  MyRidesDetailsModelDataOrigin.fromJson(Map<String, dynamic> json) {
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

class MyRidesDetailsModelData {
/*
{
  "_id": "ObjectId('65ddb242e52406bcf4b8cf6d')",
  "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
  "origin": {
    "name": "Bandra Terminus,Naupada,Bandra East",
    "type": "Point",
    "coordinates": [
      72.84047029999999
    ]
  },
  "destination": {
    "name": "Borivali,Mumbai,Mumbai Suburban",
    "type": "Point",
    "coordinates": [
      72.856673
    ]
  },
  "stops": [
    {
      "name": "Andheri,Mumbai Suburban,Konkan Division",
      "type": "Point",
      "coordinates": [
        72.8697339
      ],
      "_id": "ObjectId('65ddb242e52406bcf4b8cf6e')"
    }
  ],
  "tripType": "oneTime",
  "date": "2024-02-29T00:00:00.000Z",
  "time": "6:00 PM",
  "returnTrip": {
    "isReturnTrip": false,
    "returnDate": null,
    "returnTime": ""
  },
  "arrivalDate": null,
  "arrivalTime": null,
  "preferences": {
    "seatAvailable": 2,
    "luggageType": "No",
    "other": {
      "AppreciatesConversation": false,
      "EnjoysMusic": false,
      "SmokeFree": false,
      "PetFriendly": false,
      "WinterTires": false,
      "CoolingOrHeating": false,
      "BabySeat": false,
      "HeatedSeats": false
    }
  },
  "isStarted": false,
  "isCompleted": false,
  "isCancelled": false,
  "fair": "29",
  "riders": [
    "ObjectId('65c2400c32f497dc57fdf007')"
  ],
  "createdAt": "2024-02-27T09:58:26.560Z",
  "updatedAt": "2024-03-01T13:25:51.917Z",
  "vehicleDetails": [
    {
      "_id": "ObjectId('65c23bef32f497dc57fdf002')",
      "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
      "vehiclePic": {
        "key": "vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
        "_id": "ObjectId('65c23bef32f497dc57fdf003')"
      },
      "model": "ModelY",
      "type": "Sedan",
      "color": "Red",
      "year": 2024,
      "licencePlate": "LA2024",
      "createdAt": "2024-02-06T14:02:23.061Z",
      "updatedAt": "2024-02-06T14:02:23.061Z"
    }
  ],
  "postsInfo": [
    {
      "_id": "ObjectId('65e1d75f959c35c13c75508c')",
      "driverRideId": "ObjectId('65ddb242e52406bcf4b8cf6d')",
      "riderRideId": "ObjectId('65ddbc3f2fa9b062d5748df8')",
      "distance": "0",
      "cancelByDriver": false,
      "cancelByRider": false,
      "confirmByRider": true,
      "confirmByDriver": false,
      "pickUpStatus": {
        "isPickUp": false
      },
      "dropOffStatus": {
        "isDropOff": false
      },
      "isCompleted": false,
      "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
      "createdAt": "2024-03-01T13:25:51.757Z",
      "updatedAt": "2024-03-07T12:58:31.324Z",
      "riderPostsDetails": [
        {
          "_id": "ObjectId('65ddbc3f2fa9b062d5748df8')",
          "riderId": "ObjectId('65c2400c32f497dc57fdf007')",
          "origin": {
            "name": "Andheri-1,Mumbai Suburban",
            "type": "Point",
            "coordinates": [
              72.8697339
            ]
          },
          "destination": {
            "name": "Borivali,Mumbai,Mumbai Suburban",
            "type": "Point",
            "coordinates": [
              72.856673
            ]
          },
          "date": "2024-02-29T00:00:00.000Z",
          "time": "6:30 PM",
          "seatAvailable": 1,
          "createdAt": "2024-02-27T10:41:03.152Z",
          "updatedAt": "2024-02-27T10:41:03.152Z",
          "ridersDetails": [
            {
              "_id": "ObjectId('65c2400c32f497dc57fdf007')",
              "fullName": "Rekha Dutta",
              "phone": "+11234567567",
              "email": "rekha@test.com",
              "dob": "1996-02-22",
              "gender": "Female",
              "isDriver": true,
              "referralCode": "V0280Q1170",
              "profileStatus": true,
              "vehicleStatus": true,
              "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
              "firebaseSignInProvider": "phone",
              "createdAt": "2024-02-06T14:19:56.214Z",
              "updatedAt": "2024-03-05T07:10:31.962Z",
              "idPic": {
                "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
                "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
              },
              "profilePic": {
                "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
                "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
              },
              "status": "active"
            }
          ]
        }
      ]
    }
  ]
} 
*/

  String? Id;
  String? driverId;
  MyRidesDetailsModelDataOrigin? origin;
  MyRidesDetailsModelDataDestination? destination;
  List<MyRidesDetailsModelDataStops?>? stops;
  String? tripType;
  String? date;
  String? time;
  MyRidesDetailsModelDataReturnTrip? returnTrip;
  String? arrivalDate;
  String? arrivalTime;
  MyRidesDetailsModelDataPreferences? preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  String? fair;
  List<String?>? riders;
  String? createdAt;
  String? updatedAt;
  List<MyRidesDetailsModelDataVehicleDetails?>? vehicleDetails;
  List<MyRidesDetailsModelDataPostsInfo?>? postsInfo;

  MyRidesDetailsModelData({
    this.Id,
    this.driverId,
    this.origin,
    this.destination,
    this.stops,
    this.tripType,
    this.date,
    this.time,
    this.returnTrip,
    this.arrivalDate,
    this.arrivalTime,
    this.preferences,
    this.isStarted,
    this.isCompleted,
    this.isCancelled,
    this.fair,
    this.riders,
    this.createdAt,
    this.updatedAt,
    this.vehicleDetails,
    this.postsInfo,
  });
  MyRidesDetailsModelData.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    origin = (json['origin'] != null)
        ? MyRidesDetailsModelDataOrigin.fromJson(json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? MyRidesDetailsModelDataDestination.fromJson(json['destination'])
        : null;
    if (json['stops'] != null) {
      final v = json['stops'];
      final arr0 = <MyRidesDetailsModelDataStops>[];
      v.forEach((v) {
        arr0.add(MyRidesDetailsModelDataStops.fromJson(v));
      });
      stops = arr0;
    }
    tripType = json['tripType']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    returnTrip = (json['returnTrip'] != null)
        ? MyRidesDetailsModelDataReturnTrip.fromJson(json['returnTrip'])
        : null;
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    preferences = (json['preferences'] != null)
        ? MyRidesDetailsModelDataPreferences.fromJson(json['preferences'])
        : null;
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    fair = json['fair']?.toString();
    if (json['riders'] != null) {
      final v = json['riders'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      riders = arr0;
    }
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['vehicleDetails'] != null) {
      final v = json['vehicleDetails'];
      final arr0 = <MyRidesDetailsModelDataVehicleDetails>[];
      v.forEach((v) {
        arr0.add(MyRidesDetailsModelDataVehicleDetails.fromJson(v));
      });
      vehicleDetails = arr0;
    }
    if (json['postsInfo'] != null) {
      final v = json['postsInfo'];
      final arr0 = <MyRidesDetailsModelDataPostsInfo>[];
      v.forEach((v) {
        arr0.add(MyRidesDetailsModelDataPostsInfo.fromJson(v));
      });
      postsInfo = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['driverId'] = driverId;
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (stops != null) {
      final v = stops;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['stops'] = arr0;
    }
    data['tripType'] = tripType;
    data['date'] = date;
    data['time'] = time;
    if (returnTrip != null) {
      data['returnTrip'] = returnTrip!.toJson();
    }
    data['arrivalDate'] = arrivalDate;
    data['arrivalTime'] = arrivalTime;
    if (preferences != null) {
      data['preferences'] = preferences!.toJson();
    }
    data['isStarted'] = isStarted;
    data['isCompleted'] = isCompleted;
    data['isCancelled'] = isCancelled;
    data['fair'] = fair;
    if (riders != null) {
      final v = riders;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['riders'] = arr0;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (vehicleDetails != null) {
      final v = vehicleDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['vehicleDetails'] = arr0;
    }
    if (postsInfo != null) {
      final v = postsInfo;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['postsInfo'] = arr0;
    }
    return data;
  }
}

class MyRidesDetailsModel {
/*
{
  "status": true,
  "message": "success",
  "data": [
    {
      "_id": "ObjectId('65ddb242e52406bcf4b8cf6d')",
      "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
      "origin": {
        "name": "Bandra Terminus,Naupada,Bandra East",
        "type": "Point",
        "coordinates": [
          72.84047029999999
        ]
      },
      "destination": {
        "name": "Borivali,Mumbai,Mumbai Suburban",
        "type": "Point",
        "coordinates": [
          72.856673
        ]
      },
      "stops": [
        {
          "name": "Andheri,Mumbai Suburban,Konkan Division",
          "type": "Point",
          "coordinates": [
            72.8697339
          ],
          "_id": "ObjectId('65ddb242e52406bcf4b8cf6e')"
        }
      ],
      "tripType": "oneTime",
      "date": "2024-02-29T00:00:00.000Z",
      "time": "6:00 PM",
      "returnTrip": {
        "isReturnTrip": false,
        "returnDate": null,
        "returnTime": ""
      },
      "arrivalDate": null,
      "arrivalTime": null,
      "preferences": {
        "seatAvailable": 2,
        "luggageType": "No",
        "other": {
          "AppreciatesConversation": false,
          "EnjoysMusic": false,
          "SmokeFree": false,
          "PetFriendly": false,
          "WinterTires": false,
          "CoolingOrHeating": false,
          "BabySeat": false,
          "HeatedSeats": false
        }
      },
      "isStarted": false,
      "isCompleted": false,
      "isCancelled": false,
      "fair": "29",
      "riders": [
        "ObjectId('65c2400c32f497dc57fdf007')"
      ],
      "createdAt": "2024-02-27T09:58:26.560Z",
      "updatedAt": "2024-03-01T13:25:51.917Z",
      "vehicleDetails": [
        {
          "_id": "ObjectId('65c23bef32f497dc57fdf002')",
          "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
          "vehiclePic": {
            "key": "vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/0f9bfe4d-10f3-479f-8f56-caa8faad5737-1000000034.jpg",
            "_id": "ObjectId('65c23bef32f497dc57fdf003')"
          },
          "model": "ModelY",
          "type": "Sedan",
          "color": "Red",
          "year": 2024,
          "licencePlate": "LA2024",
          "createdAt": "2024-02-06T14:02:23.061Z",
          "updatedAt": "2024-02-06T14:02:23.061Z"
        }
      ],
      "postsInfo": [
        {
          "_id": "ObjectId('65e1d75f959c35c13c75508c')",
          "driverRideId": "ObjectId('65ddb242e52406bcf4b8cf6d')",
          "riderRideId": "ObjectId('65ddbc3f2fa9b062d5748df8')",
          "distance": "0",
          "cancelByDriver": false,
          "cancelByRider": false,
          "confirmByRider": true,
          "confirmByDriver": false,
          "pickUpStatus": {
            "isPickUp": false
          },
          "dropOffStatus": {
            "isDropOff": false
          },
          "isCompleted": false,
          "driverId": "ObjectId('65c228fd32f497dc57fdeff8')",
          "createdAt": "2024-03-01T13:25:51.757Z",
          "updatedAt": "2024-03-07T12:58:31.324Z",
          "riderPostsDetails": [
            {
              "_id": "ObjectId('65ddbc3f2fa9b062d5748df8')",
              "riderId": "ObjectId('65c2400c32f497dc57fdf007')",
              "origin": {
                "name": "Andheri-1,Mumbai Suburban",
                "type": "Point",
                "coordinates": [
                  72.8697339
                ]
              },
              "destination": {
                "name": "Borivali,Mumbai,Mumbai Suburban",
                "type": "Point",
                "coordinates": [
                  72.856673
                ]
              },
              "date": "2024-02-29T00:00:00.000Z",
              "time": "6:30 PM",
              "seatAvailable": 1,
              "createdAt": "2024-02-27T10:41:03.152Z",
              "updatedAt": "2024-02-27T10:41:03.152Z",
              "ridersDetails": [
                {
                  "_id": "ObjectId('65c2400c32f497dc57fdf007')",
                  "fullName": "Rekha Dutta",
                  "phone": "+11234567567",
                  "email": "rekha@test.com",
                  "dob": "1996-02-22",
                  "gender": "Female",
                  "isDriver": true,
                  "referralCode": "V0280Q1170",
                  "profileStatus": true,
                  "vehicleStatus": true,
                  "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
                  "firebaseSignInProvider": "phone",
                  "createdAt": "2024-02-06T14:19:56.214Z",
                  "updatedAt": "2024-03-05T07:10:31.962Z",
                  "idPic": {
                    "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
                    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
                  },
                  "profilePic": {
                    "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
                    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
                  },
                  "status": "active"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
} 
*/

  bool? status;
  String? message;
  List<MyRidesDetailsModelData?>? data;

  MyRidesDetailsModel({
    this.status,
    this.message,
    this.data,
  });
  MyRidesDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <MyRidesDetailsModelData>[];
      v.forEach((v) {
        arr0.add(MyRidesDetailsModelData.fromJson(v));
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
