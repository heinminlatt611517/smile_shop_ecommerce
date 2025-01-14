import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/profile_bloc.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/edit_profile_page.dart';
import 'package:smile_shop/pages/login_page.dart';
import 'package:smile_shop/pages/my_address_page.dart';
import 'package:smile_shop/pages/my_favourite_page.dart';
import 'package:smile_shop/pages/my_order_page.dart';
import 'package:smile_shop/pages/my_team_page.dart';
import 'package:smile_shop/pages/packages_page.dart';
import 'package:smile_shop/pages/referral_code_page.dart';
import 'package:smile_shop/pages/refund_page.dart';
import 'package:smile_shop/pages/smile_point_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/common_dialog.dart';
import 'package:smile_shop/widgets/logout_dialog_view.dart';
import 'package:smile_shop/widgets/svg_image_view.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../widgets/loading_view.dart';
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
      create: (BuildContext context) => ProfileBloc(context),
      child: Selector<ProfileBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            ///body view
            Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                toolbarHeight: 185,
                elevation: 0,
                backgroundColor: kSecondaryColor,
                automaticallyImplyLeading: false,
                title: Selector<ProfileBloc, UserVO?>(
                  selector: (context, bloc) => bloc.userProfile,
                  builder: (_, user, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            imageUrl: user?.profileImage ?? errorImageUrl),
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
                            onTap: () async {
                              final bool? isUpdated =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (builder) => EditProfilePage(
                                          userVo: user,
                                        )),
                              );
                              if (isUpdated == true) {
                                context.read<ProfileBloc>().getProfile(context);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: kMargin40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('My Orders'),
                    const SizedBox(
                      height: 15,
                    ),
                    GridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 0,

                      /// Vertical spacing between items
                      crossAxisSpacing: 10,

                      /// Horizontal spacing between items
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _buildProfileItems(context),
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

  ///build profile item
  _buildProfileItems(BuildContext context) {
    List<Widget> items = [];

    items.add(InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MyOrderPage(tabIndex: 1)));
      },
      child: _buildProfileItem(context,
          title: 'To Pay', assetImagePath: kToPayIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MyOrderPage(tabIndex: 2)));
      },
      child: _buildProfileItem(context,
          title: 'To Ship', assetImagePath: kToShipIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MyOrderPage(tabIndex: 3)));
      },
      child: _buildProfileItem(context,
          title: 'To Receive', assetImagePath: kToReceiveIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MyOrderPage(tabIndex: 4)));
      },
      child: _buildProfileItem(context,
          title: 'To Review', assetImagePath: kToReviewIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const RefundPage()));
      },
      child: _buildProfileItem(context,
          title: 'Refund', assetImagePath: kRefundIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SmilePointPage()));
      },
      child: _buildProfileItem(context,
          title: 'Smile Wallet', assetImagePath: kSmileIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PromotionPointPage()));
      },
      child: _buildProfileItem(context,
          title: 'Promotion Point', assetImagePath: kPointIcon),
    ));

    if (GetStorage().read(kBoxKeyLoginUserType) == kTypeDealer) {
      items.add(InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const PackagePage()));
        },
        child: _buildProfileItem(context,
            title: 'Package', assetImagePath: kPackageIcon),
      ));
    }

    items.add(InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const MyFavouritePage()));
      },
      child: _buildProfileItem(context,
          title: 'My Favourite', assetImagePath: kFavouriteIcon),
    ));

    items.add(_buildProfileItem(context,
        title: 'Language', assetImagePath: kLanguageIcon));

    if (GetStorage().read(kBoxKeyLoginUserType) == kTypeEndUser) {
      items.add(InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const MyTeamPage()));
        },
        child: _buildProfileItem(context,
            title: 'My Team', assetImagePath: kMyTeamIcon),
      ));
    }

    items.add(InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const MyAddressPage()));
      },
      child: _buildProfileItem(context,
          title: 'Address', assetImagePath: kAddressIcon),
    ));

    items.add(InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const ReferralCodePage()));
      },
      child: _buildProfileItem(context,
          title: 'Referral Code', assetImagePath: kReferralIcon),
    ));

    items.add(_buildProfileItem(context,
        title: 'About Us', assetImagePath: kAboutUsIcon));

    items.add(_buildProfileItem(context,
        title: 'Contact Us', assetImagePath: kContactUsIcon));

    items.add(InkWell(
      onTap: (){
        showCommonDialog(context: context,dialogWidget: LogoutDialogView(onLogout: (){
          _model.clearSaveLoginData();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (builder) => const LoginPage()),
                  (Route<dynamic> route) => false);
        }));
      },
      child: _buildProfileItem(context,
          title: 'Log Out', assetImagePath: kLogoutIcon),
    ));

    items.add(_buildProfileItem(context,
        title: 'Delete Account', assetImagePath: kDeleteIcon));

    return items;
  }
}

Widget _buildProfileItem(BuildContext context,
    {required String title, required String assetImagePath}) {
  double itemWidth = (MediaQuery.of(context).size.width - 30) / 4;
  return SizedBox(
    width: itemWidth,
    child: Column(
      children: [
        SvgImageView(imageName: assetImagePath,
          imageHeight: 20,
          imageWidth: 20,
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
