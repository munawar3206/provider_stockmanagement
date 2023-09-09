import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock/model/stock.dart';

class ProfitProvider extends ChangeNotifier {
  final List<Stock> profitsList = [];
  int totalProfit = 0;
  int totalLoss = 0;

  final Box<Stock> stockBox = Hive.box<Stock>('stockbox');

  ProfitProvider() {
    loadProfits();
    calculateTotals();
  }

  void loadProfits() {
    profitsList.addAll(stockBox.values.toList());
    notifyListeners();
  }

  void calculateTotals() {
    totalProfit = 0;
    totalLoss = 0;

    for (var stock in profitsList) {
      final int openingStock = stock.openingStock!;
      final int sellingPrice = stock.sellingPrice!;
      final int costPrice = stock.costPrice!;
      final int quantity = stock.quantity ?? 0;
      final int itemProfit =
          (openingStock + quantity) * sellingPrice - ((openingStock + quantity) * costPrice);

      if (itemProfit >= 0) {
        totalProfit += itemProfit;
      } else {
        totalLoss += -itemProfit;
      }
    }

    notifyListeners();
  }
}
