import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:stock/model/stock.dart';
import 'package:stock/widget/bottom.dart';

//clear from db - reset

Future<void> resetDB(
  BuildContext context,
) async {
  // ignore: use_build_context_synchronously
  bool confirmReset = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Confirm Reset",
          style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        ),
        content: const Text(
          "Are you sure you want to reset all settings",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              "Reset",
              style: TextStyle(color: Color.fromARGB(255, 245, 0, 0)),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmReset == true) {
    final stockbox = await Hive.openBox<Stock>('stockbox');
    stockbox.clear();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Bottom(),
        ));
  }
}
