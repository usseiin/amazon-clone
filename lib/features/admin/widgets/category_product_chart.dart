import 'package:charts_flutter/flutter.dart' as charts;

import 'package:amazon_app/features/admin/models/sale.dart';
import 'package:flutter/material.dart';

class CategoriesProductChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoriesProductChart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
