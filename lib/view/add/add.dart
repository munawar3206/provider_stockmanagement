import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stock/controller/addcontroller.dart';
// import 'package:stock/controller/add_provider.dart';
// import 'package:stock/functions/function.dart';
import 'package:stock/model/stock.dart';
// import 'package:stock/utility/utilities.dart';
import 'package:stock/view/add/widget_add.dart';
import 'package:stock/view/item/item.dart';

class AddForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddProvider addProvider = Provider.of<AddProvider>(context);

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
                      addProvider.pickedImage != null
                          ? Image.file(
                              File(addProvider.pickedImage!.path),
                              width: 100,
                              height: 100,
                            )
                          : Container(),
                      addProvider.pickedImage == null
                          ? IconButton(
                              onPressed: () async {
                                final PickedFile = await addProvider.pickImage();
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
              addProvider.pickedImage == null
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
                    key: addProvider.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(label: 'Item Name', controller: addProvider.itemNameController, keyboardType: TextInputType.text, hintText: 'Enter Item Name', inputFormatters: null),
                        const SizedBox(height: 16),
                        text(label: 'Opening Stock', controller: addProvider.openingStockController, keyboardType: TextInputType.number, hintText: '0', inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        const SizedBox(height: 16),
                        text(label: 'Stall No:', controller: addProvider.stallNumberController, keyboardType: TextInputType.text, hintText: 'A2...', inputFormatters: null),
                        const SizedBox(height: 16),
                        text(label: 'Selling Price', controller: addProvider.sellingPriceController, keyboardType: TextInputType.number, hintText: '₹', inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        const SizedBox(height: 16),
                        text(label: 'Cost Price', controller: addProvider.costPriceController, keyboardType: TextInputType.number, hintText: '₹', inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (addProvider.formKey.currentState!.validate()) {
                                  final Stock newStock = Stock(
                                    imagePath: addProvider.pickedImage?.path ?? '',
                                    itemname: addProvider.itemNameController.text,
                                    openingStock: int.parse(addProvider.openingStockController.text),
                                    stallNo: addProvider.stallNumberController.text,
                                    sellingPrice: int.parse(addProvider.sellingPriceController.text),
                                    costPrice: int.parse(addProvider.costPriceController.text),
                                  );

                                  addProvider.stockRepository.addStock(newStock);
                                 int totalExpense = int.parse(addProvider.costPriceController.text) *
                                 int.parse(addProvider.openingStockController.text);
                                  Navigator.pop(context, totalExpense);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>const Item(),
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