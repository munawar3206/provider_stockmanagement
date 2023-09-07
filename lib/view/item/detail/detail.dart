import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stock/functions/function.dart';
import 'package:stock/model/stock.dart';

import 'package:stock/widget/alertbox.dart';
import 'package:stock/view/item/detail/graph/piechart.dart';
import 'package:stock/view/item/detail/update/update.dart';

class Detail extends StatefulWidget {
  Stock stock;

  Detail({super.key, required this.stock});

  @override
  _DetailState createState() => _DetailState();                
}

class _DetailState extends State<Detail> {
  final StockRepository stockRepository = StockRepository();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        elevation: 0,
        title: Text(
          "Item Details",
          style: GoogleFonts.acme(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final updatedStock = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Update(stock: widget.stock),
                ),
              );

              if (updatedStock != 0) {
                stockRepository.updateStock(updatedStock);

                setState(() {
                  widget.stock = updatedStock;
                });
              }
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
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
                      image: widget.stock.imagePath != null
                          ? DecorationImage(
                              image: FileImage(File(widget.stock.imagePath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(widget.stock.itemname ?? 'Unknown Item'),
                    ],
                  ),
                  subtitle: Text(
                    'Opening Stock:${widget.stock.openingStock??0 - widget.stock.quantity!}',
                  ),
                  trailing: Text(
                    'Stall No: ${widget.stock.stallNo}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
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
                      Text('Selling Price: ${widget.stock.sellingPrice}'),
                    ],
                  ),
                  subtitle: Text('Actual Price: ${widget.stock.costPrice}'),
                  trailing: Text(
                    'SoldStocks: ${(widget.stock.quantity ?? 0)} ',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 43, 0, 255),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                Stock? updatedStock = await CustomAlertDialog.showAlertDialog(
                    context, widget.stock, quantityController);

                if (updatedStock != null) {
                  setState(() {
                    widget.stock = updatedStock;
                  });
                  stockRepository.updateStock(updatedStock);
                }
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 38, 0, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.system_update_alt_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 18),
                    Text(
                      "UPDATED STOCK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: const Color.fromARGB(255, 200, 209, 253),
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.425,
                child: PieChartWidget(
                  soldQuantity: (widget.stock.openingStock ?? 0) -
                      (widget.stock.quantity ?? 0),
                  openingStockQuantity: (widget.stock.quantity ?? 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
