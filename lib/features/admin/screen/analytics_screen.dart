import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:amazon_app/features/admin/widgets/category_product_chart.dart';
import 'package:amazon_app/widgets/loader.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

import '../models/sale.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices _adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earning;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await _adminServices.getEarnings(context: context);
    totalSales = earningData['totalEarnings'];
    earning = earningData['sales'];
  }

  @override
  Widget build(BuildContext context) {
    return earning == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 150,
                child: CategoriesProductChart(seriesList: [
                  charts.Series(
                    id: 'sales',
                    data: earning!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earnings,
                  )
                ]),
              )
            ],
          );
  }
}
