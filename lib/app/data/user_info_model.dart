
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

class UserInfoModelDataEmergencyContactDetails {
/*
{
  "_id": "65b652a850b73ac0b979d80b",
  "userId": "65b646d12493cd72d4d8cc2d",
  "fullName": "karan",
  "phone": "098765",
  "createdAt": "2024-01-28T13:12:08.270Z",
  "updatedAt": "2024-01-28T13:12:08.270Z"
} 
*/

  String? Id;
  String? userId;
  String? fullName;
  String? phone;
  String? createdAt;
  String? updatedAt;

  UserInfoModelDataEmergencyContactDetails({
    this.Id,
    this.userId,
    this.fullName,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });
  UserInfoModelDataEmergencyContactDetails.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    userId = json['userId']?.toString();
    fullName = json['fullName']?.toString();
    phone = json['phone']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UserInfoModelDataVehicleDetailsVehiclePic {
/*
{
  "key": "vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
  "_id": "65c2481f32f497dc57fdf020"
} 
*/

  String? key;
  String? url;
  String? Id;

  UserInfoModelDataVehicleDetailsVehiclePic({
    this.key,
    this.url,
    this.Id,
  });
  UserInfoModelDataVehicleDetailsVehiclePic.fromJson(
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

class UserInfoModelDataVehicleDetails {
/*
{
  "_id": "65c2481f32f497dc57fdf01f",
  "driverId": "65c2400c32f497dc57fdf007",
  "vehiclePic": {
    "key": "vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
    "_id": "65c2481f32f497dc57fdf020"
  },
  "model": "ModelY",
  "type": "Convertible",
  "color": "Red",
  "year": 2024,
  "licencePlate": "LA2024",
  "createdAt": "2024-02-06T14:54:23.830Z",
  "updatedAt": "2024-02-06T14:54:23.830Z"
} 
*/

  String? Id;
  String? driverId;
  UserInfoModelDataVehicleDetailsVehiclePic? vehiclePic;
  String? model;
  String? type;
  String? color;
  int? year;
  String? licencePlate;
  String? createdAt;
  String? updatedAt;

  UserInfoModelDataVehicleDetails({
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
  UserInfoModelDataVehicleDetails.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    vehiclePic = (json['vehiclePic'] != null)
        ? UserInfoModelDataVehicleDetailsVehiclePic.fromJson(json['vehiclePic'])
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

class UserInfoModelDataProfilePic {
/*
{
  "key": "usersProfile/32a90ccd-22b5-4234-a005-4774b362fe6a-undefined",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/32a90ccd-22b5-4234-a005-4774b362fe6a-undefined"
} 
*/

  String? key;
  String? url;

  UserInfoModelDataProfilePic({
    this.key,
    this.url,
  });
  UserInfoModelDataProfilePic.fromJson(Map<String, dynamic> json) {
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

class UserInfoModelDataIdPic {
/*
{
  "key": "idPic/c20c3eae-83b7-4e9d-99d2-03120c009b66-undefined",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/c20c3eae-83b7-4e9d-99d2-03120c009b66-undefined"
} 
*/

  String? key;
  String? url;

  UserInfoModelDataIdPic({
    this.key,
    this.url,
  });
  UserInfoModelDataIdPic.fromJson(Map<String, dynamic> json) {
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

class UserInfoModelData {
/*
{
  "_id": "65c2400c32f497dc57fdf007",
  "fullName": "Rekha Dutta",
  "phone": "+11234567567",
  "email": "rekha@test.com",
  "city": "City",
  "dob": "1996-02-22",
  "gender": "Female",
  "isDriver": true,
  "referralCode": "V0280Q1170",
  "profileStatus": true,
  "vehicleStatus": true,
  "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
  "firebaseSignInProvider": "phone",
  "createdAt": "2024-02-06T14:19:56.214Z",
  "updatedAt": "2024-02-06T14:54:23.989Z",
  "idPic": {
    "key": "idPic/c20c3eae-83b7-4e9d-99d2-03120c009b66-undefined",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/c20c3eae-83b7-4e9d-99d2-03120c009b66-undefined"
  },
  "profilePic": {
    "key": "usersProfile/32a90ccd-22b5-4234-a005-4774b362fe6a-undefined",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/32a90ccd-22b5-4234-a005-4774b362fe6a-undefined"
  },
  "status": "active",
  "vehicleDetails": [
    {
      "_id": "65c2481f32f497dc57fdf01f",
      "driverId": "65c2400c32f497dc57fdf007",
      "vehiclePic": {
        "key": "vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
        "_id": "65c2481f32f497dc57fdf020"
      },
      "model": "ModelY",
      "type": "Convertible",
      "color": "Red",
      "year": 2024,
      "licencePlate": "LA2024",
      "createdAt": "2024-02-06T14:54:23.830Z",
      "updatedAt": "2024-02-06T14:54:23.830Z"
    }
  ],
  "emergencyContactDetails": [
    {
      "_id": "65b652a850b73ac0b979d80b",
      "userId": "65b646d12493cd72d4d8cc2d",
      "fullName": "karan",
      "phone": "098765",
      "createdAt": "2024-01-28T13:12:08.270Z",
      "updatedAt": "2024-01-28T13:12:08.270Z"
    }
  ]
} 
*/

  String? Id;
  String? fullName;
  String? phone;
  String? email;
  String? city;
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
  UserInfoModelDataIdPic? idPic;
  UserInfoModelDataProfilePic? profilePic;
  String? status;
  List<UserInfoModelDataVehicleDetails?>? vehicleDetails;
  List<UserInfoModelDataEmergencyContactDetails?>? emergencyContactDetails;

  UserInfoModelData({
    this.Id,
    this.fullName,
    this.phone,
    this.email,
    this.city,
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
    this.vehicleDetails,
    this.emergencyContactDetails,
  });
  UserInfoModelData.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    fullName = json['fullName']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    city = json['city']?.toString();
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
        ? UserInfoModelDataIdPic.fromJson(json['idPic'])
        : null;
    profilePic = (json['profilePic'] != null)
        ? UserInfoModelDataProfilePic.fromJson(json['profilePic'])
        : null;
    status = json['status']?.toString();
    if (json['vehicleDetails'] != null) {
      final v = json['vehicleDetails'];
      final arr0 = <UserInfoModelDataVehicleDetails>[];
      v.forEach((v) {
        arr0.add(UserInfoModelDataVehicleDetails.fromJson(v));
      });
      vehicleDetails = arr0;
    }
    if (json['emergencyContactDetails'] != null) {
      final v = json['emergencyContactDetails'];
      final arr0 = <UserInfoModelDataEmergencyContactDetails>[];
      v.forEach((v) {
        arr0.add(UserInfoModelDataEmergencyContactDetails.fromJson(v));
      });
      emergencyContactDetails = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['city'] = city;
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
    if (vehicleDetails != null) {
      final v = vehicleDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['vehicleDetails'] = arr0;
    }
    if (emergencyContactDetails != null) {
      final v = emergencyContactDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['emergencyContactDetails'] = arr0;
    }
    return data;
  }
}

class UserInfoModel {
/*
{
  "status": true,
  "data": {
    "_id": "65c2400c32f497dc57fdf007",
    "fullName": "Rekha Dutta",
    "phone": "+11234567567",
    "email": "rekha@test.com",
    "city": "City",
    "dob": "1996-02-22",
    "gender": "Female",
    "isDriver": true,
    "referralCode": "V0280Q1170",
    "profileStatus": true,
    "vehicleStatus": true,
    "firebaseUid": "7ip7bk892LOYGNlleO2ebucHidB3",
    "firebaseSignInProvider": "phone",
    "createdAt": "2024-02-06T14:19:56.214Z",
    "updatedAt": "2024-02-06T14:54:23.989Z",
    "idPic": {
      "key": "idPic/c20c3eae-83b7-4e9d-99d2-03120c009b66-undefined",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/c20c3eae-83b7-4e9d-99d2-03120c009b66-undefined"
    },
    "profilePic": {
      "key": "usersProfile/32a90ccd-22b5-4234-a005-4774b362fe6a-undefined",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/32a90ccd-22b5-4234-a005-4774b362fe6a-undefined"
    },
    "status": "active",
    "vehicleDetails": [
      {
        "_id": "65c2481f32f497dc57fdf01f",
        "driverId": "65c2400c32f497dc57fdf007",
        "vehiclePic": {
          "key": "vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
          "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/205d297d-5740-461b-b33e-4aa39224aace-1000000034.jpg",
          "_id": "65c2481f32f497dc57fdf020"
        },
        "model": "ModelY",
        "type": "Convertible",
        "color": "Red",
        "year": 2024,
        "licencePlate": "LA2024",
        "createdAt": "2024-02-06T14:54:23.830Z",
        "updatedAt": "2024-02-06T14:54:23.830Z"
      }
    ],
    "emergencyContactDetails": [
      {
        "_id": "65b652a850b73ac0b979d80b",
        "userId": "65b646d12493cd72d4d8cc2d",
        "fullName": "karan",
        "phone": "098765",
        "createdAt": "2024-01-28T13:12:08.270Z",
        "updatedAt": "2024-01-28T13:12:08.270Z"
      }
    ]
  },
  "message": "success"
} 
*/

  bool? status;
  UserInfoModelData? data;
  String? message;

  UserInfoModel({
    this.status,
    this.data,
    this.message,
  });
  UserInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null)
        ? UserInfoModelData.fromJson(json['data'])
        : null;
    message = json['message']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data!.toJson();
    data['message'] = message;
    return data;
  }
}
