import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/otp_bloc.dart';
import 'package:smile_shop/pages/password_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/strings.dart';

import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';

class OtpPage extends StatefulWidget {
  final String? requestId;
  final String? phone;
  final String? referralCode;

  const OtpPage(
      {super.key,
      required this.requestId,
      required this.phone,
      required this.referralCode});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = kPrimaryColor;
    const fillColor = kPrimaryColor;
    const borderColor = kPrimaryColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: borderColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => OtpBloc(),
      child: Selector<OtpBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Check your phone',
                        style: TextStyle(
                            fontSize: kTextRegular3x,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: kMarginMedium3,
                      ),
                      const Text(
                        'We\'ve send the code to your phone.',
                        style: TextStyle(
                            fontSize: kTextRegular,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: kMargin40,
                      ),
                      Consumer<OtpBloc>(
                        builder: (context, bloc, child) => Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            controller: pinController,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) =>
                                const SizedBox(width: 30),
                            onClipboardFound: (value) {
                              debugPrint('onClipboardFound: $value');
                              pinController.setText(value);
                            },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              bloc.onCompletePinCode(pin);
                            },
                            onChanged: (value) {
                              bloc.onPinCodeChange(value);
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMarginMedium3,
                      ),
                      Consumer<OtpBloc>(
                        builder: (context, bloc, child) {
                          final minutes = (bloc.remainingSeconds / 60).floor();
                          final seconds = bloc.remainingSeconds % 60;
                          return Row(
                            children: [
                              const Spacer(),
                              Text(
                                'Code expired in ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: kTextRegular,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: kMargin30,
                      ),

                      ///on tap verify button
                      Consumer<OtpBloc>(
                        builder: (context, bloc, child) => GestureDetector(
                          onTap: () {
                            bloc
                                .onTapVerifyOtp(widget.requestId ?? "")
                                .then((value) {
                                  ///save referralCode to get storage
                              final box = GetStorage();
                              box.write(kBoxKeyReferralCode, widget.referralCode);

                              ///navigate to password page
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => PasswordPage(
                                        requestId: widget.requestId,
                                        phone: widget.phone,
                                      )));
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
                            child: const Center(
                              child: Text(
                                'Verify',
                                style: TextStyle(color: kBackgroundColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMarginMedium3,
                      ),

                      ///send again button
                      Consumer<OtpBloc>(
                        builder: (context, bloc, child) => GestureDetector(
                          onTap: bloc.isOtpExpired == false
                              ? null
                              : () {
                                  bloc
                                      .requestOtp(widget.phone ?? "",
                                          widget.referralCode ?? "")
                                      .then((value) {
                                    bloc.startCountdown();
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
                                color: bloc.isOtpExpired == false
                                    ? Colors.grey
                                    : Colors.transparent,
                                border: Border.all(
                                    color: bloc.isOtpExpired == false
                                        ? Colors.transparent
                                        : kPrimaryColor),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                'Send Again',
                                style: TextStyle(
                                    color: bloc.isOtpExpired == false
                                        ? Colors.white
                                        : kPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
