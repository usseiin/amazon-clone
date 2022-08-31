// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amazon_app/constants/error_handling.dart';
import 'package:amazon_app/models/user.dart';
import 'package:amazon_app/features/home/screen/home.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:amazon_app/utilities/show_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../constants/constant.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        email: email,
        name: name,
        id: '',
        token: '',
        address: '',
        type: '',
        password: password,
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      log(res.statusCode.toString());
      log(res.body);

      httpErroHandlingFunction(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credential',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    log('dart signing in...');
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      log('response gotten');
      httpErroHandlingFunction(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString(authToken, jsonDecode(res.body)['token']);
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString(authToken);

      if (token == null) {
        prefs.setString(authToken, '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          authToken: token!,
        },
      );

      var response = json.decode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            authToken: token,
          },
        );
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } on HttpException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}

String authToken = 'x-auth-token';
