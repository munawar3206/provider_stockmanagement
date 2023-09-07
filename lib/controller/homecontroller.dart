import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock/model/stock.dart';
import 'package:stock/view/item/item.dart';

class HomeController extends ChangeNotifier {
  int totalExpense = 0;
  int totalStockProfit = 0;
  int totalStockLoss = 0;
  String username = '';
  final ValueNotifier<List<Stock>> recentlyAddedStocksNotifier =
      ValueNotifier<List<Stock>>([]);

  HomeController() {
    loadRecentlyAddedStocks();
    getUsername();
    calculateTotalStockProfit();
    calculateTotalStockLoss();
  }

  Future<void> getUsername() async {
    final sharedPref = await SharedPreferences.getInstance();
    final savedUsername = sharedPref.getString('username');
    username = savedUsername ?? '';
    notifyListeners();
  }

  Future<void> loadRecentlyAddedStocks() async {
    Item item = Item();
    item.loadStocks();

    recentlyAddedStocksNotifier.value =
        item.stocksNotifier.value.take(50).toList();

    calculateTotalStockProfit();
    calculateTotalStockLoss();
    int expense = 0;
    for (var stock in item.loadStocks()) {
      expense += (stock.costPrice! * (stock.openingStock!));
    }
    totalExpense = expense;
    notifyListeners();
  }

  void calculateTotalStockProfit() {
    totalStockProfit = 0;
    for (var stock in recentlyAddedStocksNotifier.value) {
      final int openingStock = stock.openingStock!;
      final int sellingPrice = stock.sellingPrice!;
      final int costPrice = stock.costPrice!;
      final int quantity = stock.quantity ?? 0;
      final int itemProfit = (openingStock + quantity) * sellingPrice -
          ((openingStock + quantity) * costPrice);
      if (itemProfit >= 0) {
        totalStockProfit += itemProfit;
      }
    }
    notifyListeners();
  }

  void calculateTotalStockLoss() {
    totalStockLoss = 0;
    for (var stock in recentlyAddedStocksNotifier.value) {
      final int openingStock = stock.openingStock!;
      final int sellingPrice = stock.sellingPrice!;
      final int costPrice = stock.costPrice!;
      final int quantity = stock.quantity ?? 0;
      final int itemProfit = (openingStock + quantity) * sellingPrice -
          ((openingStock + quantity) * costPrice);
      if (itemProfit < 0) {
        totalStockLoss += -itemProfit;
      }
    }
    notifyListeners();
  }
}
