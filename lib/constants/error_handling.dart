import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utilities/show_snack_bar.dart';

void httpErroHandlingFunction({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
        context,
        json.decode(response.body)['msg'],
      );
      break;
    case 500:
      showSnackBar(
        context,
        json.decode(response.body)['error'],
      );
      break;
    default:
      showSnackBar(context, 'error: ${response.body}');
  }
}
