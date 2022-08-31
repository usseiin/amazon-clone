import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../constants/error_handling.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../../utilities/show_snack_bar.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProduct({
    required BuildContext context,
    required String searchValue,
  }) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/search/$searchValue'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: user.token
        },
      );

      httpErroHandlingFunction(
          response: response,
          context: context,
          onSuccess: () {
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
}
