import 'package:amazon_app/constants/constant.dart';
import 'package:amazon_app/features/account/screens/account_screen.dart';
import 'package:amazon_app/features/cart/screen/cart_screen.dart';
import 'package:amazon_app/features/home/screen/home.dart';
import 'package:amazon_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen()
  ];

  int _page = 0;
  final double _bottomBarWidth = 42;
  final double _bottomBarBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariable.selectedColor,
        unselectedItemColor: GlobalVariable.unselectedColor,
        backgroundColor: GlobalVariable.backgroundColor,
        iconSize: 28,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: _bottomBarBorderWidth,
                    color: _page == 0
                        ? GlobalVariable.selectedColor!
                        : GlobalVariable.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: _bottomBarBorderWidth,
                    color: _page == 1
                        ? GlobalVariable.selectedColor!
                        : GlobalVariable.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Stack(
              children: [
                Positioned(
                  top: 4,
                  right: -1,
                  child: Container(
                    color: Colors.white,
                    child: Builder(builder: (context) {
                      final userCartLen =
                          context.watch<UserProvider>().user.cart.length;

                      return Text(
                        "$userCartLen",
                        style: TextStyle(
                          color: _page == 2
                              ? GlobalVariable.selectedColor
                              : GlobalVariable.unselectedColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  width: _bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: _bottomBarBorderWidth,
                        color: _page == 2
                            ? GlobalVariable.selectedColor!
                            : GlobalVariable.backgroundColor,
                      ),
                    ),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
