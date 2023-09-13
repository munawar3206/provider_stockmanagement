import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock/controller/detailprovider.dart';
import 'package:stock/controller/itemprovider.dart';
import 'package:stock/helpers/app_colors.dart';
import 'package:stock/model/stock.dart';
import 'package:stock/view/item/detail/alertbox/alertbox.dart';
import 'package:stock/view/item/detail/graph/piechart.dart';
import 'package:stock/view/item/detail/update/update.dart';

class Detail extends StatelessWidget {
  final Stock stock;

  Detail({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemProvider>(context).stocksNotifier;
    return ChangeNotifierProvider(
      create: (context) => DetailProvider(stock),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appbar,
          elevation: 0,
          title: Text(
            "Item Details",
            style: GoogleFonts.acme(
              color: AppColors.bottom,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(
            color: AppColors.bottom,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final updatedStock = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Update(stock: stock),
                  ),
                );

                if (updatedStock != 0) {
                  Provider.of<DetailProvider>(context, listen: false)
                      .updatedStock(updatedStock);
                }
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        backgroundColor: AppColors.bg,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: ListTile(
                    leading: Container(
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
                    title: Row(
                      children: [
                        Text(stock.itemname ?? 'Unknown Item'),
                      ],
                    ),
                    subtitle: Text(
                      'Opening Stock: ${stock.openingStock ?? 0 - stock.quantity!}',
                    ),
                    trailing: Text(
                      'Stall No: ${stock.stallNo}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.loss,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text('Selling Price: ${stock.sellingPrice}'),
                      ],
                    ),
                    subtitle: Text('Actual Price: ${stock.costPrice}'),
                    trailing: Text(
                      'SoldStocks: ${(stock.quantity ?? 0)} ',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.login,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<DetailProvider>(
                builder: (context, detailProvider, child) {
                  return GestureDetector(
                    onTap: () async {
                      Stock? updatedStock =
                          await CustomAlertDialog.showAlertDialog(
                              context, stock, TextEditingController());

                      if (updatedStock != null) {
                        detailProvider.updatedStock(updatedStock);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.login,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.system_update_alt_outlined,
                            color: AppColors.card,
                          ),
                          SizedBox(width: 18),
                          Text(
                            "UPDATED STOCK",
                            style: TextStyle(
                              color: AppColors.card,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: AppColors.bg,
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.425,
                  child: Consumer<DetailProvider>(
                    builder: (context, detailProvider, child) {
                      return PieChartWidget(
                        soldQuantity:
                            (stock.openingStock ?? 0) - (stock.quantity ?? 0),
                        openingStockQuantity: (stock.quantity ?? 0),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
