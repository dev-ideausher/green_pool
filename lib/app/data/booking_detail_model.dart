// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names

class BookingDetailModelDataDriverDetailsVehicleDetailsVehiclePic {
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

  BookingDetailModelDataDriverDetailsVehicleDetailsVehiclePic({
    this.key,
    this.url,
    this.Id,
  });
  BookingDetailModelDataDriverDetailsVehicleDetailsVehiclePic.fromJson(
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

class BookingDetailModelDataDriverDetailsVehicleDetails {
/*
{
  "_id": "65c23bef32f497dc57fdf002",
  "driverId": "65c228fd32f497dc57fdeff8",
  "vehiclePic": {
    "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
    "_id": "6603d738ba3fdc24d7cbce50"
  },
  "model": "creta",
  "type": "Convertible",
  "color": "Black",
  "year": 2024,
  "licencePlate": "LA2024",
  "createdAt": "2024-02-06T14:02:23.061Z",
  "updatedAt": "2024-04-15T04:53:34.316Z"
} 
*/

  String? Id;
  String? driverId;
  BookingDetailModelDataDriverDetailsVehicleDetailsVehiclePic? vehiclePic;
  String? model;
  String? type;
  String? color;
  int? year;
  String? licencePlate;
  String? createdAt;
  String? updatedAt;

  BookingDetailModelDataDriverDetailsVehicleDetails({
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
  BookingDetailModelDataDriverDetailsVehicleDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    vehiclePic = (json['vehiclePic'] != null)
        ? BookingDetailModelDataDriverDetailsVehicleDetailsVehiclePic.fromJson(
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

class BookingDetailModelDataDriverDetailsNotificationPreferences {
/*
{
  "trip": true,
  "alerts": true,
  "payments": true,
  "transactions": true,
  "offers": true
} 
*/

  bool? trip;
  bool? alerts;
  bool? payments;
  bool? transactions;
  bool? offers;

  BookingDetailModelDataDriverDetailsNotificationPreferences({
    this.trip,
    this.alerts,
    this.payments,
    this.transactions,
    this.offers,
  });
  BookingDetailModelDataDriverDetailsNotificationPreferences.fromJson(
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

class BookingDetailModelDataDriverDetailsProfilePic {
/*
{
  "key": "usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
  "_id": "664af3b5cd651d9acab11363"
} 
*/

  String? key;
  String? url;
  String? Id;

  BookingDetailModelDataDriverDetailsProfilePic({
    this.key,
    this.url,
    this.Id,
  });
  BookingDetailModelDataDriverDetailsProfilePic.fromJson(
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

class BookingDetailModelDataDriverDetailsIdPic {
/*
{
  "key": "idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
  "_id": "664af3b5cd651d9acab11364"
} 
*/

  String? key;
  String? url;
  String? Id;

  BookingDetailModelDataDriverDetailsIdPic({
    this.key,
    this.url,
    this.Id,
  });
  BookingDetailModelDataDriverDetailsIdPic.fromJson(Map<String, dynamic> json) {
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

class BookingDetailModelDataDriverDetails {
/*
{
  "_id": "65c228fd32f497dc57fdeff8",
  "fullName": "Amar",
  "phone": "+11111122222",
  "email": "amar@ideausher.com",
  "dob": "2006-05-25",
  "gender": "Male",
  "isDriver": true,
  "referralCode": "C3072B8509",
  "profileStatus": true,
  "vehicleStatus": true,
  "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
  "firebaseSignInProvider": "phone",
  "createdAt": "2024-02-06T12:41:33.824Z",
  "updatedAt": "2024-05-21T13:31:38.232Z",
  "idPic": {
    "key": "idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
    "_id": "664af3b5cd651d9acab11364"
  },
  "profilePic": {
    "key": "usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
    "_id": "664af3b5cd651d9acab11363"
  },
  "status": "active",
  "city": "Brampton",
  "pinkMode": false,
  "notificationPreferences": {
    "trip": true,
    "alerts": true,
    "payments": true,
    "transactions": true,
    "offers": true
  },
  "rating": 2.2222222222222223,
  "totalRides": 0,
  "isRegister": true,
  "role": "user",
  "vehicleDetails": {
    "_id": "65c23bef32f497dc57fdf002",
    "driverId": "65c228fd32f497dc57fdeff8",
    "vehiclePic": {
      "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
      "_id": "6603d738ba3fdc24d7cbce50"
    },
    "model": "creta",
    "type": "Convertible",
    "color": "Black",
    "year": 2024,
    "licencePlate": "LA2024",
    "createdAt": "2024-02-06T14:02:23.061Z",
    "updatedAt": "2024-04-15T04:53:34.316Z"
  }
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
  BookingDetailModelDataDriverDetailsIdPic? idPic;
  BookingDetailModelDataDriverDetailsProfilePic? profilePic;
  String? status;
  String? city;
  bool? pinkMode;
  BookingDetailModelDataDriverDetailsNotificationPreferences?
      notificationPreferences;
  double? rating;
  int? totalRides;
  bool? isRegister;
  String? role;
  BookingDetailModelDataDriverDetailsVehicleDetails? vehicleDetails;

  BookingDetailModelDataDriverDetails({
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
    this.isRegister,
    this.role,
    this.vehicleDetails,
  });
  BookingDetailModelDataDriverDetails.fromJson(Map<String, dynamic> json) {
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
        ? BookingDetailModelDataDriverDetailsIdPic.fromJson(json['idPic'])
        : null;
    profilePic = (json['profilePic'] != null)
        ? BookingDetailModelDataDriverDetailsProfilePic.fromJson(
            json['profilePic'])
        : null;
    status = json['status']?.toString();
    city = json['city']?.toString();
    pinkMode = json['pinkMode'];
    notificationPreferences = (json['notificationPreferences'] != null)
        ? BookingDetailModelDataDriverDetailsNotificationPreferences.fromJson(
            json['notificationPreferences'])
        : null;
    rating = json['rating']?.toDouble();
    totalRides = json['totalRides']?.toInt();
    isRegister = json['isRegister'];
    role = json['role']?.toString();
    vehicleDetails = (json['vehicleDetails'] != null)
        ? BookingDetailModelDataDriverDetailsVehicleDetails.fromJson(
            json['vehicleDetails'])
        : null;
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
    data['isRegister'] = isRegister;
    data['role'] = role;
    if (vehicleDetails != null) {
      data['vehicleDetails'] = vehicleDetails!.toJson();
    }
    return data;
  }
}

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsNotificationPreferences {
/*
{
  "trip": true,
  "alerts": true,
  "payments": true,
  "transactions": true,
  "offers": true
} 
*/

  bool? trip;
  bool? alerts;
  bool? payments;
  bool? transactions;
  bool? offers;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsNotificationPreferences({
    this.trip,
    this.alerts,
    this.payments,
    this.transactions,
    this.offers,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsNotificationPreferences.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsIdPic {
/*
{
  "key": "idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
  "_id": "664b3d653732bc9ccad99165"
} 
*/

  String? key;
  String? url;
  String? Id;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsIdPic({
    this.key,
    this.url,
    this.Id,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsIdPic.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsProfilePic {
/*
{
  "key": "usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
  "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
  "_id": "664b3d653732bc9ccad99164"
} 
*/

  String? key;
  String? url;
  String? Id;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsProfilePic({
    this.key,
    this.url,
    this.Id,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsProfilePic.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetails {
/*
{
  "_id": "664b090f6a2411c4e1311a88",
  "isRegister": true,
  "role": "Admin",
  "pinkMode": false,
  "fullName": "Gagan",
  "phone": "+917777777777",
  "email": "gagan@yopmail.com",
  "city": "Hamilton",
  "profilePic": {
    "key": "usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
    "_id": "664b3d653732bc9ccad99164"
  },
  "idPic": {
    "key": "idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
    "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
    "_id": "664b3d653732bc9ccad99165"
  },
  "dob": "2006-05-25",
  "gender": "Female",
  "isDriver": true,
  "referralCode": "G0583X2372",
  "profileStatus": true,
  "vehicleStatus": true,
  "status": "active",
  "wallet": 0,
  "rating": 0,
  "totalRides": 0,
  "isRecurringTripEnabled": false,
  "notificationPreferences": {
    "trip": true,
    "alerts": true,
    "payments": true,
    "transactions": true,
    "offers": true
  },
  "firebaseUid": "QyMqFd92cKb8XmwBZCT8p52himf1",
  "firebaseSignInProvider": "phone",
  "createdAt": "2024-05-20T08:25:51.820Z",
  "updatedAt": "2024-05-21T13:30:14.381Z"
} 
*/

  String? Id;
  bool? isRegister;
  String? role;
  bool? pinkMode;
  String? fullName;
  String? phone;
  String? email;
  String? city;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsProfilePic?
      profilePic;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsIdPic?
      idPic;
  String? dob;
  String? gender;
  bool? isDriver;
  String? referralCode;
  bool? profileStatus;
  bool? vehicleStatus;
  String? status;
  int? wallet;
  int? rating;
  int? totalRides;
  bool? isRecurringTripEnabled;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsNotificationPreferences?
      notificationPreferences;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? createdAt;
  String? updatedAt;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetails({
    this.Id,
    this.isRegister,
    this.role,
    this.pinkMode,
    this.fullName,
    this.phone,
    this.email,
    this.city,
    this.profilePic,
    this.idPic,
    this.dob,
    this.gender,
    this.isDriver,
    this.referralCode,
    this.profileStatus,
    this.vehicleStatus,
    this.status,
    this.wallet,
    this.rating,
    this.totalRides,
    this.isRecurringTripEnabled,
    this.notificationPreferences,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.createdAt,
    this.updatedAt,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    isRegister = json['isRegister'];
    role = json['role']?.toString();
    pinkMode = json['pinkMode'];
    fullName = json['fullName']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    city = json['city']?.toString();
    profilePic = (json['profilePic'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsProfilePic
            .fromJson(json['profilePic'])
        : null;
    idPic = (json['idPic'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsIdPic
            .fromJson(json['idPic'])
        : null;
    dob = json['dob']?.toString();
    gender = json['gender']?.toString();
    isDriver = json['isDriver'];
    referralCode = json['referralCode']?.toString();
    profileStatus = json['profileStatus'];
    vehicleStatus = json['vehicleStatus'];
    status = json['status']?.toString();
    wallet = json['wallet']?.toInt();
    rating = json['rating']?.toInt();
    totalRides = json['totalRides']?.toInt();
    isRecurringTripEnabled = json['isRecurringTripEnabled'];
    notificationPreferences = (json['notificationPreferences'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetailsNotificationPreferences
            .fromJson(json['notificationPreferences'])
        : null;
    firebaseUid = json['firebaseUid']?.toString();
    firebaseSignInProvider = json['firebaseSignInProvider']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['isRegister'] = isRegister;
    data['role'] = role;
    data['pinkMode'] = pinkMode;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['city'] = city;
    if (profilePic != null) {
      data['profilePic'] = profilePic!.toJson();
    }
    if (idPic != null) {
      data['idPic'] = idPic!.toJson();
    }
    data['dob'] = dob;
    data['gender'] = gender;
    data['isDriver'] = isDriver;
    data['referralCode'] = referralCode;
    data['profileStatus'] = profileStatus;
    data['vehicleStatus'] = vehicleStatus;
    data['status'] = status;
    data['wallet'] = wallet;
    data['rating'] = rating;
    data['totalRides'] = totalRides;
    data['isRecurringTripEnabled'] = isRecurringTripEnabled;
    if (notificationPreferences != null) {
      data['notificationPreferences'] = notificationPreferences!.toJson();
    }
    data['firebaseUid'] = firebaseUid;
    data['firebaseSignInProvider'] = firebaseSignInProvider;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferencesOther {
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

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferencesOther.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferences {
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
  "luggageType": ""
} 
*/

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferencesOther?
      other;
  String? luggageType;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferences({
    this.other,
    this.luggageType,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferences.fromJson(
      Map<String, dynamic> json) {
    other = (json['other'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferencesOther
            .fromJson(json['other'])
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsReturnTrip {
/*
{
  "returnTripId": "null",
  "isReturnTrip": false,
  "returnDate": "null",
  "returnTime": "null"
} 
*/

  String? returnTripId;
  bool? isReturnTrip;
  String? returnDate;
  String? returnTime;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsReturnTrip({
    this.returnTripId,
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsReturnTrip.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRecurringTrip {
/*
{
  "recurringTripIds": [
    ""
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

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRecurringTrip({
    this.recurringTripIds,
    this.recurringTripDays,
    this.isRecurringTripEnabled,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRecurringTrip.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsDestination {
/*
{
  "name": ", Mackenzie County",
  "type": "Point",
  "coordinates": [
    -117.5
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsDestination.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsOrigin {
/*
{
  "name": ", Upper Hay River 212",
  "type": "Point",
  "coordinates": [
    -117.7102669
  ],
  "originDestinationFair": "1"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? originDestinationFair;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
    this.originDestinationFair,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsOrigin.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRiderBookingDetails {
/*
{
  "_id": "664c48dd83a6d985bb0e2c77",
  "riderId": "664b090f6a2411c4e1311a88",
  "origin": {
    "name": ", Upper Hay River 212",
    "type": "Point",
    "coordinates": [
      -117.7102669
    ],
    "originDestinationFair": "1"
  },
  "destination": {
    "name": ", Mackenzie County",
    "type": "Point",
    "coordinates": [
      -117.5
    ]
  },
  "price": 0,
  "tripType": "null",
  "recurringTrip": {
    "recurringTripIds": [
      ""
    ],
    "recurringTripDays": [
      1
    ],
    "isRecurringTripEnabled": false
  },
  "date": "2024-05-21T12:30:04.548Z",
  "time": "",
  "returnTrip": {
    "returnTripId": "null",
    "isReturnTrip": false,
    "returnDate": "null",
    "returnTime": "null"
  },
  "arrivalDate": "null",
  "arrivalTime": "null",
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
    "luggageType": ""
  },
  "isStarted": false,
  "isCompleted": false,
  "isCancelled": false,
  "riders": [
    "664b090f6a2411c4e1311a88"
  ],
  "description": "",
  "createdAt": "2024-05-21T07:10:21.207Z",
  "updatedAt": "2024-05-21T07:10:21.207Z",
  "riderDetails": {
    "_id": "664b090f6a2411c4e1311a88",
    "isRegister": true,
    "role": "Admin",
    "pinkMode": false,
    "fullName": "Gagan",
    "phone": "+917777777777",
    "email": "gagan@yopmail.com",
    "city": "Hamilton",
    "profilePic": {
      "key": "usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
      "_id": "664b3d653732bc9ccad99164"
    },
    "idPic": {
      "key": "idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
      "_id": "664b3d653732bc9ccad99165"
    },
    "dob": "2006-05-25",
    "gender": "Female",
    "isDriver": true,
    "referralCode": "G0583X2372",
    "profileStatus": true,
    "vehicleStatus": true,
    "status": "active",
    "wallet": 0,
    "rating": 0,
    "totalRides": 0,
    "isRecurringTripEnabled": false,
    "notificationPreferences": {
      "trip": true,
      "alerts": true,
      "payments": true,
      "transactions": true,
      "offers": true
    },
    "firebaseUid": "QyMqFd92cKb8XmwBZCT8p52himf1",
    "firebaseSignInProvider": "phone",
    "createdAt": "2024-05-20T08:25:51.820Z",
    "updatedAt": "2024-05-21T13:30:14.381Z"
  }
} 
*/

  String? Id;
  String? riderId;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsOrigin? origin;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsDestination?
      destination;
  int? price;
  String? tripType;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRecurringTrip?
      recurringTrip;
  String? date;
  String? time;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsReturnTrip?
      returnTrip;
  String? arrivalDate;
  String? arrivalTime;
  int? seatAvailable;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferences?
      preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  List<String?>? riders;
  String? description;
  String? createdAt;
  String? updatedAt;
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetails?
      riderDetails;

  BookingDetailModelDataDriverBookingDetailsRiderBookingDetails({
    this.Id,
    this.riderId,
    this.origin,
    this.destination,
    this.price,
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
    this.riders,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.riderDetails,
  });
  BookingDetailModelDataDriverBookingDetailsRiderBookingDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    riderId = json['riderId']?.toString();
    origin = (json['origin'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsOrigin
            .fromJson(json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsDestination
            .fromJson(json['destination'])
        : null;
    price = json['price']?.toInt();
    tripType = json['tripType']?.toString();
    recurringTrip = (json['recurringTrip'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRecurringTrip
            .fromJson(json['recurringTrip'])
        : null;
    date = json['date']?.toString();
    time = json['time']?.toString();
    returnTrip = (json['returnTrip'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsReturnTrip
            .fromJson(json['returnTrip'])
        : null;
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    seatAvailable = json['seatAvailable']?.toInt();
    preferences = (json['preferences'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsPreferences
            .fromJson(json['preferences'])
        : null;
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    if (json['riders'] != null) {
      final v = json['riders'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      riders = arr0;
    }
    description = json['description']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    riderDetails = (json['riderDetails'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRiderBookingDetailsRiderDetails
            .fromJson(json['riderDetails'])
        : null;
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
    data['price'] = price;
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
    if (riders != null) {
      final v = riders;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['riders'] = arr0;
    }
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (riderDetails != null) {
      data['riderDetails'] = riderDetails!.toJson();
    }
    return data;
  }
}

class BookingDetailModelDataDriverBookingDetailsPreferencesOther {
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

  BookingDetailModelDataDriverBookingDetailsPreferencesOther({
    this.AppreciatesConversation,
    this.EnjoysMusic,
    this.SmokeFree,
    this.PetFriendly,
    this.WinterTires,
    this.CoolingOrHeating,
    this.BabySeat,
    this.HeatedSeats,
  });
  BookingDetailModelDataDriverBookingDetailsPreferencesOther.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsPreferences {
/*
{
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

  String? luggageType;
  BookingDetailModelDataDriverBookingDetailsPreferencesOther? other;

  BookingDetailModelDataDriverBookingDetailsPreferences({
    this.luggageType,
    this.other,
  });
  BookingDetailModelDataDriverBookingDetailsPreferences.fromJson(
      Map<String, dynamic> json) {
    luggageType = json['luggageType']?.toString();
    other = (json['other'] != null)
        ? BookingDetailModelDataDriverBookingDetailsPreferencesOther.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsReturnTrip {
/*
{
  "isReturnTrip": false,
  "returnDate": "null",
  "returnTime": ""
} 
*/

  bool? isReturnTrip;
  String? returnDate;
  String? returnTime;

  BookingDetailModelDataDriverBookingDetailsReturnTrip({
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });
  BookingDetailModelDataDriverBookingDetailsReturnTrip.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsRecurringTrip {
/*
{
  "recurringTripDays": [
    1
  ],
  "recurringTripIds": [
    ""
  ],
  "isRecurringTripEnabled": false
} 
*/

  List<int?>? recurringTripDays;
  List<String?>? recurringTripIds;
  bool? isRecurringTripEnabled;

  BookingDetailModelDataDriverBookingDetailsRecurringTrip({
    this.recurringTripDays,
    this.recurringTripIds,
    this.isRecurringTripEnabled,
  });
  BookingDetailModelDataDriverBookingDetailsRecurringTrip.fromJson(
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
    isRecurringTripEnabled = json['isRecurringTripEnabled'];
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
    data['isRecurringTripEnabled'] = isRecurringTripEnabled;
    return data;
  }
}

class BookingDetailModelDataDriverBookingDetailsStops {
/*
{
  "name": "",
  "type": "Point",
  "coordinates": [
    -117.7102669
  ],
  "originToStopFair": "null",
  "stopToStopFair": "null",
  "stopTodestinationFair": "null",
  "_id": "664c42ac89279c2826db84a5"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? originToStopFair;
  String? stopToStopFair;
  String? stopTodestinationFair;
  String? Id;

  BookingDetailModelDataDriverBookingDetailsStops({
    this.name,
    this.type,
    this.coordinates,
    this.originToStopFair,
    this.stopToStopFair,
    this.stopTodestinationFair,
    this.Id,
  });
  BookingDetailModelDataDriverBookingDetailsStops.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsDestination {
/*
{
  "name": "Mackenzie County, ",
  "type": "Point",
  "coordinates": [
    -117.5
  ]
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;

  BookingDetailModelDataDriverBookingDetailsDestination({
    this.name,
    this.type,
    this.coordinates,
  });
  BookingDetailModelDataDriverBookingDetailsDestination.fromJson(
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

class BookingDetailModelDataDriverBookingDetailsOrigin {
/*
{
  "name": "Upper Hay River 212, ",
  "type": "Point",
  "coordinates": [
    -117.7102669
  ],
  "originDestinationFair": "15"
} 
*/

  String? name;
  String? type;
  List<double?>? coordinates;
  String? originDestinationFair;

  BookingDetailModelDataDriverBookingDetailsOrigin({
    this.name,
    this.type,
    this.coordinates,
    this.originDestinationFair,
  });
  BookingDetailModelDataDriverBookingDetailsOrigin.fromJson(
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

class BookingDetailModelDataDriverBookingDetails {
/*
{
  "_id": "664c42ac89279c2826db84a4",
  "driverId": "65c228fd32f497dc57fdeff8",
  "origin": {
    "name": "Upper Hay River 212, ",
    "type": "Point",
    "coordinates": [
      -117.7102669
    ],
    "originDestinationFair": "15"
  },
  "destination": {
    "name": "Mackenzie County, ",
    "type": "Point",
    "coordinates": [
      -117.5
    ]
  },
  "stops": [
    {
      "name": "",
      "type": "Point",
      "coordinates": [
        -117.7102669
      ],
      "originToStopFair": "null",
      "stopToStopFair": "null",
      "stopTodestinationFair": "null",
      "_id": "664c42ac89279c2826db84a5"
    }
  ],
  "tripType": "oneTime",
  "recurringTrip": {
    "recurringTripDays": [
      1
    ],
    "recurringTripIds": [
      ""
    ],
    "isRecurringTripEnabled": false
  },
  "date": "2024-05-21T12:11:28.114Z",
  "time": "",
  "returnTrip": {
    "isReturnTrip": false,
    "returnDate": "null",
    "returnTime": ""
  },
  "arrivalDate": "null",
  "arrivalTime": "null",
  "seatAvailable": 1,
  "preferences": {
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
  "riders": [
    "664b090f6a2411c4e1311a88"
  ],
  "description": "",
  "createdAt": "2024-05-21T06:43:56.261Z",
  "updatedAt": "2024-05-21T13:29:50.244Z",
  "riderBookingDetails": [
    {
      "_id": "664c48dd83a6d985bb0e2c77",
      "riderId": "664b090f6a2411c4e1311a88",
      "origin": {
        "name": ", Upper Hay River 212",
        "type": "Point",
        "coordinates": [
          -117.7102669
        ],
        "originDestinationFair": "1"
      },
      "destination": {
        "name": ", Mackenzie County",
        "type": "Point",
        "coordinates": [
          -117.5
        ]
      },
      "price": 0,
      "tripType": "null",
      "recurringTrip": {
        "recurringTripIds": [
          ""
        ],
        "recurringTripDays": [
          1
        ],
        "isRecurringTripEnabled": false
      },
      "date": "2024-05-21T12:30:04.548Z",
      "time": "",
      "returnTrip": {
        "returnTripId": "null",
        "isReturnTrip": false,
        "returnDate": "null",
        "returnTime": "null"
      },
      "arrivalDate": "null",
      "arrivalTime": "null",
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
        "luggageType": ""
      },
      "isStarted": false,
      "isCompleted": false,
      "isCancelled": false,
      "riders": [
        "664b090f6a2411c4e1311a88"
      ],
      "description": "",
      "createdAt": "2024-05-21T07:10:21.207Z",
      "updatedAt": "2024-05-21T07:10:21.207Z",
      "riderDetails": {
        "_id": "664b090f6a2411c4e1311a88",
        "isRegister": true,
        "role": "Admin",
        "pinkMode": false,
        "fullName": "Gagan",
        "phone": "+917777777777",
        "email": "gagan@yopmail.com",
        "city": "Hamilton",
        "profilePic": {
          "key": "usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
          "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
          "_id": "664b3d653732bc9ccad99164"
        },
        "idPic": {
          "key": "idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
          "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
          "_id": "664b3d653732bc9ccad99165"
        },
        "dob": "2006-05-25",
        "gender": "Female",
        "isDriver": true,
        "referralCode": "G0583X2372",
        "profileStatus": true,
        "vehicleStatus": true,
        "status": "active",
        "wallet": 0,
        "rating": 0,
        "totalRides": 0,
        "isRecurringTripEnabled": false,
        "notificationPreferences": {
          "trip": true,
          "alerts": true,
          "payments": true,
          "transactions": true,
          "offers": true
        },
        "firebaseUid": "QyMqFd92cKb8XmwBZCT8p52himf1",
        "firebaseSignInProvider": "phone",
        "createdAt": "2024-05-20T08:25:51.820Z",
        "updatedAt": "2024-05-21T13:30:14.381Z"
      }
    }
  ]
} 
*/

  String? Id;
  String? driverId;
  BookingDetailModelDataDriverBookingDetailsOrigin? origin;
  BookingDetailModelDataDriverBookingDetailsDestination? destination;
  List<BookingDetailModelDataDriverBookingDetailsStops?>? stops;
  String? tripType;
  BookingDetailModelDataDriverBookingDetailsRecurringTrip? recurringTrip;
  String? date;
  String? time;
  BookingDetailModelDataDriverBookingDetailsReturnTrip? returnTrip;
  String? arrivalDate;
  String? arrivalTime;
  int? seatAvailable;
  BookingDetailModelDataDriverBookingDetailsPreferences? preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  List<String?>? riders;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<BookingDetailModelDataDriverBookingDetailsRiderBookingDetails>?
      riderBookingDetails;

  BookingDetailModelDataDriverBookingDetails({
    this.Id,
    this.driverId,
    this.origin,
    this.destination,
    this.stops,
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
    this.riders,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.riderBookingDetails,
  });
  BookingDetailModelDataDriverBookingDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverId = json['driverId']?.toString();
    origin = (json['origin'] != null)
        ? BookingDetailModelDataDriverBookingDetailsOrigin.fromJson(
            json['origin'])
        : null;
    destination = (json['destination'] != null)
        ? BookingDetailModelDataDriverBookingDetailsDestination.fromJson(
            json['destination'])
        : null;
    if (json['stops'] != null) {
      final v = json['stops'];
      final arr0 = <BookingDetailModelDataDriverBookingDetailsStops>[];
      v.forEach((v) {
        arr0.add(BookingDetailModelDataDriverBookingDetailsStops.fromJson(v));
      });
      stops = arr0;
    }
    tripType = json['tripType']?.toString();
    recurringTrip = (json['recurringTrip'] != null)
        ? BookingDetailModelDataDriverBookingDetailsRecurringTrip.fromJson(
            json['recurringTrip'])
        : null;
    date = json['date']?.toString();
    time = json['time']?.toString();
    returnTrip = (json['returnTrip'] != null)
        ? BookingDetailModelDataDriverBookingDetailsReturnTrip.fromJson(
            json['returnTrip'])
        : null;
    arrivalDate = json['arrivalDate']?.toString();
    arrivalTime = json['arrivalTime']?.toString();
    seatAvailable = json['seatAvailable']?.toInt();
    preferences = (json['preferences'] != null)
        ? BookingDetailModelDataDriverBookingDetailsPreferences.fromJson(
            json['preferences'])
        : null;
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    if (json['riders'] != null) {
      final v = json['riders'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      riders = arr0;
    }
    description = json['description']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    if (json['riderBookingDetails'] != null) {
      final v = json['riderBookingDetails'];
      final arr0 =
          <BookingDetailModelDataDriverBookingDetailsRiderBookingDetails>[];
      v.forEach((v) {
        arr0.add(BookingDetailModelDataDriverBookingDetailsRiderBookingDetails
            .fromJson(v));
      });
      riderBookingDetails = arr0;
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
    if (riders != null) {
      final v = riders;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['riders'] = arr0;
    }
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (riderBookingDetails != null) {
      final v = riderBookingDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['riderBookingDetails'] = arr0;
    }
    return data;
  }
}

class BookingDetailModelDataDropOffStatus {
/*
{
  "isDropOff": false
} 
*/

  bool? isDropOff;

  BookingDetailModelDataDropOffStatus({
    this.isDropOff,
  });
  BookingDetailModelDataDropOffStatus.fromJson(Map<String, dynamic> json) {
    isDropOff = json['isDropOff'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDropOff'] = isDropOff;
    return data;
  }
}

class BookingDetailModelDataPickUpStatus {
/*
{
  "isPickUp": false
} 
*/

  bool? isPickUp;

  BookingDetailModelDataPickUpStatus({
    this.isPickUp,
  });
  BookingDetailModelDataPickUpStatus.fromJson(Map<String, dynamic> json) {
    isPickUp = json['isPickUp'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPickUp'] = isPickUp;
    return data;
  }
}

class BookingDetailModelData {
/*
{
  "_id": "664c8595503a28e19288764f",
  "driverRideId": "664c42ac89279c2826db84a4",
  "riderRideId": "664c48dd83a6d985bb0e2c77",
  "distance": "0.0",
  "cancelByDriver": false,
  "cancelByRider": false,
  "confirmByRider": true,
  "confirmByDriver": true,
  "pickUpStatus": {
    "isPickUp": false
  },
  "dropOffStatus": {
    "isDropOff": false
  },
  "isCompleted": false,
  "driverId": "65c228fd32f497dc57fdeff8",
  "price": 0,
  "createdAt": "2024-05-21T11:29:25.604Z",
  "updatedAt": "2024-05-21T13:29:50.089Z",
  "driverBookingDetails": {
    "_id": "664c42ac89279c2826db84a4",
    "driverId": "65c228fd32f497dc57fdeff8",
    "origin": {
      "name": "Upper Hay River 212, ",
      "type": "Point",
      "coordinates": [
        -117.7102669
      ],
      "originDestinationFair": "15"
    },
    "destination": {
      "name": "Mackenzie County, ",
      "type": "Point",
      "coordinates": [
        -117.5
      ]
    },
    "stops": [
      {
        "name": "",
        "type": "Point",
        "coordinates": [
          -117.7102669
        ],
        "originToStopFair": "null",
        "stopToStopFair": "null",
        "stopTodestinationFair": "null",
        "_id": "664c42ac89279c2826db84a5"
      }
    ],
    "tripType": "oneTime",
    "recurringTrip": {
      "recurringTripDays": [
        1
      ],
      "recurringTripIds": [
        ""
      ],
      "isRecurringTripEnabled": false
    },
    "date": "2024-05-21T12:11:28.114Z",
    "time": "",
    "returnTrip": {
      "isReturnTrip": false,
      "returnDate": "null",
      "returnTime": ""
    },
    "arrivalDate": "null",
    "arrivalTime": "null",
    "seatAvailable": 1,
    "preferences": {
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
    "riders": [
      "664b090f6a2411c4e1311a88"
    ],
    "description": "",
    "createdAt": "2024-05-21T06:43:56.261Z",
    "updatedAt": "2024-05-21T13:29:50.244Z",
    "riderBookingDetails": [
      {
        "_id": "664c48dd83a6d985bb0e2c77",
        "riderId": "664b090f6a2411c4e1311a88",
        "origin": {
          "name": ", Upper Hay River 212",
          "type": "Point",
          "coordinates": [
            -117.7102669
          ],
          "originDestinationFair": "1"
        },
        "destination": {
          "name": ", Mackenzie County",
          "type": "Point",
          "coordinates": [
            -117.5
          ]
        },
        "price": 0,
        "tripType": "null",
        "recurringTrip": {
          "recurringTripIds": [
            ""
          ],
          "recurringTripDays": [
            1
          ],
          "isRecurringTripEnabled": false
        },
        "date": "2024-05-21T12:30:04.548Z",
        "time": "",
        "returnTrip": {
          "returnTripId": "null",
          "isReturnTrip": false,
          "returnDate": "null",
          "returnTime": "null"
        },
        "arrivalDate": "null",
        "arrivalTime": "null",
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
          "luggageType": ""
        },
        "isStarted": false,
        "isCompleted": false,
        "isCancelled": false,
        "riders": [
          "664b090f6a2411c4e1311a88"
        ],
        "description": "",
        "createdAt": "2024-05-21T07:10:21.207Z",
        "updatedAt": "2024-05-21T07:10:21.207Z",
        "riderDetails": {
          "_id": "664b090f6a2411c4e1311a88",
          "isRegister": true,
          "role": "Admin",
          "pinkMode": false,
          "fullName": "Gagan",
          "phone": "+917777777777",
          "email": "gagan@yopmail.com",
          "city": "Hamilton",
          "profilePic": {
            "key": "usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
            "_id": "664b3d653732bc9ccad99164"
          },
          "idPic": {
            "key": "idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
            "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
            "_id": "664b3d653732bc9ccad99165"
          },
          "dob": "2006-05-25",
          "gender": "Female",
          "isDriver": true,
          "referralCode": "G0583X2372",
          "profileStatus": true,
          "vehicleStatus": true,
          "status": "active",
          "wallet": 0,
          "rating": 0,
          "totalRides": 0,
          "isRecurringTripEnabled": false,
          "notificationPreferences": {
            "trip": true,
            "alerts": true,
            "payments": true,
            "transactions": true,
            "offers": true
          },
          "firebaseUid": "QyMqFd92cKb8XmwBZCT8p52himf1",
          "firebaseSignInProvider": "phone",
          "createdAt": "2024-05-20T08:25:51.820Z",
          "updatedAt": "2024-05-21T13:30:14.381Z"
        }
      }
    ]
  },
  "driverDetails": {
    "_id": "65c228fd32f497dc57fdeff8",
    "fullName": "Amar",
    "phone": "+11111122222",
    "email": "amar@ideausher.com",
    "dob": "2006-05-25",
    "gender": "Male",
    "isDriver": true,
    "referralCode": "C3072B8509",
    "profileStatus": true,
    "vehicleStatus": true,
    "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
    "firebaseSignInProvider": "phone",
    "createdAt": "2024-02-06T12:41:33.824Z",
    "updatedAt": "2024-05-21T13:31:38.232Z",
    "idPic": {
      "key": "idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
      "_id": "664af3b5cd651d9acab11364"
    },
    "profilePic": {
      "key": "usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
      "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
      "_id": "664af3b5cd651d9acab11363"
    },
    "status": "active",
    "city": "Brampton",
    "pinkMode": false,
    "notificationPreferences": {
      "trip": true,
      "alerts": true,
      "payments": true,
      "transactions": true,
      "offers": true
    },
    "rating": 2.2222222222222223,
    "totalRides": 0,
    "isRegister": true,
    "role": "user",
    "vehicleDetails": {
      "_id": "65c23bef32f497dc57fdf002",
      "driverId": "65c228fd32f497dc57fdeff8",
      "vehiclePic": {
        "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
        "_id": "6603d738ba3fdc24d7cbce50"
      },
      "model": "creta",
      "type": "Convertible",
      "color": "Black",
      "year": 2024,
      "licencePlate": "LA2024",
      "createdAt": "2024-02-06T14:02:23.061Z",
      "updatedAt": "2024-04-15T04:53:34.316Z"
    }
  }
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
  BookingDetailModelDataPickUpStatus? pickUpStatus;
  BookingDetailModelDataDropOffStatus? dropOffStatus;
  bool? isCompleted;
  String? driverId;
  int? price;
  String? createdAt;
  String? updatedAt;
  BookingDetailModelDataDriverBookingDetails? driverBookingDetails;
  BookingDetailModelDataDriverDetails? driverDetails;

  BookingDetailModelData({
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
    this.price,
    this.createdAt,
    this.updatedAt,
    this.driverBookingDetails,
    this.driverDetails,
  });
  BookingDetailModelData.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    driverRideId = json['driverRideId']?.toString();
    riderRideId = json['riderRideId']?.toString();
    distance = json['distance']?.toString();
    cancelByDriver = json['cancelByDriver'];
    cancelByRider = json['cancelByRider'];
    confirmByRider = json['confirmByRider'];
    confirmByDriver = json['confirmByDriver'];
    pickUpStatus = (json['pickUpStatus'] != null)
        ? BookingDetailModelDataPickUpStatus.fromJson(json['pickUpStatus'])
        : null;
    dropOffStatus = (json['dropOffStatus'] != null)
        ? BookingDetailModelDataDropOffStatus.fromJson(json['dropOffStatus'])
        : null;
    isCompleted = json['isCompleted'];
    driverId = json['driverId']?.toString();
    price = json['price']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    driverBookingDetails = (json['driverBookingDetails'] != null)
        ? BookingDetailModelDataDriverBookingDetails.fromJson(
            json['driverBookingDetails'])
        : null;
    driverDetails = (json['driverDetails'] != null)
        ? BookingDetailModelDataDriverDetails.fromJson(json['driverDetails'])
        : null;
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
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (driverBookingDetails != null) {
      data['driverBookingDetails'] = driverBookingDetails!.toJson();
    }
    if (driverDetails != null) {
      data['driverDetails'] = driverDetails!.toJson();
    }
    return data;
  }
}

class BookingDetailModel {
/*
{
  "status": true,
  "message": "Boooking details found.",
  "data": {
    "_id": "664c8595503a28e19288764f",
    "driverRideId": "664c42ac89279c2826db84a4",
    "riderRideId": "664c48dd83a6d985bb0e2c77",
    "distance": "0.0",
    "cancelByDriver": false,
    "cancelByRider": false,
    "confirmByRider": true,
    "confirmByDriver": true,
    "pickUpStatus": {
      "isPickUp": false
    },
    "dropOffStatus": {
      "isDropOff": false
    },
    "isCompleted": false,
    "driverId": "65c228fd32f497dc57fdeff8",
    "price": 0,
    "createdAt": "2024-05-21T11:29:25.604Z",
    "updatedAt": "2024-05-21T13:29:50.089Z",
    "driverBookingDetails": {
      "_id": "664c42ac89279c2826db84a4",
      "driverId": "65c228fd32f497dc57fdeff8",
      "origin": {
        "name": "Upper Hay River 212, ",
        "type": "Point",
        "coordinates": [
          -117.7102669
        ],
        "originDestinationFair": "15"
      },
      "destination": {
        "name": "Mackenzie County, ",
        "type": "Point",
        "coordinates": [
          -117.5
        ]
      },
      "stops": [
        {
          "name": "",
          "type": "Point",
          "coordinates": [
            -117.7102669
          ],
          "originToStopFair": "null",
          "stopToStopFair": "null",
          "stopTodestinationFair": "null",
          "_id": "664c42ac89279c2826db84a5"
        }
      ],
      "tripType": "oneTime",
      "recurringTrip": {
        "recurringTripDays": [
          1
        ],
        "recurringTripIds": [
          ""
        ],
        "isRecurringTripEnabled": false
      },
      "date": "2024-05-21T12:11:28.114Z",
      "time": "",
      "returnTrip": {
        "isReturnTrip": false,
        "returnDate": "null",
        "returnTime": ""
      },
      "arrivalDate": "null",
      "arrivalTime": "null",
      "seatAvailable": 1,
      "preferences": {
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
      "riders": [
        "664b090f6a2411c4e1311a88"
      ],
      "description": "",
      "createdAt": "2024-05-21T06:43:56.261Z",
      "updatedAt": "2024-05-21T13:29:50.244Z",
      "riderBookingDetails": [
        {
          "_id": "664c48dd83a6d985bb0e2c77",
          "riderId": "664b090f6a2411c4e1311a88",
          "origin": {
            "name": ", Upper Hay River 212",
            "type": "Point",
            "coordinates": [
              -117.7102669
            ],
            "originDestinationFair": "1"
          },
          "destination": {
            "name": ", Mackenzie County",
            "type": "Point",
            "coordinates": [
              -117.5
            ]
          },
          "price": 0,
          "tripType": "null",
          "recurringTrip": {
            "recurringTripIds": [
              ""
            ],
            "recurringTripDays": [
              1
            ],
            "isRecurringTripEnabled": false
          },
          "date": "2024-05-21T12:30:04.548Z",
          "time": "",
          "returnTrip": {
            "returnTripId": "null",
            "isReturnTrip": false,
            "returnDate": "null",
            "returnTime": "null"
          },
          "arrivalDate": "null",
          "arrivalTime": "null",
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
            "luggageType": ""
          },
          "isStarted": false,
          "isCompleted": false,
          "isCancelled": false,
          "riders": [
            "664b090f6a2411c4e1311a88"
          ],
          "description": "",
          "createdAt": "2024-05-21T07:10:21.207Z",
          "updatedAt": "2024-05-21T07:10:21.207Z",
          "riderDetails": {
            "_id": "664b090f6a2411c4e1311a88",
            "isRegister": true,
            "role": "Admin",
            "pinkMode": false,
            "fullName": "Gagan",
            "phone": "+917777777777",
            "email": "gagan@yopmail.com",
            "city": "Hamilton",
            "profilePic": {
              "key": "usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
              "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/448341dc-ad54-46c9-8d55-116d059f7358-compressed_image_picker_76EB2E72-E7D5-4F31-A3F0-A0ECC32E8669-12556-0000078B4CDF0493.jpg",
              "_id": "664b3d653732bc9ccad99164"
            },
            "idPic": {
              "key": "idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
              "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/03fb4f4e-c5d2-4532-b301-e2a2753b9bdd-compressed_image_picker_6D053889-80A9-42C8-91F6-2D6F41BCDAF6-12556-0000078B873B8FDE.jpg",
              "_id": "664b3d653732bc9ccad99165"
            },
            "dob": "2006-05-25",
            "gender": "Female",
            "isDriver": true,
            "referralCode": "G0583X2372",
            "profileStatus": true,
            "vehicleStatus": true,
            "status": "active",
            "wallet": 0,
            "rating": 0,
            "totalRides": 0,
            "isRecurringTripEnabled": false,
            "notificationPreferences": {
              "trip": true,
              "alerts": true,
              "payments": true,
              "transactions": true,
              "offers": true
            },
            "firebaseUid": "QyMqFd92cKb8XmwBZCT8p52himf1",
            "firebaseSignInProvider": "phone",
            "createdAt": "2024-05-20T08:25:51.820Z",
            "updatedAt": "2024-05-21T13:30:14.381Z"
          }
        }
      ]
    },
    "driverDetails": {
      "_id": "65c228fd32f497dc57fdeff8",
      "fullName": "Amar",
      "phone": "+11111122222",
      "email": "amar@ideausher.com",
      "dob": "2006-05-25",
      "gender": "Male",
      "isDriver": true,
      "referralCode": "C3072B8509",
      "profileStatus": true,
      "vehicleStatus": true,
      "firebaseUid": "foYFX1qnSaPETdXnF1IFVT0xpkZ2",
      "firebaseSignInProvider": "phone",
      "createdAt": "2024-02-06T12:41:33.824Z",
      "updatedAt": "2024-05-21T13:31:38.232Z",
      "idPic": {
        "key": "idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/idPic/14a1f67c-67d3-417a-88ab-de80318076ce-compressed_image_picker_27017447-33A6-4FD5-9E68-9E333A4519E7-80244-000007220A59499C.jpg",
        "_id": "664af3b5cd651d9acab11364"
      },
      "profilePic": {
        "key": "usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
        "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/usersProfile/343e91cd-5339-4cb2-ab54-bb2c5c85ef7b-compressed_image_picker_E10F697C-B897-4693-A1EE-3FAC86253315-80244-000007221A4BE6ED.jpg",
        "_id": "664af3b5cd651d9acab11363"
      },
      "status": "active",
      "city": "Brampton",
      "pinkMode": false,
      "notificationPreferences": {
        "trip": true,
        "alerts": true,
        "payments": true,
        "transactions": true,
        "offers": true
      },
      "rating": 2.2222222222222223,
      "totalRides": 0,
      "isRegister": true,
      "role": "user",
      "vehicleDetails": {
        "_id": "65c23bef32f497dc57fdf002",
        "driverId": "65c228fd32f497dc57fdeff8",
        "vehiclePic": {
          "key": "vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
          "url": "https://green-pool-bucket.s3.ca-central-1.amazonaws.com/vehiclePic/b9fae2cc-33ed-4b5c-b602-c075fa476e3f-1000000038.jpg",
          "_id": "6603d738ba3fdc24d7cbce50"
        },
        "model": "creta",
        "type": "Convertible",
        "color": "Black",
        "year": 2024,
        "licencePlate": "LA2024",
        "createdAt": "2024-02-06T14:02:23.061Z",
        "updatedAt": "2024-04-15T04:53:34.316Z"
      }
    }
  }
} 
*/

  bool? status;
  String? message;
  BookingDetailModelData? data;

  BookingDetailModel({
    this.status,
    this.message,
    this.data,
  });
  BookingDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null)
        ? BookingDetailModelData.fromJson(json['data'])
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
