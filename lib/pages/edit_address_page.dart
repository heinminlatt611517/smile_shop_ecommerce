import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/edit_address_bloc.dart';
import 'package:smile_shop/blocs/my_address_bloc.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/township_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/widgets/dynamic_drop_down_widget.dart';
import 'package:smile_shop/widgets/textfiled_with_label_input_view.dart';

import '../blocs/address_category_bloc.dart';
import '../data/vos/category_vo.dart';
import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';

class EditAddressPage extends StatelessWidget {
  final AddressVO? addressVO;

  const EditAddressPage({super.key, this.addressVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditAddressBloc(addressVO),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar:const CustomAppBarView(title: 'Edit My Address'),
        body: Selector<EditAddressBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              ///body view
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kMarginMedium2),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 13,
                      ),

                      ///address category view
                      AddressCategoryView(
                        addressVO: addressVO,
                      ),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///name and phone number input view
                      NameAndPhoneInputView(
                        phone: addressVO?.phone ?? "",
                        name: addressVO?.address ?? "",
                      ),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///state and township dropdown map view
                      StateTownshipAndMapDropdownView(
                        stateVO: addressVO?.stateVO,
                        townshipVO: addressVO?.townshipVO,
                      ),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///checkbox view
                      Selector<EditAddressBloc, bool>(
                        selector: (context, bloc) => bloc.isChecked,
                        builder: (context, isChecked, child) => Row(
                          children: [
                            Consumer<EditAddressBloc>(
                              builder: (context, bloc, child) => Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: bloc.isChecked,
                                checkColor: Colors.white,
                                activeColor: kPrimaryColor,
                                onChanged: (v) {
                                  var bloc = Provider.of<EditAddressBloc>(
                                      context,
                                      listen: false);
                                  bloc.onCheckChange();
                                },
                              ),
                            ),
                            const Text(
                              'Set as default address',
                              style: TextStyle(
                                  fontSize: kTextRegular, color: Colors.black),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///delete button
                      Consumer<EditAddressBloc>(
                        builder: (context, bloc, child) => CommonButtonView(
                            label: 'Delete Address',
                            isShowBorder: true,
                            labelColor: Colors.black,
                            bgColor: Colors.transparent,
                            onTapButton: () {
                              bloc
                                  .onTapDeleteAddress(addressVO?.id ?? 0)
                                  .then((value) {
                                Navigator.pop(context, true);
                              }).catchError((error) {
                                showCommonDialog(
                                    context: context,
                                    dialogWidget: ErrorDialogView(
                                        errorMessage: error.toString()));
                              });
                            }),
                      ),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///save button
                      Consumer<EditAddressBloc>(
                        builder: (context, bloc, child) => CommonButtonView(
                            label: 'Save',
                            labelColor: Colors.white,
                            bgColor: kPrimaryColor,
                            onTapButton: () {
                              bloc.onTapSave(addressVO?.id ?? 0).then((value) {
                                Navigator.pop(context, true);
                              }).catchError((error) {
                                showCommonDialog(
                                    context: context,
                                    dialogWidget: ErrorDialogView(
                                        errorMessage: error.toString()));
                              });
                            }),
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
}

///address category view
class AddressCategoryView extends StatelessWidget {
  final AddressVO? addressVO;

  const AddressCategoryView({super.key, required this.addressVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddressCategoryBloc(addressVO?.categoryId ?? 0),
      child: Row(
        children: [
          const Text(
            'Address Category',
            style: TextStyle(fontSize: kTextRegular2x),
          ),
          const SizedBox(
            width: kMarginMedium2,
          ),
          SizedBox(
            height: 30,
            child: Selector<AddressCategoryBloc, List<CategoryVO>>(
              selector: (context, bloc) => bloc.addressCategories,
              builder: (context, addressCategories, child) =>
                  Consumer<AddressCategoryBloc>(
                builder: (context, bloc, child) => ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: addressCategories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = bloc.isSelected(index);

                    return Padding(
                      padding: const EdgeInsets.only(right: kMarginMedium),
                      child: InkWell(
                        onTap: () {
                          bloc.toggleSelectionAddressCategory(index);
                          var addNewAddressBloc = Provider.of<EditAddressBloc>(
                              context,
                              listen: false);
                          addNewAddressBloc.onTapAddressCategory(
                              addressCategories[index].id ?? 0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:
                                isSelected ? kPrimaryColor : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : kPrimaryColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kMarginMedium),
                              child: Text(
                                addressCategories[index].name ?? "",
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : kPrimaryColor,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///name and phone number input view
class NameAndPhoneInputView extends StatelessWidget {
  final String name;
  final String phone;

  const NameAndPhoneInputView(
      {super.key, required this.phone, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMarginLarge),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginMedium),
          color: Colors.grey.withOpacity(0.3)),
      child: Column(
        children: [
          Consumer<EditAddressBloc>(
            builder: (context, bloc, child) => TextFieldWithLabelInputView(
                hint: name,
                label: 'Name',
                onChanged: (value) {
                  bloc.onNameChanged(value);
                }),
          ),
          const SizedBox(
            height: kMarginLarge,
          ),
          Consumer<EditAddressBloc>(
            builder: (context, bloc, child) => TextFieldWithLabelInputView(
                hint: phone,
                label: 'Phone',
                onChanged: (value) {
                  bloc.onPhoneNumberChanged(value);
                }),
          )
        ],
      ),
    );
  }
}

///state and township dropdown map view
class StateTownshipAndMapDropdownView extends StatelessWidget {
  final StateVO? stateVO;
  final TownshipVO? townshipVO;

  const StateTownshipAndMapDropdownView(
      {super.key, required this.stateVO, required this.townshipVO});

  @override
  Widget build(BuildContext context) {
    debugPrint("TownshipID>>>>>>>>${townshipVO?.id}");
    return Container(
      padding: const EdgeInsets.all(kMarginLarge),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginMedium),
          color: Colors.grey.withOpacity(0.3)),
      child: Column(
        children: [
          ///state dropdown
          Selector<EditAddressBloc, List<StateVO>>(
              selector: (context, bloc) => bloc.states,
              builder: (context, states, child) {
                StateVO? foundState;

                if (states.isNotEmpty && stateVO != null) {
                  foundState = states.firstWhere(
                    (state) => state.id == stateVO!.id,
                    orElse: () => states.first,
                  );
                }

                foundState ??= states.isNotEmpty ? states.first : null;
                var bloc = Provider.of<EditAddressBloc>(context, listen: false);
                return DynamicDropDownWidget(
                    initValue: states.isEmpty ? null : foundState,
                    hintText: 'Select state',
                    label: 'State',
                    items: states,
                    onSelect: (value) {
                      bloc.onStateIdChanged(value.id);
                    });
              }),

          const SizedBox(
            height: kMarginLarge,
          ),

          ///township dropdown
          Selector<EditAddressBloc, bool>(
              selector: (context, bloc) => bloc.isTownshipLoading,
              builder: (context, isLoading, child) {
                if (isLoading) {
                  return DynamicDropDownWidget(
                      hintText: 'Select township',
                      label: 'Township',
                      items: [],
                      onSelect: (value) {});
                } else {
                  return Selector<EditAddressBloc, List<TownshipVO>>(
                      selector: (context, bloc) => bloc.townships,
                      builder: (context, townships, child) {
                        TownshipVO? foundTownship;
                        if (townships.isNotEmpty && townshipVO != null) {
                          foundTownship = townships.firstWhere(
                            (township) => township.id == townshipVO!.id,
                            orElse: () => townships.first,
                          );
                        }
                        foundTownship ??=
                            townships.isNotEmpty ? townshipVO : null;
                        var bloc = Provider.of<EditAddressBloc>(context,
                            listen: false);
                        return DynamicDropDownWidget(
                            initValue: townships.isEmpty ? null : foundTownship,
                            hintText: 'Select township',
                            label: 'Township',
                            items: townships,
                            onSelect: (value) {
                              bloc.onTownshipIdChanged(value.id);
                            });
                      });
                }
              }),

          const SizedBox(
            height: kMarginMedium,
          ),
        ],
      ),
    );
  }
}
