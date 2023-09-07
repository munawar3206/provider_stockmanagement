import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock/model/stock.dart';
import 'package:stock/view/item/detail/detail.dart';
import '../../utility/utilities.dart';
import '../item/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isWeekFilterSelected = false;
  final ValueNotifier<List<Stock>> recentlyAddedStocksNotifier =
      ValueNotifier<List<Stock>>([]);
  int totalExpense = 0;
  int totalStockProfit = 0;
  int totalStockLoss = 0;
  String username = '';
  @override
  void initState() {
    super.initState();
    loadRecentlyAddedStocks();
    getUsername();
    calculateTotalStockProfit();
    calculateTotalStockLoss();
  }

  Future<void> getUsername() async {
    final sharedPref = await SharedPreferences.getInstance();
    final savedUsername = sharedPref.getString('username');
    setState(() {
      username = savedUsername ?? '';
    });
  }

  Future<void> loadRecentlyAddedStocks() async {
    Item item = Item();
    item.loadStocks();

    recentlyAddedStocksNotifier.value =
        item.stocksNotifier.value.take(50).toList();

    calculateTotalStockProfit();
    calculateTotalStockLoss();
    int expense = 0;
    for (var stock in item.loadStocks()) {
      expense += (stock.costPrice! * (stock.openingStock!));
    }
    totalExpense = expense;

    setState(() {});
  }

  void calculateTotalStockProfit() {
    totalStockProfit = 0;
    for (var stock in recentlyAddedStocksNotifier.value) {
      final int openingStock = stock.openingStock!;
      final int sellingPrice = stock.sellingPrice!;
      final int costPrice = stock.costPrice!;
      final int quantity = stock.quantity ?? 0;
      final int itemProfit = (openingStock + quantity) * sellingPrice -
          ((openingStock + quantity) * costPrice);
      if (itemProfit >= 0) {
        totalStockProfit += itemProfit;
      }
    }
  }

  void calculateTotalStockLoss() {
    totalStockLoss = 0;
    for (var stock in recentlyAddedStocksNotifier.value) {
      final int openingStock = stock.openingStock!;
      final int sellingPrice = stock.sellingPrice!;
      final int costPrice = stock.costPrice!;
      final int quantity = stock.quantity ?? 0;
      final int itemProfit = (openingStock + quantity) * sellingPrice -
          ((openingStock + quantity) * costPrice);
      if (itemProfit < 0) {
        totalStockLoss += -itemProfit;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadRecentlyAddedStocks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        title: Text(
          "Hello, $username !",
          style: GoogleFonts.acme(
              fontWeight: FontWeight.bold, color: Colors.black),
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
                color: isWeekFilterSelected
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 13, 5, 78),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Summary",
                                style: GoogleFonts.acme(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.white,
                              ),
                              Text(
                                getPresentDate(),
                                style: const TextStyle(
                                  color: Colors.white,
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
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text('₹ $totalExpense',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255))),
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
                                child: Text('₹ $totalStockProfit',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text('₹ $totalStockLoss',
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
                valueListenable: recentlyAddedStocksNotifier,
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                          color: const Color.fromARGB(
                                              255, 18, 0, 137)),
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
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
    );
  }
}
