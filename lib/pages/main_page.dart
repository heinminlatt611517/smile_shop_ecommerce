import 'package:flutter/material.dart';
import 'package:smile_shop/pages/cart_page.dart';
import 'package:smile_shop/pages/chat_screen.dart';
import 'package:smile_shop/pages/profile_page.dart';
import 'package:smile_shop/pages/ticket_screen.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/utils/strings.dart';
import '../widgets/svg_image_view.dart';
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
    const ChatScreen(),
    const ProfilePage()
  ];

  Future<bool> _onWillPop() async {
    if (currentIndex != 0) {
      setState(() {
        currentIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: SvgImageView(
          imageName: kHomeIcon,
          imageHeight: 20,
          imageWidth: 20,
          iconColor: Colors.black,
        ),
        activeIcon:SvgImageView(
          imageName: kHomeIcon,
          imageHeight: 20,
          imageWidth: 20,
        ),
        label: kHomeLabel,
      ),
      const BottomNavigationBarItem(
        icon: SvgImageView(
          imageName: kCartIcon,
          imageHeight: 20,
          imageWidth: 20,
          iconColor: Colors.black,
        ),
        activeIcon:SvgImageView(
          imageName: kCartIcon,
          imageHeight: 20,
          imageWidth: 20,
        ),
        label: kCartLabel,
      ),
      const BottomNavigationBarItem(
        icon: SvgImageView(
          imageName: kLiveChatIcon,
          imageHeight: 20,
          imageWidth: 20,
          iconColor: Colors.black,
        ),
        activeIcon:SvgImageView(
          imageName: kLiveChatIcon,
          imageHeight: 20,
          imageWidth: 20,
        ),
        label: kLiveChatLabel,
      ),
      const BottomNavigationBarItem(
        icon: SvgImageView(
          imageName: kProfileIcon,
          imageHeight: 20,
          imageWidth: 20,
          iconColor: Colors.black,
        ),
        activeIcon:SvgImageView(
          imageName: kProfileIcon,
          imageHeight: 20,
          imageWidth: 20,
        ),
        label: kProfileLabel,
      ),
    ];
  }
}
