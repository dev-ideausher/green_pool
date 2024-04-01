
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

class RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsProfilePic {
/*
{
  "key": "usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile pic 3.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile%20pic%203.jpg"
} 
*/

  String? key;
  String? url;

  RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsProfilePic({
    this.key,
    this.url,
  });
  RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsProfilePic.fromJson(
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

class RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsIdPic {
/*
{
  "key": "idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile pic 3.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile%20pic%203.jpg"
} 
*/

  String? key;
  String? url;

  RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsIdPic({
    this.key,
    this.url,
  });
  RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsIdPic.fromJson(
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

class RiderConfirmRequestModelDataDriverRideDetailsDriverDetails {
/*
{
  "_id": "65c228fd32f497dc57fdeff8",
  "fullName": "Rohit Shah",
  "phone": "1111122222",
  "email": "rohit@test.com",
  "dob": "2006-02-27",
  "gender": "Male",
  "isDriver": true,
  "referralCode": "C3072B8509",
  "profileStatus": true,
  "vehicleStatus": true,
  "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
  "firebaseSignInProvider": "phone",
  "createdAt": "2024-02-06T12:41:33.824Z",
  "updatedAt": "2024-03-01T14:00:55.337Z",
  "idPic": {
    "key": "idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile pic 3.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile%20pic%203.jpg"
  },
  "profilePic": {
    "key": "usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile pic 3.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile%20pic%203.jpg"
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
  RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsIdPic? idPic;
  RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsProfilePic?
      profilePic;
  String? status;

  RiderConfirmRequestModelDataDriverRideDetailsDriverDetails({
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
  RiderConfirmRequestModelDataDriverRideDetailsDriverDetails.fromJson(
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
        ? RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsIdPic
            .fromJson(json['idPic'])
        : null;
    profilePic = (json['profilePic'] != null)
        ? RiderConfirmRequestModelDataDriverRideDetailsDriverDetailsProfilePic
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

class RiderConfirmRequestModelDataDriverRideDetailsPreferencesOther {
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

  RiderConfirmRequestModelDataDriverRideDetailsPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  RiderConfirmRequestModelDataDriverRideDetailsPreferencesOther.fromJson(
      Map<String, dynamic> json) {
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

class RiderConfirmRequestModelDataDriverRideDetailsPreferences {
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
  RiderConfirmRequestModelDataDriverRideDetailsPreferencesOther? other;

  RiderConfirmRequestModelDataDriverRideDetailsPreferences({
    this.seatAvailable,
    this.luggageType,
    this.other,
  });
  RiderConfirmRequestModelDataDriverRideDetailsPreferences.fromJson(
      Map<String, dynamic> json) {
    seatAvailable = json['seatAvailable']?.toInt();
    luggageType = json['luggageType']?.toString();
    other = (json['other'] != null)
        ? RiderConfirmRequestModelDataDriverRideDetailsPreferencesOther
            .fromJson(json['other'])
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

class RiderConfirmRequestModelDataDriverRideDetailsReturnTrip {
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

  RiderConfirmRequestModelDataDriverRideDetailsReturnTrip({
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  RiderConfirmRequestModelDataDriverRideDetailsReturnTrip.fromJson(
      Map<String, dynamic> json) {
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

class RiderConfirmRequestModelDataDriverRideDetailsStops {
/*
{
  "name": "Andheri,Mumbai Suburban,Konkan Division",
  "type": "Point",
  "coordinates": [
    72.8697339
  ],
  "_id": "65ddb242e52406bcf4b8cf6e"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? Id;

  RiderConfirmRequestModelDataDriverRideDetailsStops({
    this.name,
    this.type,
    this.coordinates,
    this.Id,
  });
  RiderConfirmRequestModelDataDriverRideDetailsStops.fromJson(
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

class RiderConfirmRequestModelDataDriverRideDetailsDestination {
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

  RiderConfirmRequestModelDataDriverRideDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  RiderConfirmRequestModelDataDriverRideDetailsDestination.fromJson(
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

class RiderConfirmRequestModelDataDriverRideDetailsOrigin {
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

  RiderConfirmRequestModelDataDriverRideDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
  });
  RiderConfirmRequestModelDataDriverRideDetailsOrigin.fromJson(
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

class RiderConfirmRequestModelDataDriverRideDetails {
/*
{
  "_id": "65ddb242e52406bcf4b8cf6d",
  "driverId": "65c228fd32f497dc57fdeff8",
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
      "_id": "65ddb242e52406bcf4b8cf6e"
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
    "65c2400c32f497dc57fdf007"
  ],
  "createdAt": "2024-02-27T09:58:26.560Z",
  "updatedAt": "2024-03-01T13:25:51.917Z",
  "driverDetails": [
    {
      "_id": "65c228fd32f497dc57fdeff8",
      "fullName": "Rohit Shah",
      "phone": "1111122222",
      "email": "rohit@test.com",
      "dob": "2006-02-27",
      "gender": "Male",
      "isDriver": true,
      "referralCode": "C3072B8509",
      "profileStatus": true,
      "vehicleStatus": true,
      "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
      "firebaseSignInProvider": "phone",
      "createdAt": "2024-02-06T12:41:33.824Z",
      "updatedAt": "2024-03-01T14:00:55.337Z",
      "idPic": {
        "key": "idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile pic 3.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile%20pic%203.jpg"
      },
      "profilePic": {
        "key": "usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile pic 3.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile%20pic%203.jpg"
      },
      "status": "active"
    }
  ]
} 
*/

  String? Id;
  String? driverId;
  RiderConfirmRequestModelDataDriverRideDetailsOrigin? origin;
  RiderConfirmRequestModelDataDriverRideDetailsDestination? destination;
  List<RiderConfirmRequestModelDataDriverRideDetailsStops?>? stops;
  String? tripType;
  String? date;
  String? time;
  RiderConfirmRequestModelDataDriverRideDetailsReturnTrip? returnTrip;
  String? arrivalDate;
  String? arrivalTime;
  RiderConfirmRequestModelDataDriverRideDetailsPreferences? preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  String? fair;
  List<String?>? riders;
  String? createdAt;
  String? updatedAt;
  List<RiderConfirmRequestModelDataDriverRideDetailsDriverDetails?>?
      driverDetails;

  RiderConfirmRequestModelDataDriverRideDetails({
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
    this.driverDetails,
  });
  RiderConfirmRequestModelDataDriverRideDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    origin = (json['origin'] != null)
        ? RiderConfirmRequestModelDataDriverRideDetailsOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? RiderConfirmRequestModelDataDriverRideDetailsDestination.fromJson(
            json['destination'])
        : null;
    if (json['stops'] != null) {
      final v = json['stops'];
      final arr0 = <RiderConfirmRequestModelDataDriverRideDetailsStops>[];
      v.forEach((v) {
        arr0.add(
            RiderConfirmRequestModelDataDriverRideDetailsStops.fromJson(v));
      });
      stops = arr0;
    }
    tripType = json['tripType']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    returnTrip = (json['returnTrip'] != null)
        ? RiderConfirmRequestModelDataDriverRideDetailsReturnTrip.fromJson(
            json['returnTrip'])
        : null;
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    preferences = (json['preferences'] != null)
        ? RiderConfirmRequestModelDataDriverRideDetailsPreferences.fromJson(
            json['preferences'])
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
    if (json['driverDetails'] != null) {
      final v = json['driverDetails'];
      final arr0 =
          <RiderConfirmRequestModelDataDriverRideDetailsDriverDetails>[];
      v.forEach((v) {
        arr0.add(
            RiderConfirmRequestModelDataDriverRideDetailsDriverDetails.fromJson(
                v));
      });
      driverDetails = arr0;
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
    if (driverDetails != null) {
      final v = driverDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['driverDetails'] = arr0;
    }
    return data;
  }
}

class RiderConfirmRequestModelDataDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  RiderConfirmRequestModelDataDropOffStatus({
    this.isDropOff,
  });
  RiderConfirmRequestModelDataDropOffStatus.fromJson(
      Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class RiderConfirmRequestModelDataPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  RiderConfirmRequestModelDataPickUpStatus({
    this.isPickUp,
  });
  RiderConfirmRequestModelDataPickUpStatus.fromJson(Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class RiderConfirmRequestModelData {
/*
{
  "_id": "65f04fa6f4372ec0771123b2",
  "driverRideId": "65ddb242e52406bcf4b8cf6d",
  "riderRideId": "65e5c473774b9be9e4342eaa",
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
  "driverId": "65c228fd32f497dc57fdeff8",
  "createdAt": "2024-03-12T12:50:46.157Z",
  "updatedAt": "2024-03-12T12:50:46.157Z",
  "driverRideDetails": [
    {
      "_id": "65ddb242e52406bcf4b8cf6d",
      "driverId": "65c228fd32f497dc57fdeff8",
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
          "_id": "65ddb242e52406bcf4b8cf6e"
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
        "65c2400c32f497dc57fdf007"
      ],
      "createdAt": "2024-02-27T09:58:26.560Z",
      "updatedAt": "2024-03-01T13:25:51.917Z",
      "driverDetails": [
        {
          "_id": "65c228fd32f497dc57fdeff8",
          "fullName": "Rohit Shah",
          "phone": "1111122222",
          "email": "rohit@test.com",
          "dob": "2006-02-27",
          "gender": "Male",
          "isDriver": true,
          "referralCode": "C3072B8509",
          "profileStatus": true,
          "vehicleStatus": true,
          "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
          "firebaseSignInProvider": "phone",
          "createdAt": "2024-02-06T12:41:33.824Z",
          "updatedAt": "2024-03-01T14:00:55.337Z",
          "idPic": {
            "key": "idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile pic 3.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile%20pic%203.jpg"
          },
          "profilePic": {
            "key": "usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile pic 3.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile%20pic%203.jpg"
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
  RiderConfirmRequestModelDataPickUpStatus? pickUpStatus;
  RiderConfirmRequestModelDataDropOffStatus? dropOffStatus;
  bool? isCompleted;
  String? driverId;
  String? createdAt;
  String? updatedAt;
  List<RiderConfirmRequestModelDataDriverRideDetails?>? driverRideDetails;

  RiderConfirmRequestModelData({
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
    this.driverRideDetails,
  });
  RiderConfirmRequestModelData.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    distance = json['distance']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    pickUpStatus = (json['pickUpStatus'] != null)
        ? RiderConfirmRequestModelDataPickUpStatus.fromJson(
            json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? RiderConfirmRequestModelDataDropOffStatus.fromJson(
            json['dropOffStatus'])
        : null;
    isCompleted = json['isCompleted'];
    driverId = json['driverId']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['driverRideDetails'] != null) {
      final v = json['driverRideDetails'];
      final arr0 = <RiderConfirmRequestModelDataDriverRideDetails>[];
      v.forEach((v) {
        arr0.add(RiderConfirmRequestModelDataDriverRideDetails.fromJson(v));
      });
      driverRideDetails = arr0;
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
    if (driverRideDetails != null) {
      final v = driverRideDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['driverRideDetails'] = arr0;
    }
    return data;
  }
}

class RiderConfirmRequestModel {
/*
{
  "status": true,
  "message": "success",
  "data": [
    {
      "_id": "65f04fa6f4372ec0771123b2",
      "driverRideId": "65ddb242e52406bcf4b8cf6d",
      "riderRideId": "65e5c473774b9be9e4342eaa",
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
      "driverId": "65c228fd32f497dc57fdeff8",
      "createdAt": "2024-03-12T12:50:46.157Z",
      "updatedAt": "2024-03-12T12:50:46.157Z",
      "driverRideDetails": [
        {
          "_id": "65ddb242e52406bcf4b8cf6d",
          "driverId": "65c228fd32f497dc57fdeff8",
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
              "_id": "65ddb242e52406bcf4b8cf6e"
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
            "65c2400c32f497dc57fdf007"
          ],
          "createdAt": "2024-02-27T09:58:26.560Z",
          "updatedAt": "2024-03-01T13:25:51.917Z",
          "driverDetails": [
            {
              "_id": "65c228fd32f497dc57fdeff8",
              "fullName": "Rohit Shah",
              "phone": "1111122222",
              "email": "rohit@test.com",
              "dob": "2006-02-27",
              "gender": "Male",
              "isDriver": true,
              "referralCode": "C3072B8509",
              "profileStatus": true,
              "vehicleStatus": true,
              "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
              "firebaseSignInProvider": "phone",
              "createdAt": "2024-02-06T12:41:33.824Z",
              "updatedAt": "2024-03-01T14:00:55.337Z",
              "idPic": {
                "key": "idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile pic 3.jpg",
                "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/7965beea-8b92-4ea6-b136-fcf4f618f832-profile%20pic%203.jpg"
              },
              "profilePic": {
                "key": "usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile pic 3.jpg",
                "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/4d183aa4-88e2-4213-ba4b-ac4d3f635529-profile%20pic%203.jpg"
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

  bool? status;
  String? message;
  List<RiderConfirmRequestModelData?>? data;

  RiderConfirmRequestModel({
    this.status,
    this.message,
    this.data,
  });
  RiderConfirmRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <RiderConfirmRequestModelData>[];
      v.forEach((v) {
        arr0.add(RiderConfirmRequestModelData.fromJson(v));
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
