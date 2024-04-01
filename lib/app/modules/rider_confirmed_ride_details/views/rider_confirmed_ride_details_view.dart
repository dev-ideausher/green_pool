//! this page comes after tapping on confirmed rider tile in my_rides_view
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rider_confirmed_ride_details_controller.dart';

class RiderConfirmedRideDetailsView
    extends GetView<RiderConfirmedRideDetailsController> {
  const RiderConfirmedRideDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiderConfirmedRideDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiderConfirmedRideDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
