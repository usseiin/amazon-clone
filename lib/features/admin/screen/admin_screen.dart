import 'package:amazon_app/features/admin/screen/analytics_screen.dart';
import 'package:amazon_app/features/admin/screen/order_screen.dart';
import 'package:amazon_app/features/admin/screen/post_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constant.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Widget> pages = [
    const PostScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];
  int _page = 0;
  final double _bottomBarWidth = 42;
  final double _bottomBarBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                ),
              ),
              const Text(
                "Admin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
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
              child: const Icon(Icons.analytics_outlined),
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
                      color: _page == 2
                          ? GlobalVariable.selectedColor!
                          : GlobalVariable.backgroundColor,
                    ),
                  ),
                ),
                child: const Icon(Icons.all_inbox_outlined)),
          ),
        ],
      ),
    );
  }
}
