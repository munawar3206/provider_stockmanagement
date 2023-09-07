import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock/helpers/app_colors.dart';
import 'package:stock/model/stock.dart';
import '../../../../utility/utilities.dart';

class CustomAlertDialog {
  static Future<Stock?> showAlertDialog(BuildContext context, Stock stock,
      TextEditingController quantityController) async {
    final stockUtils = StockUtils([quantityController]);
    quantityController.text = stock.quantity.toString();
    return showDialog<Stock>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Select Quantity"),
              IconButton(
                onPressed: () => Navigator.of(ctx).pop(),
                icon: const Icon(Icons.close),
                color: AppColors.bottom,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: stock.imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(stock.imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(stock.itemname!),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => stockUtils.decreaseStockQuantities(),
                    icon: const Icon(Icons.remove),
                    color:AppColors.bottom,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "0.0",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => stockUtils.increaseStockQuantities(),
                    icon: const Icon(Icons.add),
                    color:AppColors.bottom,
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                int quantity = stockUtils.getTotalQuantity();

                stock.quantity = quantity;

                Navigator.of(ctx).pop(stock);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.login,
              ),
              child: const Text(
                "OK",
                style: TextStyle(color:AppColors.card),
              ),
            ),
          ],
        );
      },
    );
  }
}
