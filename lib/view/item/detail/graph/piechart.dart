import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stock/helpers/app_colors.dart';

class PieChartWidget extends StatelessWidget {
  final int soldQuantity;
  final int openingStockQuantity;

  PieChartWidget({
    required this.soldQuantity,
    required this.openingStockQuantity,
  });

  @override
  Widget build(BuildContext context) {
    int totalQuantity = openingStockQuantity + soldQuantity;
    double openingStockPercentage =
        (openingStockQuantity / totalQuantity) * 100;
    double soldPercentage = (soldQuantity / totalQuantity) * 100;

    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: openingStockPercentage,
              color:AppColors.sold,
              title:
                  'Sold Stock: ${openingStockPercentage.toStringAsFixed(2)}%',
              titleStyle:
                const  TextStyle(color: AppColors.card, fontWeight: FontWeight.bold),
              radius: 150,
            ),
            PieChartSectionData(
              value: soldPercentage,
              color: AppColors.login,
              title: 'Available Stock: ${soldPercentage.toStringAsFixed(2)}%',
              titleStyle: const TextStyle(color:AppColors.card, fontWeight: FontWeight.bold),
              radius: 150,
            ),
          ],
          centerSpaceRadius: 0,
          sectionsSpace: 0,
          borderData: FlBorderData(
            show: false,
          ),
        ),
      ),
    );
  }
}
