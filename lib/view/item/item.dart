import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stock/controller/itemprovider.dart';
import 'package:stock/model/stock.dart';
// import 'package:stock/provider/item_provider.dart'; // Import the ItemProvider
import 'package:stock/view/item/detail/detail.dart';
import 'package:stock/widget/bottom.dart';

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemProvider>(context).loadStocks();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Bottom(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 207, 216, 255),
        title: Text(
          "Items",
          style: GoogleFonts.acme(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 228, 255),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              onChanged: (value) {
                Provider.of<ItemProvider>(context, listen: false)
                    .filterStocks(value); // Use the provider to filter stocks
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                hintText: 'Search Item Name...',
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Item(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                final stocks = itemProvider.stocks;
                if (stocks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('asset/data.json'),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: stocks.length,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    Stock stock = stocks[index];
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: ListTile(
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
                                style: GoogleFonts.acme(),
                              ),
                              subtitle: Text(
                                stock.stallNo!,
                                style: GoogleFonts.acme(
                                  color: const Color.fromARGB(255, 2, 26, 93),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detail(stock: stock),
                                  ),
                                );
                              },
                              shape: Border.all(),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Deletion'),
                                        content: const Text(
                                            'Are you sure you want to delete this Stock?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              itemProvider.deleteStock(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  itemProvider.loadStocks();
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
