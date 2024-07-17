import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/transactions_model.dart';

class TransactionHistoryController extends GetxController {
  final RxBool isLoad = true.obs;
  final RxList<TransactionsModelTransactions> transactions =
      <TransactionsModelTransactions>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTransactionHistory();
  }

  Future<void> getTransactionHistory() async {
    try {
      final res = await APIManager.transactions();
      final transactionsModel = TransactionsModel.fromJson(res.data);
      transactions.value = transactionsModel.transactions!;
      isLoad.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
