import 'package:hive/hive.dart';
import 'package:stock/model/stock.dart';

class StockRepository {
  final Box<Stock> _stockBox = Hive.box<Stock>('stockbox');

  List<Stock> getAllStock() {
    return _stockBox.values.toList();
  }

  void addStock(Stock stock) {
    _stockBox.add(stock);
  }

  void updateStock(Stock updatedStock) {
    final int index = _stockBox.values
        .toList()
        .indexWhere((stock) => stock.id == updatedStock.id);
    if (index != -1) {
      _stockBox.putAt(index, updatedStock);
    }
  }

  void deleteStock(int index) {
    _stockBox.deleteAt(index);
    getAllStock();
  }
}
