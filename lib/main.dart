import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:stock/controller/addcontroller.dart';
import 'package:stock/controller/detailprovider.dart';
import 'package:stock/controller/homeprovider.dart';
import 'package:stock/controller/itemprovider.dart';
import 'package:stock/controller/profitprovider.dart';
import 'package:stock/model/stock.dart';
import 'view/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StockAdapter().typeId)) {
    Hive.registerAdapter(StockAdapter());
  }

  await Hive.openBox<Stock>('stockbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => ItemProvider()),
          ChangeNotifierProvider<HomeProvider>(
              create: (BuildContext context) => HomeProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => ProfitProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => AddProvider()),
          ChangeNotifierProvider(
            create: (BuildContext context) => DetailProvider(
              Stock(
                imagePath: null,
                itemname: null,
                stallNo: null,
                sellingPrice: 0,
                costPrice: 0,
                openingStock: 0,
                quantity: 0,
              ),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ));
  }
}
