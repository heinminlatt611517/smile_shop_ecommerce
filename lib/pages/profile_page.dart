import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/profile_bloc.dart';
import 'package:smile_shop/data/vos/profile_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/edit_profile_page.dart';
import 'package:smile_shop/pages/login_page.dart';
import 'package:smile_shop/pages/my_favourite_page.dart';
import 'package:smile_shop/pages/my_order_page.dart';
import 'package:smile_shop/pages/packages_page.dart';
import 'package:smile_shop/pages/referral_code_page.dart';
import 'package:smile_shop/pages/smile_point_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../widgets/loading_view.dart';
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
    return ChangeNotifierProvider(
      create: (BuildContext context)=> ProfileBloc(),
      child: Selector<ProfileBloc,bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) =>
         Stack(
           children: [
             ///body view
             Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                toolbarHeight: 185,
                elevation: 0,
                backgroundColor: kSecondaryColor,
                automaticallyImplyLeading: false,
                title: Selector<ProfileBloc,ProfileVO?>(
                  selector: (context,bloc)=> bloc.userProfile,
                  builder: (_,user,child) =>
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            imageUrl: user?.profileImage ??
                                errorImageUrl),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user?.name ?? '',
                            style: const TextStyle(fontSize: kTextRegular2x),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async{
                              final bool? isUpdated = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (builder) => EditProfilePage(userVo: user,)
                                ),
                              );
                              if (isUpdated == true) {
                                context.read<ProfileBloc>().getProfile();
                              }
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
                      Text(
                        user?.phone ?? '',
                        style: const TextStyle(fontSize: kTextRegular2x),
                      ),
                    ],
                  ),
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
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const PackagePage()));
                            },
                            child: _buildProfileItem(context, title: 'Package')),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const MyFavouritePage()));
                            },
                            child: _buildProfileItem(context, title: 'My Favourite')),
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
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const ReferralCodePage()));
                          },
                            child: _buildProfileItem(context, title: 'Referal Code')),
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
                     ),

             ///loading view
             if (isLoading)
               Container(
                 color: Colors.black12,
                 child: const Center(
                   child: LoadingView(
                     indicatorColor: kPrimaryColor,
                     indicator: Indicator.ballSpinFadeLoader,
                   ),
                 ),
               ),
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
