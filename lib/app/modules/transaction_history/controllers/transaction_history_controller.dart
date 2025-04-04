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
  RxString selectedMonth = "".obs;
  RxInt selectedMonthIndex = 0.obs;

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

  RxnInt selectedYear = RxnInt(); // Nullable to allow deselection
  List<int> years = List.generate(
      11, (index) => DateTime.now().year - index); // Last 10 years

  @override
  void onInit() {
    super.onInit();
    getTransactionHistory();
  }

  Future<void> getTransactionHistory() async {
    /**GET /wallet-transactions?month=3&year=2024 */

    //set query parameters
    Map<String, dynamic> queryParameters = {};
    if (selectedMonthIndex.value > 0) {
      queryParameters["month"] = selectedMonthIndex.value;
    }

    if (selectedYear.value != null) {
      queryParameters["year"] = selectedYear.value;
    }

    debugPrint("Query Params: $queryParameters");

    //api call
    try {
      isLoad.value = true;
      final res =
          await APIManager.transactions(queryParameters: queryParameters);
      final transactionsModel = TransactionsModel.fromJson(res.data);
      transactions.value = transactionsModel.data!.transactions!;

      // Remove the last transaction if the list is not empty
      if (transactions.isNotEmpty) {
        transactions.removeLast();
      }

      isLoad.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void toggleFilter(bool isMonth) {
    isMonthSelected.value = isMonth;
  }

  void selectMonth(String month) {
    if (selectedMonth.value == month) {
      selectedMonth.value = "";
      selectedMonthIndex.value = 0; // Set index to 0 (none selected)
    } else {
      selectedMonth.value = month;
      selectedMonthIndex.value = months.indexOf(month) + 1;
    }
  }

  void selectYear(int year) {
    if (selectedYear.value == year) {
      selectedYear.value = null; // Deselect if clicked again
    } else {
      selectedYear.value = year;
    }
  }

  void openFilterBottomsheet(BuildContext context) {
    toggleBottomSheet();
    Get.bottomSheet(
      const HistoryFilter(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  static toggleBottomSheet() {
    if (Get.isBottomSheetOpen!) Get.until((route) => !Get.isBottomSheetOpen!);
  }
}
