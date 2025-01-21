import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/generated/locales.g.dart';
import '../controllers/add_gift_controller.dart';

class AddGiftView extends GetView<AddGiftController> {
  const AddGiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_addGiftCard.tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: Column(
          children: [GreenPoolTextField(hintText: LocaleKeys.app_enterGiftCode.tr,),

          ],
        ),
      ),
    );
  }
}
