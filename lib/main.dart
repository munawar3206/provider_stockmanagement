import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:stock/controller/homecontroller.dart';
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
        // ChangeNotifierProvider(create: (context) => AddController()),
        ChangeNotifierProvider(create: (context) => HomeController()), // Add HomeController provider
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
     ) );
  }
}
