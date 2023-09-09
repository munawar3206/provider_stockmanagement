import 'package:flutter/material.dart';
import 'package:stock/model/stock.dart';

class DetailProvider extends ChangeNotifier {
  Stock _stock;
  DetailProvider(this._stock);

  Stock get stock => _stock;

  void updatedStock(Stock updatedStock) {
    _stock = updatedStock;
    notifyListeners();
  }
}
