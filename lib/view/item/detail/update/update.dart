import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock/functions/function.dart';
import 'package:stock/helpers/app_colors.dart';
import 'package:stock/model/stock.dart';
import 'package:stock/view/item/detail/update/widget_update.dart';

class Update extends StatelessWidget {
  final Stock stock;
  final StockRepository stockRepository = StockRepository();
  Update({super.key, required this.stock});

  final _itemNameController = TextEditingController();
  final _stallNumberController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _openingStockController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _initControllers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.appbar,
        iconTheme: const IconThemeData(color: AppColors.bottom),
        title: Text(
          'Edit Items',
          style: GoogleFonts.acme(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _saveChanges(context); /*callback update */
            },
            child: const Text(
              "SAVE",
              style: TextStyle(color:AppColors.login),
            ),
          )
        ],
        elevation: 0,
      ),
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 500,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text2(labelText: 'Item Name', controller: _itemNameController, keyboardType: TextInputType.text, hintText: 'Enter Item Name'),
                    const SizedBox(height: 16),
                    text2(labelText: 'Stall No:', controller: _stallNumberController, keyboardType: TextInputType.text, hintText: 'A2...'),
                    const SizedBox(height: 16),
                    text2(labelText: 'Selling Price', controller: _sellingPriceController, keyboardType: TextInputType.number, hintText: '₹'),
                    const SizedBox(height: 16),
                    text2(labelText: 'Cost Price', controller: _costPriceController, keyboardType: TextInputType.number, hintText: '₹'),
                    const SizedBox(height: 16),
                    text2(labelText: 'OpeningStock', controller: _openingStockController, keyboardType: TextInputType.number, hintText: '123....'),
                 
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*updating */
  void _initControllers() {
  _itemNameController.text = stock.itemname!;
  _stallNumberController.text = stock.stallNo!;
  _sellingPriceController.text = stock.sellingPrice.toString();
  _costPriceController.text = stock.costPrice.toString();
  _openingStockController.text = stock.openingStock.toString();
  
  _quantityController.text = stock.quantity.toString();
}

void _saveChanges(BuildContext context) {
  Stock updatedStock = Stock(
    id: stock.id,
    imagePath: stock.imagePath,
    itemname: _itemNameController.text,
    stallNo: _stallNumberController.text,
    sellingPrice: int.tryParse(_sellingPriceController.text) ?? 0,
    costPrice: int.tryParse(_costPriceController.text) ?? 0,
    openingStock: int.tryParse(_openingStockController.text) ?? 0,
    quantity: int.tryParse(_quantityController.text) ?? 0,
  );

  stockRepository.updateStock(updatedStock);

  Navigator.pop(context, updatedStock);
}
}
