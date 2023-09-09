import 'package:flutter/foundation.dart';
import 'package:stock/functions/function.dart';
import 'package:stock/model/stock.dart';

class ItemProvider extends ChangeNotifier {
  final StockRepository stockRepository = StockRepository();
  List<Stock> _stocks = [];

  List<Stock> get stocks => _stocks;


  ValueNotifier<List<Stock>> get stocksNotifier =>
      ValueNotifier<List<Stock>>(_stocks);

  ItemProvider() {
    loadStocks();
  }

  void loadStocks() {
    _stocks = stockRepository.getAllStock();
    notifyListeners();
  }

  void filterStocks(String query) {
    if (query.isEmpty) {
      _stocks = stockRepository.getAllStock();
    } else {
      _stocks = _stocks.where((stock) =>
          stock.itemname!.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void deleteStock(int index) {
    stockRepository.deleteStock(index);
    loadStocks();
  }
}