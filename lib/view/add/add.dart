import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock/functions/function.dart';
import 'package:stock/model/stock.dart';
import 'package:stock/utility/utilities.dart';
import 'package:stock/view/add/widget_add.dart';
import 'package:stock/view/item/item.dart';

class Add extends StatefulWidget {
  const Add({Key? key});
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _openingStockController = TextEditingController();
  final _stallNumberController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final StockRepository stockRepository = StockRepository();
  XFile? pickedImage;
  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Image
        return AlertDialog(
          title: const Text('Pick Image From...'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? picked =
                      await ImageUtils.pickImage(ImageSource.camera);
                  setState(() {
                    pickedImage = picked;
                  });
                },
                child: const Text('Camera'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? picked =
                      await ImageUtils.pickImage(ImageSource.gallery);
                  setState(() {
                    pickedImage = picked;
                  });
                },
                child: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  int totalExpense = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Item()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          "Add Item",
          style: GoogleFonts.acme(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                        width: 8,
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  child: Stack(
                    children: [
                      pickedImage != null
                          ? Image.file(
                              File(pickedImage!.path),
                              width: 100,
                              height: 100,
                            )
                          : Container(),
                      pickedImage == null
                          ? IconButton(
                              onPressed: () {
                                _pickImage();
                              },
                              icon: const Icon(Icons.camera),
                              iconSize: 68,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              pickedImage == null
                  ? Text(
                      'Add Image',
                      style: GoogleFonts.acme(color: Colors.black),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(label: 'Item Name', controller: _itemNameController, keyboardType: TextInputType.text, hintText: 'Enter Item Name', inputFormatters: null),
                        const SizedBox(height: 16),
                        text(label: 'Opening Stock', controller: _openingStockController, keyboardType: TextInputType.number, hintText: '0', inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        const SizedBox(height: 16),
                        text(label: 'Stall No:', controller: _stallNumberController, keyboardType: TextInputType.text, hintText: 'A2...', inputFormatters: null),
                        const SizedBox(height: 16),
                        text(label: 'Selling Price', controller: _sellingPriceController, keyboardType: TextInputType.number, hintText: '₹', inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        const SizedBox(height: 16),
                        text(label: 'Cost Price', controller: _costPriceController, keyboardType: TextInputType.number, hintText: '₹', inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final Stock newStock = Stock(
                                    
                                    imagePath: pickedImage?.path ?? '',
                                    itemname: _itemNameController.text,
                                    openingStock:
                                        int.parse(_openingStockController.text),
                                    stallNo: _stallNumberController.text,
                                    sellingPrice:
                                        int.parse(_sellingPriceController.text),
                                    costPrice:
                                        int.parse(_costPriceController.text),
                                  );

                                  stockRepository.addStock(newStock);
                                  int totalExpense = int.parse(
                                      _costPriceController.text *
                                          int.parse(
                                              _openingStockController.text));
                                  Navigator.pop(context, totalExpense);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Item(),
                                      ));
                                }
                              },
                              child: const Text('SAVE')),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
    );
  }
}
