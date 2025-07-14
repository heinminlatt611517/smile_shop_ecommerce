import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/login_bloc.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_dialog.dart';
import 'package:smile_shop/widgets/error_dialog_view.dart';
import 'package:smile_shop/widgets/input_view_lock_icon.dart';

import '../utils/strings.dart';
import '../widgets/loading_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class DealerLoginPage extends StatefulWidget {
  const DealerLoginPage({super.key});

  @override
  State<DealerLoginPage> createState() => _DealerLoginPageState();
}

class _DealerLoginPageState extends State<DealerLoginPage> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogInBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<LogInBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 116,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          kAppLogoImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 58,
                      ),

                      ///email input view
                      Consumer<LogInBloc>(
                        builder: (context, bloc, child) => InputViewLockIcon(
                            isSecure: true,
                            hintLabel: AppLocalizations.of(context)!
                                .typeYourEmailAddress,
                            isMailIcon: true,
                            onChangeValue: (value) {
                              bloc.onChangedEmail(value);
                            }),
                      ),

                      const SizedBox(
                        height: kMargin34,
                      ),

                      ///password input view
                      Consumer<LogInBloc>(
                        builder: (context, bloc, child) => InputViewLockIcon(
                            hintLabel:
                                AppLocalizations.of(context)!.typeYourPassword,
                            toggleObscured: () {
                              bloc.onTapShowPassword();
                            },
                            isSecure: bloc.isShowPassword,
                            onChangeValue: (value) {
                              bloc.onPasswordChanged(value);
                            }),
                      ),

                      const SizedBox(
                        height: 60,
                      ),

                      GestureDetector(
                        onTap: () {
                          var bloc =
                              Provider.of<LogInBloc>(context, listen: false);

                          bloc.onTapDealerSign().then((value) {
                            if (value.statusCode == 200) {
                              GetStorage()
                                  .write(kBoxKeyLoginUserType, kTypeDealer);
                              GetStorage().write(kBoxKeyPromotionPoint,
                                  value.data?.data?.promotionPoints ?? 0);
                              bloc.crateFirebaseChatUser(
                                  id: value.data?.data?.id ?? 0,
                                  name: value.data?.data?.name ?? "",
                                  phone: value.data?.data?.phone ?? "");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (builder) => const MainPage()),
                                  (Route<dynamic> route) => false);
                            }
                          }).catchError((error) {
                            showCommonDialog(
                                context: context,
                                dialogWidget: ErrorDialogView(
                                    errorMessage: error.toString()));
                          });
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(color: kBackgroundColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMargin30,
                      ),
                    ],
                  ),
                ),
              )),

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
}
