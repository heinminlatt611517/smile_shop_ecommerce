import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_dialog.dart';
import 'package:smile_shop/widgets/error_dialog_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/forgot_password_bloc.dart';
import '../widgets/loading_view.dart';
import '../widgets/phone_input_textfield.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<ForgotPasswordBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 110,
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
                        height: 80,
                      ),

                      Consumer<ForgotPasswordBloc>(
                        builder: (context, bloc, child) => normalPhoneTextField(
                            controller: phoneController,
                            hint: AppLocalizations.of(context)!.enterPhoneNumber,
                            context: context,
                            onChangeTextField: (v) {
                              bloc.onPhoneNumberChanged(v);
                            },
                            onChanged: (val) {
                            }, phoneCode: ''),
                      ),

                      const SizedBox(
                        height: kMargin34,
                      ),


                      GestureDetector(
                        onTap: () {
                          var bloc =
                              Provider.of<ForgotPasswordBloc>(context, listen: false);

                          bloc.onTapNext().then((value){
                            if (value.status == 200) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => OtpPage(
                                      requestId:
                                      value.data?.requestId.toString(),
                                      phone: value.data?.to,
                                      referralCode:value.data?.referralCode,
                                      isFromForgotPasswordPage: true,)));
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
                          child:  Center(
                            child: Text(
                             AppLocalizations.of(context)!.next,
                              style:const TextStyle(color: kBackgroundColor),
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
