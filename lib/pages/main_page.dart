import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/pages/cart_page.dart';
import 'package:smile_shop/pages/chat_screen.dart';
import 'package:smile_shop/pages/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/images.dart';
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
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min, // Ensures row only takes up required space
            children: [
              _buildNavItem(kHomeIcon, AppLocalizations.of(context)!.home, 0),
              _buildNavItem(kCartIcon, AppLocalizations.of(context)!.cart, 1),
              _buildNavItem(kLiveChatIcon, AppLocalizations.of(context)!.liveChat, 2),
              _buildNavItem(kProfileIcon, AppLocalizations.of(context)!.profile, 3),
            ],
          ),
        ),
        body: screenWidgets[currentIndex],
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    /// Active and Inactive colors
    Color iconColor = currentIndex == index ? kSecondaryColor : Colors.black;
    Color labelColor = currentIndex == index ? kSecondaryColor : Colors.black;

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        MainAxisAlignment alignment = MainAxisAlignment.center;
        if (snapshot.data != null) {
          var prefs = snapshot.data;
          alignment = prefs?.getString('language_code') == "my" ? MainAxisAlignment.start : MainAxisAlignment.center;
        }

        return Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Column(
              mainAxisAlignment: alignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgImageView(
                  imageName: icon,
                  imageHeight: 20,
                  imageWidth: 20,
                  iconColor: iconColor,
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: currentIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
