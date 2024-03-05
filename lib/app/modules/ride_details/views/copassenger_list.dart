import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../constants/image_constant.dart';

class CoPassengerList extends StatelessWidget {
  final Widget? image;
  final int? itemcount;
  final String? name;
  const CoPassengerList({super.key, this.image, this.itemcount, this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.kh,
      child: ListView.builder(
          itemCount: itemcount ?? 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(20.kh),
                      child: image ??
                          Image.asset(
                            ImageConstant.pngIconProfilePic,
                          ),
                    ),
                  ),
                ).paddingOnly(bottom: 4.kh),
                Text(
                  name ?? 'Savannah \nNguyen',
                  style: TextStyleUtil.k12Semibold(),
                  textAlign: TextAlign.center,
                ),
              ],
            ).paddingOnly(right: 32.kw);
          }),
    );
  }
}
//
// Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         //passenger 1
//         Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: ClipOval(
//                 child: SizedBox.fromSize(
//                   size: Size.fromRadius(20.kh),
//                   child: Image.asset(
//                     ImageConstant.pngIconProfilePic,
//                   ),
//                 ),
//               ),
//             ).paddingOnly(bottom: 4.kh),
//             Text(
//               'Savannah \nNguyen',
//               style: TextStyleUtil.k12Semibold(),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ).paddingOnly(right: 18.kw),
//         //passenger 2
//         Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: ClipOval(
//                 child: SizedBox.fromSize(
//                   size: Size.fromRadius(20.kh),
//                   child: Image.asset(
//                     ImageConstant.pngPassenger1,
//                   ),
//                 ),
//               ),
//             ).paddingOnly(bottom: 4.kh),
//             Text(
//               'Alex \nAlexander',
//               style: TextStyleUtil.k12Semibold(),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ).paddingOnly(right: 18.kw),
//         //passenger 3
//         Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: ClipOval(
//                 child: SizedBox.fromSize(
//                   size: Size.fromRadius(20.kh),
//                   child: Image.asset(
//                     ImageConstant.pngEmptyPassenger,
//                   ),
//                 ),
//               ),
//             ).paddingOnly(bottom: 4.kh),
//             Text(
//               'Empty \nSeat',
//               style: TextStyleUtil.k12Semibold(),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ).paddingOnly(right: 18.kw),
//         //passenger 4
//         Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//               child: ClipOval(
//                 child: SizedBox.fromSize(
//                   size: Size.fromRadius(20.kh),
//                   child: Image.asset(
//                     ImageConstant.pngEmptyPassenger,
//                   ),
//                 ),
//               ),
//             ).paddingOnly(bottom: 4.kh),
//             Text(
//               'Empty \nSeat',
//               style: TextStyleUtil.k12Semibold(),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ],
//     );
 
