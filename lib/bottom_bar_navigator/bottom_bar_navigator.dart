
import 'package:capstone/home_screen/homescreen.dart';
import 'package:capstone/home_screen/task_history.dart';
import 'package:capstone/notification_screen/notification_screen.dart';
import 'package:capstone/information_screen/profile.dart';
import 'package:capstone/qr_scanner/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../utils/constants/color_constant.dart';
import '../utils/constants/image_constant.dart';

class BottomBarNavigator extends StatefulWidget {
  int selectedIndex = 0;

  bool isBottomNav = true;

  BottomBarNavigator(
      {super.key, required this.selectedIndex, required this.isBottomNav});

  @override
  State<BottomBarNavigator> createState() => _BottomBarNavigatorState(
      selectedIndex: selectedIndex, isBottomNav: isBottomNav);
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {
  int selectedIndex = 0;
  bool isBottomNav = true;

  _BottomBarNavigatorState(
      {required this.selectedIndex, required this.isBottomNav});

  Widget? pageCaller(index) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const History();
      case 2:
        return const QRscanner();
      case 3:
        return const Notificaiton();
      case 4:
        return const Info();


      default:
        return const SizedBox();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body: pageCaller(selectedIndex),
      bottomNavigationBar: isBottomNav == true
          ? BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(ImageConstant.icHome),
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(ImageConstant.icHistory),
            ),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(ImageConstant.imgQRScanner),
            ),
            label: 'Quét QR',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(ImageConstant.icNotification),
            ),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(ImageConstant.icProfile),
            ),
            label: 'Thông tin',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: ColorConstant.primaryColor,
        selectedLabelStyle: TextStyle(
          color: ColorConstant.primaryColor,
        ),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.black,
        ),
        showUnselectedLabels: true,
        elevation: 0,
        onTap: _onItemTapped,
      )
          : Container(
        height: 0,
      ),
    );
  }
}
