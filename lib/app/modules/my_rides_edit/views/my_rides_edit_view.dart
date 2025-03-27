import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/components/greenpool_chip.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/amenity_tile.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../components/price_tile.dart';
import '../../../components/richtext_heading.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../../utils/validation.dart';
import '../controllers/my_rides_edit_controller.dart';

class MyRidesEditView extends GetView<MyRidesEditController> {
  const MyRidesEditView({super.key});
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    final driverBkingDetail = controller.editData.value.driverBookingDetails;
    final bool isStop1Added =
        driverBkingDetail?.stops?[0]?.name?.isNotEmpty ?? false;
    final bool isStop2Added =
        driverBkingDetail?.stops?[1]?.name?.isNotEmpty ?? false;
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text("Edit Ride"),
        ),
        body: Obx(
          () => ListView(children: [
            //set date
            RichTextHeading(text: LocaleKeys.app_date.tr),
            GreenPoolTextField(
                controller: controller.formattedOneTimeDate,
                hintText: LocaleKeys.app_selectDate.tr,
                readOnly: true,
                suffix: SizedBox(
                  child: SvgPicture.asset(
                    ImageConstant.svgIconCalendar,
                    height: 24.kh,
                    width: 24.kw,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  ).paddingOnly(right: 16.kw),
                ),
                onTap: () {
                  controller.setDate(context);
                }).paddingOnly(top: 8.kh, bottom: 16.kh),
            //set time
            RichTextHeading(text: LocaleKeys.app_time.tr),
            GreenPoolTextField(
              hintText: LocaleKeys.app_selectTime.tr,
              controller: controller.selectedTime,
              onTap: () {
                controller.setTime(context);
              },
              readOnly: true,
            ).paddingOnly(top: 8.kh, bottom: 16.kh),
            //preferences
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.app_preferences.tr,
                  style: TextStyleUtil.k18Bold(),
                ),
                Expanded(
                  child: Container(
                    height: 1.kh,
                    color: ColorUtil.kNeutral2,
                  ).paddingOnly(left: 8.kw),
                ),
              ],
            ).paddingSymmetric(vertical: 24.kh),
            //set seats
            RichTextHeading(
              text: LocaleKeys.app_numberOfSeatsAvailable.tr,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ).paddingOnly(bottom: 4.kh),
            Text(
              LocaleKeys.app_qualityRides.tr,
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 16.kh),
            Row(children: [
              GestureDetector(
                  onTap: () => controller.decrement(),
                  child: SvgPicture.asset(
                    ImageConstant.svgIconMinus,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.kh),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorUtil.kBlack06, width: 2.kh),
                    borderRadius: BorderRadius.circular(40.kh),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageConstant.svgNavProfileFilled,
                        colorFilter: ColorFilter.mode(
                            isPinkModeOn
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ).paddingOnly(right: 4.kw),
                      Obx(
                        () => Text(
                          controller.seatCount.value.toString(),
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack03),
                        ),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 4.kw),
              ),
              GestureDetector(
                  onTap: () => controller.increment(),
                  child: SvgPicture.asset(
                    ImageConstant.svgIconPlus,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        BlendMode.srcIn),
                  )),
            ]).paddingOnly(bottom: 24.kh),
            //set luggage allowance
            /*RichTextHeading(
              text: LocaleKeys.app_luggageAllowance.tr,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    '${LocaleKeys.app_luggageWeight.tr} ${" ${controller.luggageWeight.value}"}',
                    style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
                  ).paddingOnly(top: 4.kh, bottom: 16.kh),
                ),
              ],
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'No',
                      selected:
                          controller.selectedCHIP.value == 'No' ? true : false,
                      onPressed: () {
                        controller.selectedCHIP.value = 'No';
                        controller.setLuggageWeight("No");
                      }),
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'S',
                      selected:
                          controller.selectedCHIP.value == 'S' ? true : false,
                      onPressed: () {
                        controller.selectedCHIP.value = 'S';
                        controller.setLuggageWeight("S");
                      }),
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'M',
                      selected:
                          controller.selectedCHIP.value == 'M' ? true : false,
                      onPressed: () {
                        controller.selectedCHIP.value = 'M';
                        controller.setLuggageWeight("M");
                      }),
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'L',
                      selected:
                          controller.selectedCHIP.value == 'L' ? true : false,
                      onPressed: () {
                        controller.selectedCHIP.value = 'L';
                        controller.setLuggageWeight("L");
                      }),
                ],
              ),
            ),*/
            //set other preferences
            Text(
              LocaleKeys.app_other.tr,
              style: TextStyleUtil.k16Bold(color: ColorUtil.kNeutral5),
            ).paddingOnly(top: 24.kh, bottom: 16.kh),
            AmenityTileWidget(
                text: LocaleKeys.app_appreciatesConversation.tr,
                image: ImageConstant.svgAmenities1,
                value: controller.appreciatesConversation.value,
                onChanged: (val) {
                  controller.appreciatesConversation.value = val;
                }),
            AmenityTileWidget(
              text: LocaleKeys.app_enjoysMusic.tr,
              image: ImageConstant.svgAmenities2,
              value: controller.enjoysMusic.value,
              onChanged: (val) {
                controller.enjoysMusic.value = val;
              },
            ),
            AmenityTileWidget(
              text: LocaleKeys.app_smokeFree.tr,
              image: ImageConstant.svgAmenities3,
              value: controller.smokeFree.value,
              onChanged: (val) {
                controller.smokeFree.value = val;
              },
            ),
            AmenityTileWidget(
              text: LocaleKeys.app_petFriendly.tr,
              image: ImageConstant.svgAmenities4,
              value: controller.petFriendly.value,
              onChanged: (val) {
                controller.petFriendly.value = val;
              },
            ),
            AmenityTileWidget(
              text: LocaleKeys.app_winterTires.tr,
              image: ImageConstant.svgAmenities5,
              value: controller.winterTires.value,
              onChanged: (val) {
                controller.winterTires.value = val;
              },
            ),
            AmenityTileWidget(
              text: LocaleKeys.app_coolingOrHeating.tr,
              image: ImageConstant.svgAmenities6,
              value: controller.coolingOrHeating.value,
              onChanged: (val) {
                controller.coolingOrHeating.value = val;
              },
            ),
            AmenityTileWidget(
              text: LocaleKeys.app_babySeat.tr,
              image: ImageConstant.svgAmenities7,
              value: controller.babySeat.value,
              onChanged: (val) {
                controller.babySeat.value = val;
              },
            ),
            AmenityTileWidget(
              text: LocaleKeys.app_heatedSeats.tr,
              image: ImageConstant.svgAmenities8,
              value: controller.heatedSeats.value,
              onChanged: (val) {
                controller.heatedSeats.value = val;
              },
            ),
            32.kheightBox,
            //pricing
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichTextHeading(
                  text: LocaleKeys.app_pricing.tr,
                  style: TextStyleUtil.k18Bold(),
                ),
                Expanded(
                  child: Container(
                    height: 1.kh,
                    color: ColorUtil.kNeutral2,
                  ).paddingOnly(left: 8.kw),
                ),
              ],
            ).paddingOnly(top: 8.kh, bottom: 4.kh),
            Text(
              LocaleKeys.app_specifyAReasonableCost.tr,
              style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
            ).paddingOnly(bottom: 24.kh),
            Text(
              LocaleKeys.app_pricePerSeat.tr,
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack01),
            ).paddingOnly(bottom: 4.kh),
            Text(
              LocaleKeys.app_thisPricingStrategy.tr,
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
            ),
            Text(
              '(Enter cost between ${controller.minFarePrice.value.toStringAsFixed(0)} and ${controller.maxFarePrice.value.toStringAsFixed(0)})',
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 8.kh),
            //price from origin to destination
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 40.w,
                    height: 10.h,
                    child: GreenPoolTextField(
                      hintText: '',
                      isSuffixNeeded: false,
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.deny(RegExp(r'[^\w\s]')),
                      ],
                      onchanged: (value) {
                        controller.onFareChanged(value);
                      },
                      validator: (value) => fareValidator(
                          value: value,
                          maxFarePrice: controller.maxFarePrice.value,
                          minFarePrice: controller.minFarePrice.value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.orToDestPrice,
                      prefix: Text(
                        '\$',
                        style: TextStyleUtil.k16Regular(
                          color: ColorUtil.kBlack03,
                        ),
                      ),
                    )).paddingOnly(right: 8.kw),
                Flexible(
                  child: SizedBox(
                    height: 10.h,
                    child: Text(
                      "${driverBkingDetail?.origin?.name.toString().split(",").first} to ${driverBkingDetail?.destination?.name.toString().split(",").first}",
                      style: TextStyleUtil.k14Semibold(),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: driverBkingDetail?.stops?[0]?.name == null
                  ? () {}
                  : () {
                      controller.viewPrice.value = !controller.viewPrice.value;
                    },
              child: controller.viewPrice.value
                  ? Text(
                      LocaleKeys.app_seeLess.tr,
                      style: TextStyleUtil.k14Semibold(
                          color: ColorUtil.kSecondary01,
                          textDecoration: TextDecoration.underline),
                    ).paddingOnly(bottom: 12.kh)
                  : Text(
                      LocaleKeys.app_viewPriceOfEachStop.tr,
                      style: TextStyleUtil.k14Semibold(
                          color: ColorUtil.kSecondary01,
                          textDecoration: TextDecoration.underline),
                    ).paddingOnly(bottom: 16.kh),
            ),

            Obx(() => Visibility(
                  visible: controller.viewPrice.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GreenPoolDivider(
                        color: ColorUtil.kNeutral8,
                      ).paddingOnly(bottom: 12.kh),
                      //From origin to stop 1
                      isStop1Added
                          ? PriceTile(
                              onchanged: (val) {},
                              validator: (value) => fareValidator(
                                  value: value,
                                  maxFarePrice: controller.maxFarePrice.value,
                                  minFarePrice: controller.minFarePrice.value),
                              txtController: controller.originToStop1Price,
                              trallingText:
                                  "${driverBkingDetail?.origin?.name.toString().split(",").first} to ${driverBkingDetail?.stops?[0]?.name.toString().split(",").first}",
                            )
                          : const SizedBox(),
                      //From origin to stop 2
                      isStop2Added
                          ? PriceTile(
                              onchanged: (val) {},
                              validator: (value) => fareValidator(
                                  value: value,
                                  maxFarePrice: controller.maxFarePrice.value,
                                  minFarePrice: controller.minFarePrice.value),
                              txtController: controller.originToStop2Price,
                              trallingText:
                                  "${driverBkingDetail?.origin?.name.toString().split(",").first} to ${driverBkingDetail?.stops?[1]?.name.toString().split(",").first}",
                            )
                          : const SizedBox(),
                      //From stop 1 to stop 2
                      (isStop1Added && isStop2Added)
                          ? PriceTile(
                              onchanged: (val) {},
                              validator: (value) => fareValidator(
                                  value: value,
                                  maxFarePrice: controller.maxFarePrice.value,
                                  minFarePrice: controller.minFarePrice.value),
                              txtController: controller.stop1ToStop2Price,
                              trallingText:
                                  "${driverBkingDetail?.stops?[0]?.name.toString().split(",").first} to ${driverBkingDetail?.stops?[1]?.name.toString().split(",").first}",
                            )
                          : const SizedBox(),
                      //From stop 1 to destination
                      isStop1Added
                          ? PriceTile(
                              onchanged: (val) {},
                              validator: (value) => fareValidator(
                                  value: value,
                                  maxFarePrice: controller.maxFarePrice.value,
                                  minFarePrice: controller.minFarePrice.value),
                              txtController: controller.stop1ToDestinationPrice,
                              trallingText:
                                  "${driverBkingDetail?.stops?[0]?.name.toString().split(",").first} to ${driverBkingDetail?.destination?.name.toString().split(",").first}",
                            )
                          : const SizedBox(),
                      //From stop 2 to destination
                      isStop2Added
                          ? PriceTile(
                              onchanged: (val) {},
                              validator: (value) => fareValidator(
                                  value: value,
                                  maxFarePrice: controller.maxFarePrice.value,
                                  minFarePrice: controller.minFarePrice.value),
                              txtController: controller.stop2toDestinationPrice,
                              trallingText:
                                  "${driverBkingDetail?.stops?[1]?.name.toString().split(",").first} to ${driverBkingDetail?.destination?.name.toString().split(",").first}",
                            ).paddingOnly(bottom: 20.kh)
                          : const SizedBox(),
                    ],
                  ),
                )),

            //save changes
            GreenPoolButton(
                label: LocaleKeys.app_saveChanges.tr,
                onPressed: () {
                  controller.saveChanges();
                }),
            20.kheightBox,
          ]).paddingSymmetric(horizontal: 16.kw),
        ));
  }
}
