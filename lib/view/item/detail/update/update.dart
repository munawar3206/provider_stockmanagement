import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock/functions/function.dart';
import 'package:stock/model/stock.dart';

class Update extends StatelessWidget {
  final Stock stock;
  final StockRepository stockRepository = StockRepository();
  Update({super.key, required this.stock});

  final _itemNameController = TextEditingController();
  final _stallNumberController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _openingStockController = TextEditingController();
  // final _soldStockController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _initControllers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        iconTheme: const IconThemeData(color: Colors.black),
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
              style: TextStyle(color: Color.fromARGB(255, 0, 42, 255)),
            ),
          )
        ],
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
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
                    _buildTextFormField('Item Name', _itemNameController,
                        TextInputType.text, 'Enter Item Name'),
                    const SizedBox(height: 16),
                    _buildTextFormField('Stall No:', _stallNumberController,
                        TextInputType.text, 'A2...'),
                    const SizedBox(height: 16),
                    _buildTextFormField('Selling Price',
                        _sellingPriceController, TextInputType.number, '₹'),
                    const SizedBox(height: 16),
                    _buildTextFormField('Cost Price', _costPriceController,
                        TextInputType.number, '₹'),
                    const SizedBox(height: 16),
                    _buildTextFormField('OpeningStock', _openingStockController,
                        TextInputType.number, '123....'),
                 
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



  Widget _buildTextFormField(String labelText, TextEditingController controller,
      TextInputType keyboardType, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
