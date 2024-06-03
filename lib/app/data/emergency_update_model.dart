
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

class EmergencyModelEmergencyContactsUpdate {
/*
{
  "fullName": "karan",
  "phone": "098765"
} 
*/

  String? fullName;
  String? phone;
  String? id;

  EmergencyModelEmergencyContactsUpdate({
    this.fullName,
    this.phone,
    this.id,
  });
  EmergencyModelEmergencyContactsUpdate.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName']?.toString();
    phone = json['phone']?.toString();
    id = json['_id']?.toString();

  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['_id'] = id;

    return data;
  }
}

class EmergencyUpdateModel {
/*
{
  "_id": "658d73de07d59f24b575f8e0",
  "emergencyContacts": [
    {
      "fullName": "karan",
      "phone": "098765"
    }
  ]
} 
*/

  List<EmergencyModelEmergencyContactsUpdate?>? emergencyContacts;

  EmergencyUpdateModel({
    this.emergencyContacts,
  });
  EmergencyUpdateModel.fromJson(Map<String, dynamic> json) {
    if (json['emergencyContacts'] != null) {
      final v = json['emergencyContacts'];
      final arr0 = <EmergencyModelEmergencyContactsUpdate>[];
      v.forEach((v) {
        arr0.add(EmergencyModelEmergencyContactsUpdate.fromJson(v));
      });
      emergencyContacts = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (emergencyContacts != null) {
      final v = emergencyContacts;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['emergencyContacts'] = arr0;
    }
    return data;
  }
}
