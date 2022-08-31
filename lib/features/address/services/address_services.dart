import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../constants/error_handling.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../../utilities/show_snack_bar.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );

      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(response.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalAmount,
  }) async {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/order-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: userProvider.user.token,
        },
        body: jsonEncode(
          {
            'address': address,
            'totalPrice': totalAmount,
            'cart': userProvider.user.cart,
          },
        ),
      );

      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed');
          User user = userProvider.user.copyWith(
            cart: [],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
