import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/edit_profile_bloc.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/change_password_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/localization/app_localizations.dart';

import '../utils/dimens.dart';
import '../widgets/loading_view.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key, this.userVo});

  final UserVO? userVo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileBloc(userVo),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
        ),
        body: Selector<EditProfileBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              ///body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Selector<EditProfileBloc, File?>(
                  selector: (_, bloc) => bloc.imgFile,
                  builder: (_, imgFile, child) => Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          imgFile == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                      imageUrl: userVo?.profileImage == ''
                                          ? errorImageUrl
                                          : userVo?.profileImage ??
                                              errorImageUrl),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(
                                    height: 60,
                                    width: 60,
                                    imgFile,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<EditProfileBloc>(
                            builder: (_, bloc, child) => InkWell(
                              onTap: () => bloc.uploadImage(),
                              child: Container(
                                height: 18,
                                width: 96,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.changePhoto,
                                    style:
                                        const TextStyle(fontSize: kTextSmall),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<EditProfileBloc>(
                        builder: (context, bloc, child) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: changeNameBottomSheetView(
                                          context, bloc),
                                    ));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.name,
                                    ),
                                    Row(
                                      children: [
                                        Consumer<EditProfileBloc>(
                                            builder: (context, bloc, child) =>
                                                Text(bloc.profileVO?.name ??
                                                    '')),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(Icons.chevron_right)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.phoneNumber,
                                ),
                                Row(
                                  children: [
                                    Text(userVo?.phone ?? ''),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const ChangePasswordPage()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .changePassword,
                                  ),
                                  const Row(
                                    children: [
                                      Text(''),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.chevron_right)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider()
                        ],
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
      ),
    );
  }

  ///bottom sheet view
  Container changeNameBottomSheetView(
    BuildContext context,
    EditProfileBloc bloc,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(kMarginMedium2),
      ),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.fullName,
                style: const TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: kMarginMedium2),
            child: Text(
              AppLocalizations.of(context)!.firstAndLastName,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: kTextSmall),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 40,
            child: TextField(
              controller: bloc.nameController,
              cursorColor: kPrimaryColor,
              style: const TextStyle(fontSize: kTextRegular),
              onChanged: (value) {
                bloc.onChangedName(value);
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.pleaseEnterYourName,
                hintStyle: const TextStyle(fontSize: kTextRegular),
                contentPadding: const EdgeInsets.only(left: kMarginMedium2),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          bloc.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.amber))
              : GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    bloc.onTapConfirm().then((response) {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: const TextStyle(color: kBackgroundColor),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
