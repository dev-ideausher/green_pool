// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

class DriverConfirmRequestModelDataRideDetailsRiderDetailsNotificationPreferences {
/*
{
  "trip": false,
  "alerts": false,
  "payments": false,
  "transactions": false,
  "offers": false
} 
*/

  bool? trip;
  bool? alerts;
  bool? payments;
  bool? transactions;
  bool? offers;

  DriverConfirmRequestModelDataRideDetailsRiderDetailsNotificationPreferences({
    this.trip,
    this.alerts,
    this.payments,
    this.transactions,
    this.offers,
  });
  DriverConfirmRequestModelDataRideDetailsRiderDetailsNotificationPreferences.fromJson(
      Map<String, dynamic> json) {
    trip = json['trip'];
    alerts = json['alerts'];
    payments = json['payments'];
    transactions = json['transactions'];
    offers = json['offers'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['trip'] = trip;
    data['alerts'] = alerts;
    data['payments'] = payments;
    data['transactions'] = transactions;
    data['offers'] = offers;
    return data;
  }
}

class DriverConfirmRequestModelDataRideDetailsRiderDetailsProfilePic {
/*
{
  "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
} 
*/

  String? key;
  String? url;

  DriverConfirmRequestModelDataRideDetailsRiderDetailsProfilePic({
    this.key,
    this.url,
  });
  DriverConfirmRequestModelDataRideDetailsRiderDetailsProfilePic.fromJson(
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

class DriverConfirmRequestModelDataRideDetailsRiderDetailsIdPic {
/*
{
  "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
} 
*/

  String? key;
  String? url;

  DriverConfirmRequestModelDataRideDetailsRiderDetailsIdPic({
    this.key,
    this.url,
  });
  DriverConfirmRequestModelDataRideDetailsRiderDetailsIdPic.fromJson(
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

class DriverConfirmRequestModelDataRideDetailsRiderDetails {
/*
{
  "_id": "65c2400c32f497dc57fdf007",
  "fullName": "Amod",
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
  "updatedAt": "2024-04-25T06:07:47.424Z",
  "idPic": {
    "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
  },
  "profilePic": {
    "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
  },
  "status": "active",
  "city": "Jaipur",
  "pinkMode": false,
  "notificationPreferences": {
    "trip": false,
    "alerts": false,
    "payments": false,
    "transactions": false,
    "offers": false
  },
  "rating": 0,
  "totalRides": 0
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
  DriverConfirmRequestModelDataRideDetailsRiderDetailsIdPic? idPic;
  DriverConfirmRequestModelDataRideDetailsRiderDetailsProfilePic? profilePic;
  String? status;
  String? city;
  bool? pinkMode;
  DriverConfirmRequestModelDataRideDetailsRiderDetailsNotificationPreferences?
      notificationPreferences;
  double? rating;
  int? totalRides;

  DriverConfirmRequestModelDataRideDetailsRiderDetails({
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
    this.city,
    this.pinkMode,
    this.notificationPreferences,
    this.rating,
    this.totalRides,
  });
  DriverConfirmRequestModelDataRideDetailsRiderDetails.fromJson(
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
        ? DriverConfirmRequestModelDataRideDetailsRiderDetailsIdPic.fromJson(
            json['idPic'])
        : null;
    profilePic = (json['profilePic'] != null)
        ? DriverConfirmRequestModelDataRideDetailsRiderDetailsProfilePic
            .fromJson(json['profilePic'])
        : null;
    status = json['status']?.toString();
    city = json['city']?.toString();
    pinkMode = json['pinkMode'];
    notificationPreferences = (json['notificationPreferences'] != null)
        ? DriverConfirmRequestModelDataRideDetailsRiderDetailsNotificationPreferences
            .fromJson(json['notificationPreferences'])
        : null;
    rating = json['rating']?.toDouble();
    totalRides = json['totalRides']?.toInt();
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
    data['city'] = city;
    data['pinkMode'] = pinkMode;
    if (notificationPreferences != null) {
      data['notificationPreferences'] = notificationPreferences!.toJson();
    }
    data['rating'] = rating;
    data['totalRides'] = totalRides;
    return data;
  }
}

class DriverConfirmRequestModelDataRideDetailsPreferencesOther {
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

  DriverConfirmRequestModelDataRideDetailsPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  DriverConfirmRequestModelDataRideDetailsPreferencesOther.fromJson(
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

class DriverConfirmRequestModelDataRideDetailsPreferences {
/*
{
  "other": {
    "AppreciatesConversation": false,
    "EnjoysMusic": false,
    "SmokeFree": false,
    "PetFriendly": false,
    "WinterTires": false,
    "CoolingOrHeating": false,
    "BabySeat": false,
    "HeatedSeats": false
  },
  "luggageType": null
} 
*/

  DriverConfirmRequestModelDataRideDetailsPreferencesOther? other;
  String? luggageType;

  DriverConfirmRequestModelDataRideDetailsPreferences({
    this.other,
    this.luggageType,
  });
  DriverConfirmRequestModelDataRideDetailsPreferences.fromJson(
      Map<String, dynamic> json) {
    other = (json['other'] != null)
        ? DriverConfirmRequestModelDataRideDetailsPreferencesOther.fromJson(
            json['other'])
        : null;
    luggageType = json['luggageType']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (other != null) {
      data['other'] = other!.toJson();
    }
    data['luggageType'] = luggageType;
    return data;
  }
}

class DriverConfirmRequestModelDataRideDetailsReturnTrip {
/*
{
  "returnTripId": null,
  "isReturnTrip": false,
  "returnDate": null,
  "returnTime": null
} 
*/

  String? returnTripId;
  bool? isReturnTrip;
  String? returnDate;
  String? returnTime;

  DriverConfirmRequestModelDataRideDetailsReturnTrip({
    this.returnTripId,
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  DriverConfirmRequestModelDataRideDetailsReturnTrip.fromJson(
      Map<String, dynamic> json) {
    returnTripId = json['returnTripId']?.toString();
    isReturnTrip = json['isReturnTrip'];
    returnDate = json['returnDate']?.toString();
    returnTime = json['returnTime']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['returnTripId'] = returnTripId;
    data['isReturnTrip'] = isReturnTrip;
    data['returnDate'] = returnDate;
    data['returnTime'] = returnTime;
    return data;
  }
}

class DriverConfirmRequestModelDataRideDetailsRecurringTrip {
/*
{
  "recurringTripIds": [
    "121212"
  ],
  "recurringTripDays": [
    1
  ],
  "isRecurringTripEnabled": false
} 
*/

  List<String?>? recurringTripIds;
  List<int?>? recurringTripDays;
  bool? isRecurringTripEnabled;

  DriverConfirmRequestModelDataRideDetailsRecurringTrip({
    this.recurringTripIds,
    this.recurringTripDays,
    this.isRecurringTripEnabled,
  });
  DriverConfirmRequestModelDataRideDetailsRecurringTrip.fromJson(
      Map<String, dynamic> json) {
    if (json['recurringTripIds'] != null) {
      final v = json['recurringTripIds'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      recurringTripIds = arr0;
    }
    if (json['recurringTripDays'] != null) {
      final v = json['recurringTripDays'];
      final arr0 = <int>[];
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      recurringTripDays = arr0;
    }
    isRecurringTripEnabled = json['isRecurringTripEnabled'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (recurringTripIds != null) {
      final v = recurringTripIds;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['recurringTripIds'] = arr0;
    }
    if (recurringTripDays != null) {
      final v = recurringTripDays;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['recurringTripDays'] = arr0;
    }
    data['isRecurringTripEnabled'] = isRecurringTripEnabled;
    return data;
  }
}

class DriverConfirmRequestModelDataRideDetailsDestination {
/*
{
  "name": "Noida Sector 18, Noida",
  "type": "Point",
  "coordinates": [
    77.32490430000001
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  DriverConfirmRequestModelDataRideDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  DriverConfirmRequestModelDataRideDetailsDestination.fromJson(
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

class DriverConfirmRequestModelDataRideDetailsOrigin {
/*
{
  "name": "297, New Delhi",
  "type": "Point",
  "coordinates": [
    77.30131209999999
  ],
  "originDestinationFair": null
} 
*/

  String? name;
  String? type;
  List<double>? coordinates;
  String? originDestinationFair;

  DriverConfirmRequestModelDataRideDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
    this.originDestinationFair,
  });
  DriverConfirmRequestModelDataRideDetailsOrigin.fromJson(
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
    originDestinationFair = json['originDestinationFair']?.toString();
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
    data['originDestinationFair'] = originDestinationFair;
    return data;
  }
}

class DriverConfirmRequestModelDataRideDetails {
/*
{
  "_id": "6629046add6fa0724db701eb",
  "riderId": "65c2400c32f497dc57fdf007",
  "origin": {
    "name": "297, New Delhi",
    "type": "Point",
    "coordinates": [
      77.30131209999999
    ],
    "originDestinationFair": null
  },
  "destination": {
    "name": "Noida Sector 18, Noida",
    "type": "Point",
    "coordinates": [
      77.32490430000001
    ]
  },
  "tripType": null,
  "recurringTrip": {
    "recurringTripIds": [
      "121212"
    ],
    "recurringTripDays": [
      1
    ],
    "isRecurringTripEnabled": false
  },
  "date": null,
  "time": "",
  "returnTrip": {
    "returnTripId": null,
    "isReturnTrip": false,
    "returnDate": null,
    "returnTime": null
  },
  "arrivalDate": null,
  "arrivalTime": null,
  "seatAvailable": 1,
  "preferences": {
    "other": {
      "AppreciatesConversation": false,
      "EnjoysMusic": false,
      "SmokeFree": false,
      "PetFriendly": false,
      "WinterTires": false,
      "CoolingOrHeating": false,
      "BabySeat": false,
      "HeatedSeats": false
    },
    "luggageType": null
  },
  "isStarted": false,
  "isCompleted": false,
  "isCancelled": false,
  "description": "need a ride",
  "createdAt": "2024-04-24T13:08:58.701Z",
  "updatedAt": "2024-04-24T13:08:58.701Z",
  "riderDetails": [
    {
      "_id": "65c2400c32f497dc57fdf007",
      "fullName": "Amod",
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
      "updatedAt": "2024-04-25T06:07:47.424Z",
      "idPic": {
        "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
      },
      "profilePic": {
        "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
      },
      "status": "active",
      "city": "Jaipur",
      "pinkMode": false,
      "notificationPreferences": {
        "trip": false,
        "alerts": false,
        "payments": false,
        "transactions": false,
        "offers": false
      },
      "rating": 0,
      "totalRides": 0
    }
  ]
} 
*/

  String? Id;
  String? riderId;
  DriverConfirmRequestModelDataRideDetailsOrigin? origin;
  DriverConfirmRequestModelDataRideDetailsDestination? destination;
  String? tripType;
  DriverConfirmRequestModelDataRideDetailsRecurringTrip? recurringTrip;
  String? date;
  String? time;
  DriverConfirmRequestModelDataRideDetailsReturnTrip? returnTrip;
  String? arrivalDate;
  String? arrivalTime;
  int? seatAvailable;
  DriverConfirmRequestModelDataRideDetailsPreferences? preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<DriverConfirmRequestModelDataRideDetailsRiderDetails?>? riderDetails;

  DriverConfirmRequestModelDataRideDetails({
    this.Id,
    this.riderId,
    this.origin,
    this.destination,
    this.tripType,
    this.recurringTrip,
    this.date,
    this.time,
    this.returnTrip,
    this.arrivalDate,
    this.arrivalTime,
    this.seatAvailable,
    this.preferences,
    this.isStarted,
    this.isCompleted,
    this.isCancelled,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.riderDetails,
  });
  DriverConfirmRequestModelDataRideDetails.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    riderId = json['riderId']?.toString();
    origin = (json['origin'] != null)
        ? DriverConfirmRequestModelDataRideDetailsOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? DriverConfirmRequestModelDataRideDetailsDestination.fromJson(
            json['destination'])
        : null;
    tripType = json['tripType']?.toString();
    recurringTrip = (json['recurringTrip'] != null)
        ? DriverConfirmRequestModelDataRideDetailsRecurringTrip.fromJson(
            json['recurringTrip'])
        : null;
    date = json['date']?.toString();
    time = json['time']?.toString();
    returnTrip = (json['returnTrip'] != null)
        ? DriverConfirmRequestModelDataRideDetailsReturnTrip.fromJson(
            json['returnTrip'])
        : null;
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    seatAvailable = json['seatAvailable']?.toInt();
    preferences = (json['preferences'] != null)
        ? DriverConfirmRequestModelDataRideDetailsPreferences.fromJson(
            json['preferences'])
        : null;
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    description = json['description']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['riderDetails'] != null) {
      final v = json['riderDetails'];
      final arr0 = <DriverConfirmRequestModelDataRideDetailsRiderDetails>[];
      v.forEach((v) {
        arr0.add(
            DriverConfirmRequestModelDataRideDetailsRiderDetails.fromJson(v));
      });
      riderDetails = arr0;
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
    data['tripType'] = tripType;
    if (recurringTrip != null) {
      data['recurringTrip'] = recurringTrip!.toJson();
    }
    data['date'] = date;
    data['time'] = time;
    if (returnTrip != null) {
      data['returnTrip'] = returnTrip!.toJson();
    }
    data['arrivalDate'] = arrivalDate;
    data['arrivalTime'] = arrivalTime;
    data['seatAvailable'] = seatAvailable;
    if (preferences != null) {
      data['preferences'] = preferences!.toJson();
    }
    data['isStarted'] = isStarted;
    data['isCompleted'] = isCompleted;
    data['isCancelled'] = isCancelled;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (riderDetails != null) {
      final v = riderDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['riderDetails'] = arr0;
    }
    return data;
  }
}

class DriverConfirmRequestModelDataDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  DriverConfirmRequestModelDataDropOffStatus({
    this.isDropOff,
  });
  DriverConfirmRequestModelDataDropOffStatus.fromJson(
      Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class DriverConfirmRequestModelDataPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  DriverConfirmRequestModelDataPickUpStatus({
    this.isPickUp,
  });
  DriverConfirmRequestModelDataPickUpStatus.fromJson(
      Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class DriverConfirmRequestModelData {
/*
{
  "_id": "6629046add6fa0724db701ed",
  "driverRideId": "6628ac50f5a8972e41e502da",
  "riderRideId": "6629046add6fa0724db701eb",
  "distance": "82.41833502449377",
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
  "driverId": "661d27690ae69f9b5509f84d",
  "riderId": "65c2400c32f497dc57fdf007",
  "createdAt": "2024-04-24T13:08:58.871Z",
  "updatedAt": "2024-04-24T13:08:58.871Z",
  "rideDetails": [
    {
      "_id": "6629046add6fa0724db701eb",
      "riderId": "65c2400c32f497dc57fdf007",
      "origin": {
        "name": "297, New Delhi",
        "type": "Point",
        "coordinates": [
          77.30131209999999
        ],
        "originDestinationFair": null
      },
      "destination": {
        "name": "Noida Sector 18, Noida",
        "type": "Point",
        "coordinates": [
          77.32490430000001
        ]
      },
      "tripType": null,
      "recurringTrip": {
        "recurringTripIds": [
          "121212"
        ],
        "recurringTripDays": [
          1
        ],
        "isRecurringTripEnabled": false
      },
      "date": null,
      "time": "",
      "returnTrip": {
        "returnTripId": null,
        "isReturnTrip": false,
        "returnDate": null,
        "returnTime": null
      },
      "arrivalDate": null,
      "arrivalTime": null,
      "seatAvailable": 1,
      "preferences": {
        "other": {
          "AppreciatesConversation": false,
          "EnjoysMusic": false,
          "SmokeFree": false,
          "PetFriendly": false,
          "WinterTires": false,
          "CoolingOrHeating": false,
          "BabySeat": false,
          "HeatedSeats": false
        },
        "luggageType": null
      },
      "isStarted": false,
      "isCompleted": false,
      "isCancelled": false,
      "description": "need a ride",
      "createdAt": "2024-04-24T13:08:58.701Z",
      "updatedAt": "2024-04-24T13:08:58.701Z",
      "riderDetails": [
        {
          "_id": "65c2400c32f497dc57fdf007",
          "fullName": "Amod",
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
          "updatedAt": "2024-04-25T06:07:47.424Z",
          "idPic": {
            "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
          },
          "profilePic": {
            "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
          },
          "status": "active",
          "city": "Jaipur",
          "pinkMode": false,
          "notificationPreferences": {
            "trip": false,
            "alerts": false,
            "payments": false,
            "transactions": false,
            "offers": false
          },
          "rating": 0,
          "totalRides": 0
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
  DriverConfirmRequestModelDataPickUpStatus? pickUpStatus;
  DriverConfirmRequestModelDataDropOffStatus? dropOffStatus;
  bool? isCompleted;
  String? driverId;
  String? riderId;
  String? createdAt;
  String? updatedAt;
  List<DriverConfirmRequestModelDataRideDetails?>? rideDetails;

  DriverConfirmRequestModelData({
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
    this.riderId,
    this.createdAt,
    this.updatedAt,
    this.rideDetails,
  });
  DriverConfirmRequestModelData.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    distance = json['distance']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    pickUpStatus = (json['pickUpStatus'] != null)
        ? DriverConfirmRequestModelDataPickUpStatus.fromJson(
            json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? DriverConfirmRequestModelDataDropOffStatus.fromJson(
            json['dropOffStatus'])
        : null;
    isCompleted = json['isCompleted'];
    driverId = json['driverId']?.toString();
    riderId = json['riderId']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['rideDetails'] != null) {
      final v = json['rideDetails'];
      final arr0 = <DriverConfirmRequestModelDataRideDetails>[];
      v.forEach((v) {
        arr0.add(DriverConfirmRequestModelDataRideDetails.fromJson(v));
      });
      rideDetails = arr0;
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
    data['riderId'] = riderId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (rideDetails != null) {
      final v = rideDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['rideDetails'] = arr0;
    }
    return data;
  }
}

class DriverConfirmRequestModel {
/*
{
  "status": true,
  "message": "success",
  "data": [
    {
      "_id": "6629046add6fa0724db701ed",
      "driverRideId": "6628ac50f5a8972e41e502da",
      "riderRideId": "6629046add6fa0724db701eb",
      "distance": "82.41833502449377",
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
      "driverId": "661d27690ae69f9b5509f84d",
      "riderId": "65c2400c32f497dc57fdf007",
      "createdAt": "2024-04-24T13:08:58.871Z",
      "updatedAt": "2024-04-24T13:08:58.871Z",
      "rideDetails": [
        {
          "_id": "6629046add6fa0724db701eb",
          "riderId": "65c2400c32f497dc57fdf007",
          "origin": {
            "name": "297, New Delhi",
            "type": "Point",
            "coordinates": [
              77.30131209999999
            ],
            "originDestinationFair": null
          },
          "destination": {
            "name": "Noida Sector 18, Noida",
            "type": "Point",
            "coordinates": [
              77.32490430000001
            ]
          },
          "tripType": null,
          "recurringTrip": {
            "recurringTripIds": [
              "121212"
            ],
            "recurringTripDays": [
              1
            ],
            "isRecurringTripEnabled": false
          },
          "date": null,
          "time": "",
          "returnTrip": {
            "returnTripId": null,
            "isReturnTrip": false,
            "returnDate": null,
            "returnTime": null
          },
          "arrivalDate": null,
          "arrivalTime": null,
          "seatAvailable": 1,
          "preferences": {
            "other": {
              "AppreciatesConversation": false,
              "EnjoysMusic": false,
              "SmokeFree": false,
              "PetFriendly": false,
              "WinterTires": false,
              "CoolingOrHeating": false,
              "BabySeat": false,
              "HeatedSeats": false
            },
            "luggageType": null
          },
          "isStarted": false,
          "isCompleted": false,
          "isCancelled": false,
          "description": "need a ride",
          "createdAt": "2024-04-24T13:08:58.701Z",
          "updatedAt": "2024-04-24T13:08:58.701Z",
          "riderDetails": [
            {
              "_id": "65c2400c32f497dc57fdf007",
              "fullName": "Amod",
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
              "updatedAt": "2024-04-25T06:07:47.424Z",
              "idPic": {
                "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
                "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
              },
              "profilePic": {
                "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
                "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
              },
              "status": "active",
              "city": "Jaipur",
              "pinkMode": false,
              "notificationPreferences": {
                "trip": false,
                "alerts": false,
                "payments": false,
                "transactions": false,
                "offers": false
              },
              "rating": 0,
              "totalRides": 0
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
  List<DriverConfirmRequestModelData>? data;

  DriverConfirmRequestModel({
    this.status,
    this.message,
    this.data,
  });
  DriverConfirmRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <DriverConfirmRequestModelData>[];
      v.forEach((v) {
        arr0.add(DriverConfirmRequestModelData.fromJson(v));
      });
      this.data = arr0;
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
