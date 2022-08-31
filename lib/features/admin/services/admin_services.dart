import 'dart:convert';
import 'dart:io';

import 'package:amazon_app/features/admin/models/sale.dart';
import 'package:amazon_app/models/order.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../constants/error_handling.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../../utilities/show_snack_bar.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic('usseiin', 'ee7ajobp');
      List<String> imageUrls = [];
      for (var image in images) {
        CloudinaryResponse res =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(
          image.path,
          folder: name,
        ));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        category: category,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        images: imageUrls,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: user.token,
        },
        body: product.toJson(),
      );

      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(
      {required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    List<Product> products = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: user.token,
        },
      );

      httpErroHandlingFunction(
          response: response,
          context: context,
          onSuccess: () {
            // for (var product in jsonDecode(response.body)) {
            //   products.add(Product.fromMap(product));
            // }
            final result = jsonDecode(response.body);
            products = List<Product>.from(
              result.map(
                (x) => Product.fromJson((jsonEncode(x))),
              ),
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return products;
  }

  Future<List<Order>> fetchAllOrders({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    List<Order> orders = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: user.token,
        },
      );

      httpErroHandlingFunction(
          response: response,
          context: context,
          onSuccess: () {
            // for (var product in jsonDecode(response.body)) {
            //   products.add(Product.fromMap(product));
            // }
            final result = jsonDecode(response.body);
            orders = List<Order>.from(
              result.map(
                (x) => Order.fromJson((jsonEncode(x))),
              ),
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return orders;
  }

  Future<void> deleteProduce({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErroHandlingFunction(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(
      {required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    List<Sales> sales = [];
    int totalEarning = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: user.token,
        },
      );

      httpErroHandlingFunction(
          response: response,
          context: context,
          onSuccess: () {
            var res = jsonDecode(response.body);
            totalEarning = res['totalEarnings'];
            sales = [
              Sales(label: 'Mobiles', earnings: res['mobileEarnings']),
              Sales(label: 'Appliances', earnings: res['applianceEarnings']),
              Sales(label: 'Essentials', earnings: res['essentialEarnings']),
              Sales(label: 'Books', earnings: res['booksEarnings']),
              Sales(label: 'Fashion', earnings: res['fashionEarnings']),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return {
      'sale': sales,
      'totalEarnings': totalEarning,
    };
  }
}
