import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:stock/model/stock.dart';

class Profit extends StatefulWidget {
  const Profit({Key? key}) : super(key: key);

  @override
  State<Profit> createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {
  final List<Stock> ProfitsList = [];
  final Box<Stock> _stockBox = Hive.box<Stock>('stockbox');
  int totalProfit = 0;
  int totalLoss = 0;

  @override
  void initState() {
    super.initState();
    loadProfit();

    calculateTotals();
  }

  void initstate() {
    super.initState();
    loadLoss();
    calculateTotals();
  }

  void loadProfit() {
    ProfitsList.addAll(_stockBox.values.toList());
  }

  void loadLoss() {
    ProfitsList.addAll(_stockBox.values.toList());
  }

  void calculateTotals() {
    for (var stock in ProfitsList) {
      final int openingstock = stock.openingStock!;
      final int sellingPrice = stock.sellingPrice!;
      final int costPrice = stock.costPrice!;
      final int quantity = stock.quantity ?? 0;
      final int itemProfit = (openingstock + quantity) * sellingPrice -
          ((openingstock + quantity) * costPrice);
      if (itemProfit >= 0) {
        totalProfit += itemProfit;
      } else {
        totalLoss += -itemProfit;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        title: Text(
          "Analyse",
          style: GoogleFonts.acme(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
      body: Column(
        children: [
          Expanded(
            child: ProfitsList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Data!',
                          style: GoogleFonts.acme(),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: ProfitsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final stock = ProfitsList[index];
                      final int openingstock = stock.openingStock!;
                      final int sellingPrice = stock.sellingPrice!;
                      final int costPrice = stock.costPrice!;
                      final int quantity = stock.quantity ?? 0;
                      final int itemProfit =
                          (openingstock + quantity) * sellingPrice -
                              ((openingstock + quantity) * costPrice);

                      Color profitColor = itemProfit >= 0
                          ? const Color.fromARGB(255, 27, 118, 37)
                          : const Color.fromARGB(255, 255, 17, 0);

                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: stock.imagePath != null
                                    ? DecorationImage(
                                        image:
                                            FileImage(File(stock.imagePath!)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            title: Text(
                              stock.itemname!,
                              style: GoogleFonts.acme(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            subtitle: Text(
                              itemProfit >= 0
                                  ? 'Profit : ₹ ${itemProfit.toString()}'
                                  : 'Loss : ₹ ${(-itemProfit).toString()}',
                              style: GoogleFonts.acme(
                                color: profitColor,
                              ),
                            ),
                            textColor: const Color.fromARGB(255, 255, 0, 0),
                            shape: Border.all(),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
