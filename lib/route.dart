import 'package:amazon_app/features/address/screen/address_screen.dart';
import 'package:amazon_app/features/order_details/screen/order_details_screen.dart';
import 'package:amazon_app/features/product_details/screen/product_details_screen.dart';
import 'package:amazon_app/models/product.dart';
import 'package:flutter/material.dart';

import 'features/admin/screen/add_product_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screen/home.dart';
import 'features/home/screen/category_deal_screen.dart';
import 'features/search/screen/search_screen.dart';
import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AddProductScreen(),
      );
    case SearchScreen.routeName:
      var searchValue = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchScreen(
          searchValue: searchValue,
        ),
      );
    case CategoryDealScreen.routeName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = settings.arguments as Product;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailsScreen.routeName:
      var order = settings.arguments as Order;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) {
          return const MaterialApp(
            home: Scaffold(
              body: Text("Page doesn't exit"),
            ),
          );
        },
      );
  }
}
