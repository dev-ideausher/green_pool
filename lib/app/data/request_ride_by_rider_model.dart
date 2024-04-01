
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

class RequestRideByRiderModelDataDriverRideDetailsStops {
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

  RequestRideByRiderModelDataDriverRideDetailsStops({
    this.name,
    this.type,
    this.coordinates,
    this.Id,
  });
  RequestRideByRiderModelDataDriverRideDetailsStops.fromJson(
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

class RequestRideByRiderModelDataDriverRideDetailsPreferencesOther {
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

  RequestRideByRiderModelDataDriverRideDetailsPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  RequestRideByRiderModelDataDriverRideDetailsPreferencesOther.fromJson(
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

class RequestRideByRiderModelDataDriverRideDetailsPreferences {
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
  "seatAvailable": 2,
  "luggageType": "No"
} 
*/

  RequestRideByRiderModelDataDriverRideDetailsPreferencesOther? other;
  int? seatAvailable;
  String? luggageType;

  RequestRideByRiderModelDataDriverRideDetailsPreferences({
    this.other,
    this.seatAvailable,
    this.luggageType,
  });
  RequestRideByRiderModelDataDriverRideDetailsPreferences.fromJson(
      Map<String, dynamic> json) {
    other = (json['other'] != null)
        ? RequestRideByRiderModelDataDriverRideDetailsPreferencesOther.fromJson(
            json['other'])
        : null;
    seatAvailable = json['seatAvailable']?.toInt();
    luggageType = json['luggageType']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (other != null) {
      data['other'] = other!.toJson();
    }
    data['seatAvailable'] = seatAvailable;
    data['luggageType'] = luggageType;
    return data;
  }
}

class RequestRideByRiderModelDataDriverRideDetailsReturnTrip {
/*
{
  "isReturnTrip": false,
  "returnDate": "2024-02-29T00:00:00.000Z",
  "returnTime": ""
} 
*/

  bool? isReturnTrip;
  String? returnDate;
  String? returnTime;

  RequestRideByRiderModelDataDriverRideDetailsReturnTrip({
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  RequestRideByRiderModelDataDriverRideDetailsReturnTrip.fromJson(
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

class RequestRideByRiderModelDataDriverRideDetailsRecurringTrip {
/*
{
  "recurringTripIds": [
    "123456123456"
  ],
  "recurringTripDays": [
    1
  ]
} 
*/

  List<String?>? recurringTripIds;
  List<int?>? recurringTripDays;

  RequestRideByRiderModelDataDriverRideDetailsRecurringTrip({
    this.recurringTripIds,
    this.recurringTripDays,
  });
  RequestRideByRiderModelDataDriverRideDetailsRecurringTrip.fromJson(
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
    return data;
  }
}

class RequestRideByRiderModelDataDriverRideDetailsDestination {
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

  RequestRideByRiderModelDataDriverRideDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  RequestRideByRiderModelDataDriverRideDetailsDestination.fromJson(
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

class RequestRideByRiderModelDataDriverRideDetailsOrigin {
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

  RequestRideByRiderModelDataDriverRideDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
  });
  RequestRideByRiderModelDataDriverRideDetailsOrigin.fromJson(
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

class RequestRideByRiderModelDataDriverRideDetails {
/*
{
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
  "recurringTrip": {
    "recurringTripIds": [
      "123456123456"
    ],
    "recurringTripDays": [
      1
    ]
  },
  "returnTrip": {
    "isReturnTrip": false,
    "returnDate": "2024-02-29T00:00:00.000Z",
    "returnTime": ""
  },
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
    "seatAvailable": 2,
    "luggageType": "No"
  },
  "_id": "65ddb242e52406bcf4b8cf6d",
  "driverId": "65c228fd32f497dc57fdeff8",
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
  "arrivalDate": "2024-02-29T00:00:00.000Z",
  "arrivalTime": "",
  "isStarted": false,
  "isCompleted": false,
  "isCancelled": false,
  "fair": 29,
  "riders": [
    "65c2400c32f497dc57fdf007"
  ],
  "createdAt": "2024-02-27T09:58:26.560Z",
  "updatedAt": "2024-03-01T10:20:53.223Z"
} 
*/

  RequestRideByRiderModelDataDriverRideDetailsOrigin? origin;
  RequestRideByRiderModelDataDriverRideDetailsDestination? destination;
  RequestRideByRiderModelDataDriverRideDetailsRecurringTrip? recurringTrip;
  RequestRideByRiderModelDataDriverRideDetailsReturnTrip? returnTrip;
  RequestRideByRiderModelDataDriverRideDetailsPreferences? preferences;
  String? Id;
  String? driverId;
  List<RequestRideByRiderModelDataDriverRideDetailsStops?>? stops;
  String? tripType;
  String? date;
  String? time;
  String? arrivalDate;
  String? arrivalTime;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  int? fair;
  List<String?>? riders;
  String? createdAt;
  String? updatedAt;

  RequestRideByRiderModelDataDriverRideDetails({
    this.origin,
    this.destination,
    this.recurringTrip,
    this.returnTrip,
    this.preferences,
    this.Id,
    this.driverId,
    this.stops,
    this.tripType,
    this.date,
    this.time,
    this.arrivalDate,
    this.arrivalTime,
    this.isStarted,
    this.isCompleted,
    this.isCancelled,
    this.fair,
    this.riders,
    this.createdAt,
    this.updatedAt,
  });
  RequestRideByRiderModelDataDriverRideDetails.fromJson(
      Map<String, dynamic> json) {
    origin = (json['origin'] != null)
        ? RequestRideByRiderModelDataDriverRideDetailsOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? RequestRideByRiderModelDataDriverRideDetailsDestination.fromJson(
            json['destination'])
        : null;
    recurringTrip = (json['recurringTrip'] != null)
        ? RequestRideByRiderModelDataDriverRideDetailsRecurringTrip.fromJson(
            json['recurringTrip'])
        : null;
    returnTrip = (json['returnTrip'] != null)
        ? RequestRideByRiderModelDataDriverRideDetailsReturnTrip.fromJson(
            json['returnTrip'])
        : null;
    preferences = (json['preferences'] != null)
        ? RequestRideByRiderModelDataDriverRideDetailsPreferences.fromJson(
            json['preferences'])
        : null;
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    if (json['stops'] != null) {
      final v = json['stops'];
      final arr0 = <RequestRideByRiderModelDataDriverRideDetailsStops>[];
      v.forEach((v) {
        arr0.add(RequestRideByRiderModelDataDriverRideDetailsStops.fromJson(v));
      });
      stops = arr0;
    }
    tripType = json['tripType']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    fair = json['fair']?.toInt();
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
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (recurringTrip != null) {
      data['recurringTrip'] = recurringTrip!.toJson();
    }
    if (returnTrip != null) {
      data['returnTrip'] = returnTrip!.toJson();
    }
    if (preferences != null) {
      data['preferences'] = preferences!.toJson();
    }
    data['_id'] = Id;
    data['driverId'] = driverId;
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
    data['arrivalDate'] = arrivalDate;
    data['arrivalTime'] = arrivalTime;
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
    return data;
  }
}

class RequestRideByRiderModelDataBookRideDetailsDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  RequestRideByRiderModelDataBookRideDetailsDropOffStatus({
    this.isDropOff,
  });
  RequestRideByRiderModelDataBookRideDetailsDropOffStatus.fromJson(
      Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class RequestRideByRiderModelDataBookRideDetailsPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  RequestRideByRiderModelDataBookRideDetailsPickUpStatus({
    this.isPickUp,
  });
  RequestRideByRiderModelDataBookRideDetailsPickUpStatus.fromJson(
      Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class RequestRideByRiderModelDataBookRideDetails {
/*
{
  "driverRideId": "65ddb242e52406bcf4b8cf6d",
  "riderRideId": "65ddbc3f2fa9b062d5748df8",
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
  "driverId": "65c228fd32f497dc57fdeff8",
  "_id": "65e1aca4d7832bbf12ca0040",
  "createdAt": "2024-03-01T10:23:32.195Z",
  "updatedAt": "2024-03-01T10:23:32.195Z"
} 
*/

  String? driverRideId;
  String? riderRideId;
  bool? cancelByDriver;
  bool? cancelByRider;
  bool? confirmByRider;
  bool? confirmByDriver;
  RequestRideByRiderModelDataBookRideDetailsPickUpStatus? pickUpStatus;
  RequestRideByRiderModelDataBookRideDetailsDropOffStatus? dropOffStatus;
  bool? isCompleted;
  String? driverId;
  String? Id;
  String? createdAt;
  String? updatedAt;

  RequestRideByRiderModelDataBookRideDetails({
    this.driverRideId,
    this.riderRideId,
    this.cancelByDriver,
    this.cancelByRider,
    this.confirmByRider,
    this.confirmByDriver,
    this.pickUpStatus,
    this.dropOffStatus,
    this.isCompleted,
    this.driverId,
    this.Id,
    this.createdAt,
    this.updatedAt,
  });
  RequestRideByRiderModelDataBookRideDetails.fromJson(
      Map<String, dynamic> json) {
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    pickUpStatus = (json['pickUpStatus'] != null)
        ? RequestRideByRiderModelDataBookRideDetailsPickUpStatus.fromJson(
            json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? RequestRideByRiderModelDataBookRideDetailsDropOffStatus.fromJson(
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

class RequestRideByRiderModelData {
/*
{
  "bookRideDetails": {
    "driverRideId": "65ddb242e52406bcf4b8cf6d",
    "riderRideId": "65ddbc3f2fa9b062d5748df8",
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
    "driverId": "65c228fd32f497dc57fdeff8",
    "_id": "65e1aca4d7832bbf12ca0040",
    "createdAt": "2024-03-01T10:23:32.195Z",
    "updatedAt": "2024-03-01T10:23:32.195Z"
  },
  "driverRideDetails": {
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
    "recurringTrip": {
      "recurringTripIds": [
        "123456123456"
      ],
      "recurringTripDays": [
        1
      ]
    },
    "returnTrip": {
      "isReturnTrip": false,
      "returnDate": "2024-02-29T00:00:00.000Z",
      "returnTime": ""
    },
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
      "seatAvailable": 2,
      "luggageType": "No"
    },
    "_id": "65ddb242e52406bcf4b8cf6d",
    "driverId": "65c228fd32f497dc57fdeff8",
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
    "arrivalDate": "2024-02-29T00:00:00.000Z",
    "arrivalTime": "",
    "isStarted": false,
    "isCompleted": false,
    "isCancelled": false,
    "fair": 29,
    "riders": [
      "65c2400c32f497dc57fdf007"
    ],
    "createdAt": "2024-02-27T09:58:26.560Z",
    "updatedAt": "2024-03-01T10:20:53.223Z"
  }
} 
*/

  RequestRideByRiderModelDataBookRideDetails? bookRideDetails;
  RequestRideByRiderModelDataDriverRideDetails? driverRideDetails;

  RequestRideByRiderModelData({
    this.bookRideDetails,
    this.driverRideDetails,
  });
  RequestRideByRiderModelData.fromJson(Map<String, dynamic> json) {
    bookRideDetails = (json['bookRideDetails'] != null)
        ? RequestRideByRiderModelDataBookRideDetails.fromJson(
            json['bookRideDetails'])
        : null;
    driverRideDetails = (json['driverRideDetails'] != null)
        ? RequestRideByRiderModelDataDriverRideDetails.fromJson(
            json['driverRideDetails'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (bookRideDetails != null) {
      data['bookRideDetails'] = bookRideDetails!.toJson();
    }
    if (driverRideDetails != null) {
      data['driverRideDetails'] = driverRideDetails!.toJson();
    }
    return data;
  }
}

class RequestRideByRiderModel {
/*
{
  "status": true,
  "message": "success",
  "data": {
    "bookRideDetails": {
      "driverRideId": "65ddb242e52406bcf4b8cf6d",
      "riderRideId": "65ddbc3f2fa9b062d5748df8",
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
      "driverId": "65c228fd32f497dc57fdeff8",
      "_id": "65e1aca4d7832bbf12ca0040",
      "createdAt": "2024-03-01T10:23:32.195Z",
      "updatedAt": "2024-03-01T10:23:32.195Z"
    },
    "driverRideDetails": {
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
      "recurringTrip": {
        "recurringTripIds": [
          "123456123456"
        ],
        "recurringTripDays": [
          1
        ]
      },
      "returnTrip": {
        "isReturnTrip": false,
        "returnDate": "2024-02-29T00:00:00.000Z",
        "returnTime": ""
      },
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
        "seatAvailable": 2,
        "luggageType": "No"
      },
      "_id": "65ddb242e52406bcf4b8cf6d",
      "driverId": "65c228fd32f497dc57fdeff8",
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
      "arrivalDate": "2024-02-29T00:00:00.000Z",
      "arrivalTime": "",
      "isStarted": false,
      "isCompleted": false,
      "isCancelled": false,
      "fair": 29,
      "riders": [
        "65c2400c32f497dc57fdf007"
      ],
      "createdAt": "2024-02-27T09:58:26.560Z",
      "updatedAt": "2024-03-01T10:20:53.223Z"
    }
  }
} 
*/

  bool? status;
  String? message;
  RequestRideByRiderModelData? data;

  RequestRideByRiderModel({
    this.status,
    this.message,
    this.data,
  });
  RequestRideByRiderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? RequestRideByRiderModelData.fromJson(json['data'])
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
