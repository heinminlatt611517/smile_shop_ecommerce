import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/password_bloc.dart';
import 'package:smile_shop/pages/login_page.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

import '../data/dummy_data/country_code.dart';
import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/input_view_lock_icon.dart';
import '../widgets/loading_view.dart';

class PasswordPage extends StatefulWidget {
  final String? requestId;
  final String? phone;
  const PasswordPage({super.key,required this.requestId,required this.phone});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  CountryCode selectedCountry = countries.first;
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PasswordBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<PasswordBloc,bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) =>
           Stack(
             children: [
               SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 116,),
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
                      const SizedBox(
                        height: kMargin30,
                      ),
                      ///set your password view
                      Consumer<PasswordBloc>(
                        builder: (context,bloc,child) =>
                            InputViewLockIcon(
                                hintLabel: 'Set your password',
                                onChangeValue: (value){
                                  bloc.onPasswordChanged(value);
                                }),
                      ),
                      const SizedBox(
                        height: kMargin34,
                      ),

                      ///retype your password view
                      Consumer<PasswordBloc>(
                        builder: (context,bloc,child) =>
                            InputViewLockIcon(
                                hintLabel: 'Retype your password',
                                onChangeValue: (value){
                                  bloc.onConfirmPasswordChanged(value);
                                }),
                      ),
                      const SizedBox(
                        height: kMargin34,
                      ),

                      ///confirm button
                      GestureDetector(
                        onTap: () {
                          var bloc =
                          Provider.of<PasswordBloc>(context, listen: false);

                          bloc.onTapConfirm(widget.requestId??"", widget.phone??"").then((value) {
                            if (value.statusCode == 200) {
                              bloc.crateFirebaseChatUser(id: value.data?.id ?? 0,name: value.data?.name ?? "",phone: value.data?.phone ?? "");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (builder) => const LoginPage()),(Route<dynamic> route) => false);
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
                          child: const Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: kBackgroundColor),
                            ),
                          ),
                        ),
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
