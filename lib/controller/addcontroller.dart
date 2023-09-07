import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:stock/model/stock.dart';

class AddProvider extends ChangeNotifier {
  XFile? pickedImage;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController openingStockController = TextEditingController();
  TextEditingController stallNumberController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController costPriceController = TextEditingController();

  Future<void> pickImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image From...'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    pickedImage = picked;
                    notifyListeners();
                  }
                },
                child: const Text('Camera'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? picked =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    pickedImage = picked;
                    notifyListeners();
                  }
                },
                child: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void addStock(Stock newStock) {
    // Add your logic to save the newStock data to your data source
    // For example, you can use a repository or database here
    // Once the stock is added, you can notify listeners if needed
    // For example: notifyListeners();
  }
}
