import 'package:flutter/material.dart';

import '../../../constants/constant.dart';
import '../../../models/order.dart';
import '../../../widgets/loader.dart';
import '../../order_details/screen/order_details_screen.dart';
import '../services/account_service.dart';
import 'image_product.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? order;

  final AccountService _accountService = AccountService();

  void fetchOrders() async {
    order = await _accountService.fetchOrder(context: context);
    setState(() {});
  }

  navigateToOrderDetailScreen(int index) {
    Navigator.pushNamed(
      context,
      OrderDetailsScreen.routeName,
      arguments: order![index],
    );
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: GlobalVariable.selectedColor,
                ),
              ),
            ),
          ],
        ),
        order == null
            ? const Center(
                child: Loader(),
              )
            : Container(
                height: 170,
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 0,
                  right: 0,
                  left: 10,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: order!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: navigateToOrderDetailScreen(index),
                      child: SingleProduct(
                        image: order![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
