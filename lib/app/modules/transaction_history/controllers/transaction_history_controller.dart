import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/transactions_model.dart';
import '../widget/history_filter.dart';

class TransactionHistoryController extends GetxController {
  final RxBool isLoad = true.obs;
  final RxList<TransactionsModelDataTransactions> transactions =
      <TransactionsModelDataTransactions>[].obs;

  RxBool isMonthSelected = true.obs;
  RxString selectedMonth = "July".obs;
  RxInt selectedYear = 2025.obs;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<int> years = List.generate(11, (index) => 2025 - index); // Last 10 years

  @override
  void onInit() {
    super.onInit();
    getTransactionHistory();
  }

  Future<void> getTransactionHistory() async {
    try {
      final res = await APIManager.transactions();
      final transactionsModel = TransactionsModel.fromJson(res.data);
      transactions.value = transactionsModel.data!.transactions!;
      isLoad.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void toggleFilter(bool isMonth) {
    isMonthSelected.value = isMonth;
  }

  void selectMonth(String month) {
    selectedMonth.value = month;
  }

  void selectYear(int year) {
    selectedYear.value = year;
  }

  void openFilterBottomsheet(BuildContext context) {
    toggleBottomSheet();
    Get.bottomSheet(
      const HistoryFilter(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  static toggleBottomSheet() {
    if (Get.isBottomSheetOpen!) Get.until((route) => !Get.isBottomSheetOpen!);
  }
}
