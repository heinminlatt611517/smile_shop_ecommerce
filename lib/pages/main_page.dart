import 'package:flutter/material.dart';
import 'package:smile_shop/pages/cart_page.dart';
import 'package:smile_shop/pages/profile_page.dart';
import 'package:smile_shop/pages/ticket_screen.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/utils/strings.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;

  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  List<Widget> screenWidgets = [
    const HomePage(),
    const CartPage(),
    const TicketScreen(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kSecondaryColor,
        selectedFontSize: kTextSmall,
        unselectedFontSize: kTextSmall,
        unselectedItemColor: kBottomNavigationUnSelectedColor,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: _getBottomNavigationBarItems(),
      ),
      body: screenWidgets[currentIndex],
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(
          kHomeIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
          color: Colors.black,
        ),
        activeIcon: Image.asset(
          kHomeIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
        ),
        label: kHomeLabel,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          kCartIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
          color: Colors.black,
        ),
        activeIcon: Image.asset(
          kCartIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
        ),
        label: kCartLabel,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          kLiveChatIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
          color: Colors.black,
        ),
        activeIcon: Image.asset(
          kLiveChatIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
        ),
        label: kLiveChatLabel,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          kProfileIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
          color: Colors.black,
        ),
        activeIcon: Image.asset(
          kProfileIcon,
          width: kMarginXLarge,
          height: kMarginXLarge,
        ),
        label: kProfileLabel,
      ),
    ];
  }
}

