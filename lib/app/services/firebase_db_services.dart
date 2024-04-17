import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/storage.dart';

enum RideStatus {
  pending,
  confirmed,
  cancelled,
}

class FirebaseDbServices {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('location');
  late StreamSubscription<DatabaseEvent> _subscription;

  Future<FirebaseDbServices> initState() async {
    if (Get.find<GetStorageService>().getLoggedIn) {
      _subscription = _database
          .child(Get.find<GetStorageService>().getFirebaseUid)
          .onValue
          .listen((event) {
        if (event.snapshot.value != null) {
          try {
            if (event.snapshot.value != null) {
              var data = event.snapshot.value;
              if (data != null && data is Map) {
                List<dynamic> dataList = data.values.toList();
              }
            }
          } catch (e) {
            print(e);
          }
        }
      });
    }

    return this;
  }

/*  _getStatusEnumFromString(BookingDbListenerModel rideDriverListenModel) async {
    Get.find<MainController>().updateRequest(rideDriverListenModel);
    */ /* if (rideDriverListenModel.status.toLowerCase() == 'pending') {

    } else if (rideDriverListenModel.status.toLowerCase() == 'confirmed') {
      Get.find<BookingsController>().refreshData();
    } else if (rideDriverListenModel.status.toLowerCase() == 'cancelled') {
      Get.find<BookingsController>().refreshData();
    }*/ /*
  }*/

  void cancel() {
    _subscription.cancel();
  }
}
