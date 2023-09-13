import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:stock/controller/detailprovider.dart';
// import 'package:stock/controller/itemprovider.dart';
import 'package:stock/controller/profitprovider.dart';
import 'package:stock/helpers/app_colors.dart';
// import 'package:stock/model/stock.dart';

class Profit extends StatelessWidget {
  const Profit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfitProvider>(context).calculateTotals();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.appbar,
        title: Text(
          "Analyse",
          style: GoogleFonts.acme(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      backgroundColor: AppColors.bg,
      body: Consumer<ProfitProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: value.profitsList.isEmpty
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
                        itemCount: value.profitsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final stock = value.profitsList[index];
                          final int openingStock = stock.openingStock!;
                          final int sellingPrice = stock.sellingPrice!;
                          final int costPrice = stock.costPrice!;
                          final int quantity = stock.quantity ?? 0;
                          final int itemProfit =
                              (openingStock + quantity) * sellingPrice -
                                  ((openingStock + quantity) * costPrice);

                          Color profitColor = itemProfit >= 0
                              ? AppColors.profit
                              : AppColors.loss;

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
                                            image: FileImage(
                                                File(stock.imagePath!)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                title: Text(
                                  stock.itemname!,
                                  style:
                                      GoogleFonts.acme(color: AppColors.bottom),
                                ),
                                subtitle: Text(
                                  itemProfit >= 0
                                      ? 'Profit : ₹ ${itemProfit.toString()}'
                                      : 'Loss : ₹ ${(-itemProfit).toString()}',
                                  style: GoogleFonts.acme(
                                    color: profitColor,
                                  ),
                                ),
                                textColor: AppColors.loss,
                                shape: Border.all(),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
