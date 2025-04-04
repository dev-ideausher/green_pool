import 'package:flutter/material.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/colors.dart';

class SocialsBottomsheet extends StatelessWidget {
  SocialsBottomsheet({super.key});

  final List<Map<String, String>> socials = [
    {
      "link":
          "https://www.facebook.com/people/Carpoollcom/61571681121420/?mibextid=wwXIfr&rdid=7aYaSDejJ7ONEJTh&share_url=https%3A%2F%2Fwww.facebook.com%2Fshare%2F1ACziZxKqb%2F%3Fmibextid%3DwwXIfr",
      "icon": ImageConstant.facebook
    },
    {
      "link":
          "https://www.instagram.com/carpoollcom/?igsh=MWRvZW9wbGx5ZHBqOQ%3D%3D#",
      "icon": ImageConstant.instagram
    },
    {"link": "https://x.com/carpoollcom?s=21", "icon": ImageConstant.twitter},
    {
      "link": "https://www.linkedin.com/company/greenpool-ca/",
      "icon": ImageConstant.linkedin
    },
    {
      "link": "https://www.tiktok.com/@carpooll.com?_t=ZM-8vBfiGUIqyF&_r=1",
      "icon": ImageConstant.tiktok
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.kh, left: 16.kw, right: 16.kw),
      height: 15.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: ColorUtil.kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.kh),
          topRight: Radius.circular(40.kh),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: socials.map((social) {
          return GestureDetector(
            onTap: () async {
              await launchUrl(Uri.parse(social["link"]!));
            },
            child: Container(
              height: 50.kh,
              width: 50.kw,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorUtil.kWhiteColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.kh),
                child: Image.asset(
                  social["icon"]!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
