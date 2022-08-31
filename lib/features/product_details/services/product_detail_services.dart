import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constant.dart';
import '../../../constants/error_handling.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../../utilities/show_snack_bar.dart';

class ProductDetailService {
  addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          authToken: user.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      log(response.body);

      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: () {
          User updateUser = user.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );

          user.setUserFromModel(updateUser);
        },
      );
    } catch (e) {
      log(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          authToken: user.user.token
        },
        body: jsonEncode(
          {
            'id': product.id,
            'rating': rating,
          },
        ),
      );
      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
