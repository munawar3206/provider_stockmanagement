import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stock/helpers/app_colors.dart';

Future<void> exitDB(
  BuildContext context,
) async {
  // ignore: use_build_context_synchronously
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.bottom,
        title: const Text(
          "Confirm Exit",
          style: TextStyle(color: AppColors.loss),
        ),
        content: const Text(
          "Are you sure you want to Exit App",
          style: TextStyle(color:AppColors.card),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.card),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              "Exit",
              style: TextStyle(color:AppColors.loss),
            ),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
