
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

class RecurringRideDetailsModelDataRecurringRidesRidersProfilePic {
/*
{
  "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
} 
*/

  String? key;
  String? url;

  RecurringRideDetailsModelDataRecurringRidesRidersProfilePic({
    this.key,
    this.url,
  });
  RecurringRideDetailsModelDataRecurringRidesRidersProfilePic.fromJson(
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

class RecurringRideDetailsModelDataRecurringRidesRidersIdPic {
/*
{
  "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
} 
*/

  String? key;
  String? url;

  RecurringRideDetailsModelDataRecurringRidesRidersIdPic({
    this.key,
    this.url,
  });
  RecurringRideDetailsModelDataRecurringRidesRidersIdPic.fromJson(
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

class RecurringRideDetailsModelDataRecurringRidesRiders {
/*
{
  "_id": "65c2400c32f497dc57fdf007",
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
  "updatedAt": "2024-03-21T10:10:14.482Z",
  "idPic": {
    "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
  },
  "profilePic": {
    "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
  },
  "status": "active",
  "city": "Jaipur"
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
  RecurringRideDetailsModelDataRecurringRidesRidersIdPic? idPic;
  RecurringRideDetailsModelDataRecurringRidesRidersProfilePic? profilePic;
  String? status;
  String? city;

  RecurringRideDetailsModelDataRecurringRidesRiders({
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
  });
  RecurringRideDetailsModelDataRecurringRidesRiders.fromJson(
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
        ? RecurringRideDetailsModelDataRecurringRidesRidersIdPic.fromJson(
            json['idPic'])
        : null;
    profilePic = (json['profilePic'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesRidersProfilePic.fromJson(
            json['profilePic'])
        : null;
    status = json['status']?.toString();
    city = json['city']?.toString();
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
    return data;
  }
}

class RecurringRideDetailsModelDataRecurringRidesPreferencesOther {
/*
{
  "AppreciatesConversation": true,
  "EnjoysMusic": true,
  "SmokeFree": true,
  "PetFriendly": true,
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

  RecurringRideDetailsModelDataRecurringRidesPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  RecurringRideDetailsModelDataRecurringRidesPreferencesOther.fromJson(
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

class RecurringRideDetailsModelDataRecurringRidesPreferences {
/*
{
  "luggageType": "L",
  "other": {
    "AppreciatesConversation": true,
    "EnjoysMusic": true,
    "SmokeFree": true,
    "PetFriendly": true,
    "WinterTires": false,
    "CoolingOrHeating": false,
    "BabySeat": false,
    "HeatedSeats": false
  }
} 
*/

  String? luggageType;
  RecurringRideDetailsModelDataRecurringRidesPreferencesOther? other;

  RecurringRideDetailsModelDataRecurringRidesPreferences({
    this.luggageType,
    this.other,
  });
  RecurringRideDetailsModelDataRecurringRidesPreferences.fromJson(
      Map<String, dynamic> json) {
    luggageType = json['luggageType']?.toString();
    other = (json['other'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesPreferencesOther.fromJson(
            json['other'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['luggageType'] = luggageType;
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class RecurringRideDetailsModelDataRecurringRidesReturnTrip {
/*
{
  "isReturnTrip": false,
  "returnDate": null,
  "returnTime": null
} 
*/

  bool? isReturnTrip;
  String? returnDate;
  String? returnTime;

  RecurringRideDetailsModelDataRecurringRidesReturnTrip({
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  RecurringRideDetailsModelDataRecurringRidesReturnTrip.fromJson(
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

class RecurringRideDetailsModelDataRecurringRidesRecurringTrip {
/*
{
  "recurringTripDays": [
    1
  ],
  "recurringTripIds": [
    "121212"
  ]
} 
*/

  List<int?>? recurringTripDays;
  List<String?>? recurringTripIds;

  RecurringRideDetailsModelDataRecurringRidesRecurringTrip({
    this.recurringTripDays,
    this.recurringTripIds,
  });
  RecurringRideDetailsModelDataRecurringRidesRecurringTrip.fromJson(
      Map<String, dynamic> json) {
    if (json['recurringTripDays'] != null) {
      final v = json['recurringTripDays'];
      final arr0 = <int>[];
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      recurringTripDays = arr0;
    }
    if (json['recurringTripIds'] != null) {
      final v = json['recurringTripIds'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      recurringTripIds = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (recurringTripDays != null) {
      final v = recurringTripDays;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['recurringTripDays'] = arr0;
    }
    if (recurringTripIds != null) {
      final v = recurringTripIds;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['recurringTripIds'] = arr0;
    }
    return data;
  }
}

class RecurringRideDetailsModelDataRecurringRidesStops {
/*
{
  "name": "",
  "type": "Point",
  "coordinates": [
    0
  ],
  "originToStopFair": "",
  "stopToStopFair": "",
  "stopTodestinationFair": null,
  "_id": "6617c8b7379845cae55c7557"
} 
*/

  String? name;
  String? type;
  List<int?>? coordinates;
  String? originToStopFair;
  String? stopToStopFair;
  String? stopTodestinationFair;
  String? Id;

  RecurringRideDetailsModelDataRecurringRidesStops({
    this.name,
    this.type,
    this.coordinates,
    this.originToStopFair,
    this.stopToStopFair,
    this.stopTodestinationFair,
    this.Id,
  });
  RecurringRideDetailsModelDataRecurringRidesStops.fromJson(
      Map<String, dynamic> json) {
    name = json['name']?.toString();
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <int>[];
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      coordinates = arr0;
    }
    originToStopFair = json['originToStopFair']?.toString();
    stopToStopFair = json['stopToStopFair']?.toString();
    stopTodestinationFair = json['stopTodestinationFair']?.toString();
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
    data['originToStopFair'] = originToStopFair;
    data['stopToStopFair'] = stopToStopFair;
    data['stopTodestinationFair'] = stopTodestinationFair;
    data['_id'] = Id;
    return data;
  }
}

class RecurringRideDetailsModelDataRecurringRidesDestination {
/*
{
  "name": "Crown, Navi Mumbai",
  "type": "Point",
  "coordinates": [
    73.116778
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  RecurringRideDetailsModelDataRecurringRidesDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  RecurringRideDetailsModelDataRecurringRidesDestination.fromJson(
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

class RecurringRideDetailsModelDataRecurringRidesOrigin {
/*
{
  "name": "Central Business District, Navi Mumbai",
  "type": "Point",
  "coordinates": [
    73.0404355
  ],
  "originDestinationFair": "54.32"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? originDestinationFair;

  RecurringRideDetailsModelDataRecurringRidesOrigin({
    this.name,
    this.type,
    this.coordinates,
    this.originDestinationFair,
  });
  RecurringRideDetailsModelDataRecurringRidesOrigin.fromJson(
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

class RecurringRideDetailsModelDataRecurringRides {
/*
{
  "_id": "6617c8b7379845cae55c7556",
  "origin": {
    "name": "Central Business District, Navi Mumbai",
    "type": "Point",
    "coordinates": [
      73.0404355
    ],
    "originDestinationFair": "54.32"
  },
  "destination": {
    "name": "Crown, Navi Mumbai",
    "type": "Point",
    "coordinates": [
      73.116778
    ]
  },
  "stops": [
    {
      "name": "",
      "type": "Point",
      "coordinates": [
        0
      ],
      "originToStopFair": "",
      "stopToStopFair": "",
      "stopTodestinationFair": null,
      "_id": "6617c8b7379845cae55c7557"
    }
  ],
  "tripType": "oneTime",
  "recurringTrip": {
    "recurringTripDays": [
      1
    ],
    "recurringTripIds": [
      "121212"
    ]
  },
  "date": "2024-04-17T00:00:00.000Z",
  "returnTrip": {
    "isReturnTrip": false,
    "returnDate": null,
    "returnTime": null
  },
  "arrivalDate": null,
  "arrivalTime": null,
  "seatAvailable": 4,
  "preferences": {
    "luggageType": "L",
    "other": {
      "AppreciatesConversation": true,
      "EnjoysMusic": true,
      "SmokeFree": true,
      "PetFriendly": true,
      "WinterTires": false,
      "CoolingOrHeating": false,
      "BabySeat": false,
      "HeatedSeats": false
    }
  },
  "isStarted": false,
  "isCompleted": false,
  "isCancelled": false,
  "riders": [
    {
      "_id": "65c2400c32f497dc57fdf007",
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
      "updatedAt": "2024-03-21T10:10:14.482Z",
      "idPic": {
        "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
      },
      "profilePic": {
        "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
      },
      "status": "active",
      "city": "Jaipur"
    }
  ],
  "description": "",
  "createdAt": "2024-04-11T11:25:43.419Z",
  "updatedAt": "2024-04-11T11:25:43.419Z"
} 
*/

  String? Id;
  RecurringRideDetailsModelDataRecurringRidesOrigin? origin;
  RecurringRideDetailsModelDataRecurringRidesDestination? destination;
  List<RecurringRideDetailsModelDataRecurringRidesStops?>? stops;
  String? tripType;
  RecurringRideDetailsModelDataRecurringRidesRecurringTrip? recurringTrip;
  String? date;
  RecurringRideDetailsModelDataRecurringRidesReturnTrip? returnTrip;
  String? arrivalDate;
  String? arrivalTime;
  int? seatAvailable;
  RecurringRideDetailsModelDataRecurringRidesPreferences? preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  List<RecurringRideDetailsModelDataRecurringRidesRiders?>? riders;
  String? description;
  String? createdAt;
  String? updatedAt;

  RecurringRideDetailsModelDataRecurringRides({
    this.Id,
    this.origin,
    this.destination,
    this.stops,
    this.tripType,
    this.recurringTrip,
    this.date,
    this.returnTrip,
    this.arrivalDate,
    this.arrivalTime,
    this.seatAvailable,
    this.preferences,
    this.isStarted,
    this.isCompleted,
    this.isCancelled,
    this.riders,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
  RecurringRideDetailsModelDataRecurringRides.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    origin = (json['origin'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesDestination.fromJson(
            json['destination'])
        : null;
    if (json['stops'] != null) {
      final v = json['stops'];
      final arr0 = <RecurringRideDetailsModelDataRecurringRidesStops>[];
      v.forEach((v) {
        arr0.add(RecurringRideDetailsModelDataRecurringRidesStops.fromJson(v));
      });
      stops = arr0;
    }
    tripType = json['tripType']?.toString();
    recurringTrip = (json['recurringTrip'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesRecurringTrip.fromJson(
            json['recurringTrip'])
        : null;
    date = json['date']?.toString();
    returnTrip = (json['returnTrip'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesReturnTrip.fromJson(
            json['returnTrip'])
        : null;
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    seatAvailable = json['seatAvailable']?.toInt();
    preferences = (json['preferences'] != null)
        ? RecurringRideDetailsModelDataRecurringRidesPreferences.fromJson(
            json['preferences'])
        : null;
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    if (json['riders'] != null) {
      final v = json['riders'];
      final arr0 = <RecurringRideDetailsModelDataRecurringRidesRiders>[];
      v.forEach((v) {
        arr0.add(RecurringRideDetailsModelDataRecurringRidesRiders.fromJson(v));
      });
      riders = arr0;
    }
    description = json['description']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
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
    if (recurringTrip != null) {
      data['recurringTrip'] = recurringTrip!.toJson();
    }
    data['date'] = date;
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
    if (riders != null) {
      final v = riders;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['riders'] = arr0;
    }
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetailsVehiclePic {
/*
{
  "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
  "_id": "6603d738ba3fdc24d7cbce50"
} 
*/

  String? key;
  String? url;
  String? Id;

  RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetailsVehiclePic({
    this.key,
    this.url,
    this.Id,
  });
  RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetailsVehiclePic.fromJson(
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

class RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetails {
/*
{
  "_id": "65c23bef32f497dc57fdf002",
  "driverId": "65c228fd32f497dc57fdeff8",
  "vehiclePic": {
    "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
    "_id": "6603d738ba3fdc24d7cbce50"
  },
  "model": "ModelY",
  "type": "Convertible",
  "color": "Blue",
  "year": 2024,
  "licencePlate": "LA2024",
  "createdAt": "2024-02-06T14:02:23.061Z",
  "updatedAt": "2024-03-27T08:22:16.462Z"
} 
*/

  String? Id;
  String? driverId;
  RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetailsVehiclePic?
      vehiclePic;
  String? model;
  String? type;
  String? color;
  int? year;
  String? licencePlate;
  String? createdAt;
  String? updatedAt;

  RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetails({
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
  RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    vehiclePic = (json['vehiclePic'] != null)
        ? RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetailsVehiclePic
            .fromJson(json['vehiclePic'])
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

class RecurringRideDetailsModelDataDriverRideDetailsPreferencesOther {
/*
{
  "AppreciatesConversation": true,
  "EnjoysMusic": true,
  "SmokeFree": true,
  "PetFriendly": true,
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

  RecurringRideDetailsModelDataDriverRideDetailsPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  RecurringRideDetailsModelDataDriverRideDetailsPreferencesOther.fromJson(
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

class RecurringRideDetailsModelDataDriverRideDetailsPreferences {
/*
{
  "luggageType": "L",
  "other": {
    "AppreciatesConversation": true,
    "EnjoysMusic": true,
    "SmokeFree": true,
    "PetFriendly": true,
    "WinterTires": false,
    "CoolingOrHeating": false,
    "BabySeat": false,
    "HeatedSeats": false
  }
} 
*/

  String? luggageType;
  RecurringRideDetailsModelDataDriverRideDetailsPreferencesOther? other;

  RecurringRideDetailsModelDataDriverRideDetailsPreferences({
    this.luggageType,
    this.other,
  });
  RecurringRideDetailsModelDataDriverRideDetailsPreferences.fromJson(
      Map<String, dynamic> json) {
    luggageType = json['luggageType']?.toString();
    other = (json['other'] != null)
        ? RecurringRideDetailsModelDataDriverRideDetailsPreferencesOther
            .fromJson(json['other'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['luggageType'] = luggageType;
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class RecurringRideDetailsModelDataDriverRideDetailsStops {
/*
{
  "name": "",
  "type": "Point",
  "coordinates": [
    0
  ],
  "originToStopFair": "",
  "stopToStopFair": "",
  "stopTodestinationFair": null,
  "_id": "6617c8b7379845cae55c7553"
} 
*/

  String? name;
  String? type;
  List<int?>? coordinates;
  String? originToStopFair;
  String? stopToStopFair;
  String? stopTodestinationFair;
  String? Id;

  RecurringRideDetailsModelDataDriverRideDetailsStops({
    this.name,
    this.type,
    this.coordinates,
    this.originToStopFair,
    this.stopToStopFair,
    this.stopTodestinationFair,
    this.Id,
  });
  RecurringRideDetailsModelDataDriverRideDetailsStops.fromJson(
      Map<String, dynamic> json) {
    name = json['name']?.toString();
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      final v = json['coordinates'];
      final arr0 = <int>[];
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      coordinates = arr0;
    }
    originToStopFair = json['originToStopFair']?.toString();
    stopToStopFair = json['stopToStopFair']?.toString();
    stopTodestinationFair = json['stopTodestinationFair']?.toString();
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
    data['originToStopFair'] = originToStopFair;
    data['stopToStopFair'] = stopToStopFair;
    data['stopTodestinationFair'] = stopTodestinationFair;
    data['_id'] = Id;
    return data;
  }
}

class RecurringRideDetailsModelDataDriverRideDetailsDestination {
/*
{
  "name": "Crown, Navi Mumbai",
  "type": "Point",
  "coordinates": [
    73.116778
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  RecurringRideDetailsModelDataDriverRideDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  RecurringRideDetailsModelDataDriverRideDetailsDestination.fromJson(
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

class RecurringRideDetailsModelDataDriverRideDetailsOrigin {
/*
{
  "name": "Central Business District, Navi Mumbai",
  "type": "Point",
  "coordinates": [
    73.0404355
  ],
  "originDestinationFair": "54.32"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? originDestinationFair;

  RecurringRideDetailsModelDataDriverRideDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
    this.originDestinationFair,
  });
  RecurringRideDetailsModelDataDriverRideDetailsOrigin.fromJson(
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

class RecurringRideDetailsModelDataDriverRideDetails {
/*
{
  "_id": "6617c8b7379845cae55c7552",
  "origin": {
    "name": "Central Business District, Navi Mumbai",
    "type": "Point",
    "coordinates": [
      73.0404355
    ],
    "originDestinationFair": "54.32"
  },
  "destination": {
    "name": "Crown, Navi Mumbai",
    "type": "Point",
    "coordinates": [
      73.116778
    ]
  },
  "stops": [
    {
      "name": "",
      "type": "Point",
      "coordinates": [
        0
      ],
      "originToStopFair": "",
      "stopToStopFair": "",
      "stopTodestinationFair": null,
      "_id": "6617c8b7379845cae55c7553"
    }
  ],
  "date": null,
  "time": "",
  "preferences": {
    "luggageType": "L",
    "other": {
      "AppreciatesConversation": true,
      "EnjoysMusic": true,
      "SmokeFree": true,
      "PetFriendly": true,
      "WinterTires": false,
      "CoolingOrHeating": false,
      "BabySeat": false,
      "HeatedSeats": false
    }
  },
  "description": "ride 2 from cbd to crown",
  "driverVehiclesDetails": [
    {
      "_id": "65c23bef32f497dc57fdf002",
      "driverId": "65c228fd32f497dc57fdeff8",
      "vehiclePic": {
        "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
        "_id": "6603d738ba3fdc24d7cbce50"
      },
      "model": "ModelY",
      "type": "Convertible",
      "color": "Blue",
      "year": 2024,
      "licencePlate": "LA2024",
      "createdAt": "2024-02-06T14:02:23.061Z",
      "updatedAt": "2024-03-27T08:22:16.462Z"
    }
  ]
} 
*/

  String? Id;
  RecurringRideDetailsModelDataDriverRideDetailsOrigin? origin;
  RecurringRideDetailsModelDataDriverRideDetailsDestination? destination;
  List<RecurringRideDetailsModelDataDriverRideDetailsStops?>? stops;
  String? date;
  String? time;
  RecurringRideDetailsModelDataDriverRideDetailsPreferences? preferences;
  String? description;
  List<RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetails?>?
      driverVehiclesDetails;

  RecurringRideDetailsModelDataDriverRideDetails({
    this.Id,
    this.origin,
    this.destination,
    this.stops,
    this.date,
    this.time,
    this.preferences,
    this.description,
    this.driverVehiclesDetails,
  });
  RecurringRideDetailsModelDataDriverRideDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    origin = (json['origin'] != null)
        ? RecurringRideDetailsModelDataDriverRideDetailsOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? RecurringRideDetailsModelDataDriverRideDetailsDestination.fromJson(
            json['destination'])
        : null;
    if (json['stops'] != null) {
      final v = json['stops'];
      final arr0 = <RecurringRideDetailsModelDataDriverRideDetailsStops>[];
      v.forEach((v) {
        arr0.add(
            RecurringRideDetailsModelDataDriverRideDetailsStops.fromJson(v));
      });
      stops = arr0;
    }
    date = json['date']?.toString();
    time = json['time']?.toString();
    preferences = (json['preferences'] != null)
        ? RecurringRideDetailsModelDataDriverRideDetailsPreferences.fromJson(
            json['preferences'])
        : null;
    description = json['description']?.toString();
    if (json['driverVehiclesDetails'] != null) {
      final v = json['driverVehiclesDetails'];
      final arr0 =
          <RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetails>[];
      v.forEach((v) {
        arr0.add(
            RecurringRideDetailsModelDataDriverRideDetailsDriverVehiclesDetails
                .fromJson(v));
      });
      driverVehiclesDetails = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
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
    data['date'] = date;
    data['time'] = time;
    if (preferences != null) {
      data['preferences'] = preferences!.toJson();
    }
    data['description'] = description;
    if (driverVehiclesDetails != null) {
      final v = driverVehiclesDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['driverVehiclesDetails'] = arr0;
    }
    return data;
  }
}

class RecurringRideDetailsModelData {
/*
{
  "driverRideDetails": [
    {
      "_id": "6617c8b7379845cae55c7552",
      "origin": {
        "name": "Central Business District, Navi Mumbai",
        "type": "Point",
        "coordinates": [
          73.0404355
        ],
        "originDestinationFair": "54.32"
      },
      "destination": {
        "name": "Crown, Navi Mumbai",
        "type": "Point",
        "coordinates": [
          73.116778
        ]
      },
      "stops": [
        {
          "name": "",
          "type": "Point",
          "coordinates": [
            0
          ],
          "originToStopFair": "",
          "stopToStopFair": "",
          "stopTodestinationFair": null,
          "_id": "6617c8b7379845cae55c7553"
        }
      ],
      "date": null,
      "time": "",
      "preferences": {
        "luggageType": "L",
        "other": {
          "AppreciatesConversation": true,
          "EnjoysMusic": true,
          "SmokeFree": true,
          "PetFriendly": true,
          "WinterTires": false,
          "CoolingOrHeating": false,
          "BabySeat": false,
          "HeatedSeats": false
        }
      },
      "description": "ride 2 from cbd to crown",
      "driverVehiclesDetails": [
        {
          "_id": "65c23bef32f497dc57fdf002",
          "driverId": "65c228fd32f497dc57fdeff8",
          "vehiclePic": {
            "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
            "_id": "6603d738ba3fdc24d7cbce50"
          },
          "model": "ModelY",
          "type": "Convertible",
          "color": "Blue",
          "year": 2024,
          "licencePlate": "LA2024",
          "createdAt": "2024-02-06T14:02:23.061Z",
          "updatedAt": "2024-03-27T08:22:16.462Z"
        }
      ]
    }
  ],
  "recurringRides": [
    {
      "_id": "6617c8b7379845cae55c7556",
      "origin": {
        "name": "Central Business District, Navi Mumbai",
        "type": "Point",
        "coordinates": [
          73.0404355
        ],
        "originDestinationFair": "54.32"
      },
      "destination": {
        "name": "Crown, Navi Mumbai",
        "type": "Point",
        "coordinates": [
          73.116778
        ]
      },
      "stops": [
        {
          "name": "",
          "type": "Point",
          "coordinates": [
            0
          ],
          "originToStopFair": "",
          "stopToStopFair": "",
          "stopTodestinationFair": null,
          "_id": "6617c8b7379845cae55c7557"
        }
      ],
      "tripType": "oneTime",
      "recurringTrip": {
        "recurringTripDays": [
          1
        ],
        "recurringTripIds": [
          "121212"
        ]
      },
      "date": "2024-04-17T00:00:00.000Z",
      "returnTrip": {
        "isReturnTrip": false,
        "returnDate": null,
        "returnTime": null
      },
      "arrivalDate": null,
      "arrivalTime": null,
      "seatAvailable": 4,
      "preferences": {
        "luggageType": "L",
        "other": {
          "AppreciatesConversation": true,
          "EnjoysMusic": true,
          "SmokeFree": true,
          "PetFriendly": true,
          "WinterTires": false,
          "CoolingOrHeating": false,
          "BabySeat": false,
          "HeatedSeats": false
        }
      },
      "isStarted": false,
      "isCompleted": false,
      "isCancelled": false,
      "riders": [
        {
          "_id": "65c2400c32f497dc57fdf007",
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
          "updatedAt": "2024-03-21T10:10:14.482Z",
          "idPic": {
            "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
          },
          "profilePic": {
            "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
          },
          "status": "active",
          "city": "Jaipur"
        }
      ],
      "description": "",
      "createdAt": "2024-04-11T11:25:43.419Z",
      "updatedAt": "2024-04-11T11:25:43.419Z"
    }
  ]
} 
*/

  List<RecurringRideDetailsModelDataDriverRideDetails?>? driverRideDetails;
  List<RecurringRideDetailsModelDataRecurringRides?>? recurringRides;

  RecurringRideDetailsModelData({
    this.driverRideDetails,
    this.recurringRides,
  });
  RecurringRideDetailsModelData.fromJson(Map<String, dynamic> json) {
    if (json['driverRideDetails'] != null) {
      final v = json['driverRideDetails'];
      final arr0 = <RecurringRideDetailsModelDataDriverRideDetails>[];
      v.forEach((v) {
        arr0.add(RecurringRideDetailsModelDataDriverRideDetails.fromJson(v));
      });
      driverRideDetails = arr0;
    }
    if (json['recurringRides'] != null) {
      final v = json['recurringRides'];
      final arr0 = <RecurringRideDetailsModelDataRecurringRides>[];
      v.forEach((v) {
        arr0.add(RecurringRideDetailsModelDataRecurringRides.fromJson(v));
      });
      recurringRides = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (driverRideDetails != null) {
      final v = driverRideDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['driverRideDetails'] = arr0;
    }
    if (recurringRides != null) {
      final v = recurringRides;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['recurringRides'] = arr0;
    }
    return data;
  }
}

class RecurringRideDetailsModel {
/*
{
  "status": true,
  "message": "success",
  "data": {
    "driverRideDetails": [
      {
        "_id": "6617c8b7379845cae55c7552",
        "origin": {
          "name": "Central Business District, Navi Mumbai",
          "type": "Point",
          "coordinates": [
            73.0404355
          ],
          "originDestinationFair": "54.32"
        },
        "destination": {
          "name": "Crown, Navi Mumbai",
          "type": "Point",
          "coordinates": [
            73.116778
          ]
        },
        "stops": [
          {
            "name": "",
            "type": "Point",
            "coordinates": [
              0
            ],
            "originToStopFair": "",
            "stopToStopFair": "",
            "stopTodestinationFair": null,
            "_id": "6617c8b7379845cae55c7553"
          }
        ],
        "date": null,
        "time": "",
        "preferences": {
          "luggageType": "L",
          "other": {
            "AppreciatesConversation": true,
            "EnjoysMusic": true,
            "SmokeFree": true,
            "PetFriendly": true,
            "WinterTires": false,
            "CoolingOrHeating": false,
            "BabySeat": false,
            "HeatedSeats": false
          }
        },
        "description": "ride 2 from cbd to crown",
        "driverVehiclesDetails": [
          {
            "_id": "65c23bef32f497dc57fdf002",
            "driverId": "65c228fd32f497dc57fdeff8",
            "vehiclePic": {
              "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
              "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
              "_id": "6603d738ba3fdc24d7cbce50"
            },
            "model": "ModelY",
            "type": "Convertible",
            "color": "Blue",
            "year": 2024,
            "licencePlate": "LA2024",
            "createdAt": "2024-02-06T14:02:23.061Z",
            "updatedAt": "2024-03-27T08:22:16.462Z"
          }
        ]
      }
    ],
    "recurringRides": [
      {
        "_id": "6617c8b7379845cae55c7556",
        "origin": {
          "name": "Central Business District, Navi Mumbai",
          "type": "Point",
          "coordinates": [
            73.0404355
          ],
          "originDestinationFair": "54.32"
        },
        "destination": {
          "name": "Crown, Navi Mumbai",
          "type": "Point",
          "coordinates": [
            73.116778
          ]
        },
        "stops": [
          {
            "name": "",
            "type": "Point",
            "coordinates": [
              0
            ],
            "originToStopFair": "",
            "stopToStopFair": "",
            "stopTodestinationFair": null,
            "_id": "6617c8b7379845cae55c7557"
          }
        ],
        "tripType": "oneTime",
        "recurringTrip": {
          "recurringTripDays": [
            1
          ],
          "recurringTripIds": [
            "121212"
          ]
        },
        "date": "2024-04-17T00:00:00.000Z",
        "returnTrip": {
          "isReturnTrip": false,
          "returnDate": null,
          "returnTime": null
        },
        "arrivalDate": null,
        "arrivalTime": null,
        "seatAvailable": 4,
        "preferences": {
          "luggageType": "L",
          "other": {
            "AppreciatesConversation": true,
            "EnjoysMusic": true,
            "SmokeFree": true,
            "PetFriendly": true,
            "WinterTires": false,
            "CoolingOrHeating": false,
            "BabySeat": false,
            "HeatedSeats": false
          }
        },
        "isStarted": false,
        "isCompleted": false,
        "isCancelled": false,
        "riders": [
          {
            "_id": "65c2400c32f497dc57fdf007",
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
            "updatedAt": "2024-03-21T10:10:14.482Z",
            "idPic": {
              "key": "idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile pic 1.jpg",
              "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/15a822bf-c6ef-42bd-86e4-afa99098c640-profile%20pic%201.jpg"
            },
            "profilePic": {
              "key": "usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile pic 1.jpg",
              "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/cf6fb022-721c-4cc0-a182-acdfc3074ae0-profile%20pic%201.jpg"
            },
            "status": "active",
            "city": "Jaipur"
          }
        ],
        "description": "",
        "createdAt": "2024-04-11T11:25:43.419Z",
        "updatedAt": "2024-04-11T11:25:43.419Z"
      }
    ]
  }
} 
*/

  bool? status;
  String? message;
  RecurringRideDetailsModelData? data;

  RecurringRideDetailsModel({
    this.status,
    this.message,
    this.data,
  });
  RecurringRideDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? RecurringRideDetailsModelData.fromJson(json['data'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
