import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:stock/controller/homeprovider.dart';
import 'package:stock/helpers/app_colors.dart';
import 'package:stock/model/stock.dart';
import 'package:stock/view/item/detail/detail.dart';
import 'package:stock/utility/utilities.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context).loadRecentlyAddedStocks();
    return Consumer<HomeProvider>(
      builder: (context, homeprovider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 207, 216, 255),
            title: Text(
              "Hello, ${homeprovider.username} !",
              style: GoogleFonts.acme(
                fontWeight: FontWeight.bold,
                fontSize: 20,    
                color: Colors.black,
              ),
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 8,
                    color: AppColors.summcard,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.all(12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Summary",
                                    style: GoogleFonts.acme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: AppColors.card),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.calendar_month_sharp,
                                    color: AppColors.card,
                                  ),
                                  Text(
                                    getPresentDate(),
                                    style: const TextStyle(
                                      color: AppColors.card,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Total Expense",
                                style: GoogleFonts.acme(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: AppColors.card),
                              ),
                              const SizedBox(height: 10),
                              Text('₹ ${homeprovider.totalExpense}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                              const SizedBox(height: 10),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Total Profit",
                                      style: GoogleFonts.acme(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Total Loss",
                                      style: GoogleFonts.acme(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        '₹ ${homeprovider.totalStockProfit}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        '₹ ${homeprovider.totalStockLoss}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        "Recently Added Stocks",
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValueListenableBuilder<List<Stock>>(
                    valueListenable: homeprovider.recentlyAddedStocksNotifier,
                    builder: (context, stocks, _) {
                      return Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.height * 0.500,
                        child: stocks.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    'asset/animation_lldglary.json',
                                  ),
                                  const Text(
                                    'No recently added stocks!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: stocks.length,
                                itemBuilder: (context, id) {
                                  Stock stock = stocks[id];
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Card(
                                      elevation: 10,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      child: ListTile(
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
                                          stock.itemname ?? '',
                                          style: GoogleFonts.acme(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                        subtitle: Text(
                                          stock.stallNo ?? '',
                                          style: GoogleFonts.acme(
                                              color: AppColors.summcard),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Detail(stock: stock),
                                            ),
                                          );
                                        },
                                        shape: Border.all(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          backgroundColor: AppColors.bg,
        );
      },
    );
  }
}
