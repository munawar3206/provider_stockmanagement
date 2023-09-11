// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/services.dart';
import 'package:stock/functions/function.dart';
// import 'package:stock/model/stock.dart';
// import 'package:stock/utility/utilities.dart';
import 'package:stock/view/add/image.dart';

class AddProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController openingStockController = TextEditingController();
  final TextEditingController stallNumberController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();
  final StockRepository stockRepository = StockRepository();
  XFile? pickedImage;

  Future<void> pickImage() async {
    final XFile? picked = await ImageUtils.pickImage(ImageSource.gallery);
    pickedImage = picked;
    notifyListeners();
  }

  int totalExpense = 0;
}
