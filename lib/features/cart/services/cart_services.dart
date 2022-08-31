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

class CartServices {
  removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/user/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          authToken: userProvider.user.token,
        },
      );

      httpErroHandlingFunction(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(cart: jsonDecode(response.body)['cart']);

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      log(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
