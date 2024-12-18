import 'package:flutter/material.dart';
import 'package:smile_shop/pages/edit_profile_page.dart';
import 'package:smile_shop/pages/login_page.dart';
import 'package:smile_shop/pages/my_order_page.dart';
import 'package:smile_shop/pages/smile_point_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import 'product_refund_page.dart';
import 'promotion_point_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ///Model
  final SmileShopModel _model = SmileShopModelImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 185,
        elevation: 0,
        backgroundColor: kSecondaryColor,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const CachedNetworkImageView(
                    imageHeight: 60,
                    imageWidth: 60,
                    imageUrl:
                        'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'John',
                  style: TextStyle(fontSize: kTextRegular2x),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const EditProfilePage()));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: kMTicketColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: kTextSmall),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '0988888888',
              style: TextStyle(fontSize: kTextRegular2x),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: kMargin40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Orders'),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MyOrderPage()));
                    },
                    child: _buildProfileItem(context, title: 'To Pay')),
                GestureDetector(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MyOrderPage()));
                    },
                  child: _buildProfileItem(context, title: 'To Ship')),
                GestureDetector(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MyOrderPage()));
                    },
                  child: _buildProfileItem(context, title: 'To Receive')),
                GestureDetector(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MyOrderPage()));
                    },
                  child: _buildProfileItem(context, title: 'To Review')),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ProductRefundPage()));
                    },
                  child: _buildProfileItem(context, title: 'Refund')),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SmilePointPage()));
                    },
                    child: _buildProfileItem(context, title: 'Smile Wallet')),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const PromotionPointPage()));
                    },
                    child:
                        _buildProfileItem(context, title: 'Promotion Point')),
                _buildProfileItem(context, title: 'Package'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfileItem(context, title: 'My Favourite'),
                _buildProfileItem(context, title: 'Language'),
                _buildProfileItem(context, title: 'My Team'),
                _buildProfileItem(context, title: 'Address'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfileItem(context, title: 'Referal Code'),
                _buildProfileItem(context, title: 'About Us'),
                _buildProfileItem(context, title: 'Contact Us'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  _model.clearSaveLoginData();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (builder) => const LoginPage()),(Route<dynamic> route) => false);
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: kBackgroundColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kPrimaryColor)),
                child: const Center(
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileItem(BuildContext context, {required String title}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.20,
    child: Column(
      children: [
        const Icon(
          Icons.payment,
          color: kPrimaryColor,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: kTextSmall),
        )
      ],
    ),
  );
}
