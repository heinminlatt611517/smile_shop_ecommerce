import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/change_password_bloc.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/input_view_lock_icon.dart';
import '../widgets/loading_view.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<ChangePasswordBloc, bool>(
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

                      ///type old password
                      Consumer<ChangePasswordBloc>(
                        builder: (context, bloc, child) => InputViewLockIcon(
                            toggleObscured: () {
                              bloc.onTapShowOldPassword();
                            },
                            isSecure: bloc.isShowOldPassword,
                            hintLabel: 'Type your old password',
                            onChangeValue: (value) {
                              bloc.onPasswordChanged(value);
                            }),
                      ),

                      const SizedBox(
                        height: kMargin34,
                      ),

                      ///type new password view
                      Consumer<ChangePasswordBloc>(
                        builder: (context, bloc, child) => InputViewLockIcon(
                            toggleObscured: () {
                              bloc.onTapShowNewPassword();
                            },
                            isSecure: bloc.isShowNewPassword,
                            hintLabel: 'Type your new password',
                            onChangeValue: (value) {
                              bloc.onPasswordChanged(value);
                            }),
                      ),

                      const SizedBox(
                        height: kMargin34,
                      ),

                      ///retype new password view
                      Consumer<ChangePasswordBloc>(
                        builder: (context, bloc, child) => InputViewLockIcon(
                            toggleObscured: () {
                              bloc.onTapShowRetypePassword();
                            },
                            isSecure: bloc.isShowRetypePassword,
                            hintLabel: 'Re-type your new password',
                            onChangeValue: (value) {
                              bloc.onPasswordChanged(value);
                            }),
                      ),

                      const SizedBox(
                        height: 60,
                      ),

                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: kBackgroundColor),
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
