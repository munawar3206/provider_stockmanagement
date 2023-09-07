import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock/helpers/app_colors.dart';

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
          style: TextStyle(color:AppColors.loss),
        ),
        content: const Text(
          "Are you sure you want to reset all settings",
          style: TextStyle(color:AppColors.card),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color:AppColors.card),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              "Reset",
              style: TextStyle(color:AppColors.loss),
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
