import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import '../controllers/add_gift_controller.dart';

class AddGiftView extends GetView<AddGiftController> {
  const AddGiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.addGiftCard),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: Column(
          children: [GreenPoolTextField(hintText: Strings.enterGiftCode,),

          ],
        ),
      ),
    );
  }
}
