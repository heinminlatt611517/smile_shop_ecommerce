import 'package:flutter/material.dart';
import 'package:smile_shop/pages/edit_profile_page.dart';
import 'package:smile_shop/pages/smile_point_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 185,
        backgroundColor: kSecondaryColor,
        excludeHeaderSemantics: true,
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const SmilePointPage()));
                  },
                  child: _buildProfileItem(context, title: 'To Pay')),
                _buildProfileItem(context, title: 'To Ship'),
                _buildProfileItem(context, title: 'To Receive'),
                _buildProfileItem(context, title: 'To Review'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfileItem(context, title: 'To Pay'),
                _buildProfileItem(context, title: 'To Ship'),
                _buildProfileItem(context, title: 'To Receive'),
                _buildProfileItem(context, title: 'To Review'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfileItem(context, title: 'To Pay'),
                _buildProfileItem(context, title: 'To Ship'),
                _buildProfileItem(context, title: 'To Receive'),
                _buildProfileItem(context, title: 'To Review'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfileItem(context, title: 'To Pay'),
                _buildProfileItem(context, title: 'To Ship'),
                _buildProfileItem(context, title: 'To Receive'),
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
    width: MediaQuery.of(context).size.width * 0.2,
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
          style: const TextStyle(fontSize: kTextSmall),
        )
      ],
    ),
  );
}
