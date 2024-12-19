import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/add_new_address_bloc.dart';
import 'package:smile_shop/blocs/address_category_bloc.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/township_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/dynamic_drop_down_widget.dart';
import 'package:smile_shop/widgets/textfiled_with_label_input_view.dart';

import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';

class AddNewAddressPage extends StatelessWidget {
  final int? addressId;
  const AddNewAddressPage({super.key,this.addressId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewAddressBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          surfaceTintColor: kBackgroundColor,
          centerTitle: true,
          title: const Text('Add New Address'),
        ),
        body: Selector<AddNewAddressBloc,bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) =>
            Stack(
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
                      const AddressCategoryView(),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///name and phone number input view
                      const NameAndPhoneInputView(),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///state and township dropdown map view
                      const StateTownshipAndMapDropdownView(),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///checkbox view
                      Selector<AddNewAddressBloc,bool>(
                        selector: (context , bloc ) => bloc.isChecked,
                        builder: (context,isChecked,child) =>
                         Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: isChecked,
                              checkColor: Colors.white,
                              activeColor: kPrimaryColor,
                              onChanged: (v) {
                                var bloc =
                                Provider.of<AddNewAddressBloc>(context, listen: false);
                                bloc.onCheckChange();
                              },
                            ),
                            const Text(
                              'Set as default address',
                              style:
                                  TextStyle(fontSize: kTextRegular, color: Colors.black),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: kMarginLarge,
                      ),

                      ///save button
                      Consumer<AddNewAddressBloc>(
                        builder: (context,bloc,child) =>
                         CommonButtonView(
                            label: 'Save',
                            labelColor: Colors.white,
                            bgColor: kPrimaryColor,
                            onTapButton: () {
                              bloc.onTapSave().then((value) {
                                  Navigator.pop(context);
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
  const AddressCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddressCategoryBloc(1),
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
            child: Selector<AddressCategoryBloc,List<CategoryVO>>(
              selector: (context , bloc ) => bloc.addressCategories,
              builder: (context,addressCategories,child) =>
               Consumer<AddressCategoryBloc>(
                 builder: (context,bloc,child) =>
                  ListView.builder(
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
                          var addNewAddressBloc =
                          Provider.of<AddNewAddressBloc>(context, listen: false);
                          addNewAddressBloc.onTapAddressCategory(addressCategories[index].id ?? 0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isSelected ? kPrimaryColor : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? Colors.transparent : kPrimaryColor,
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
                                  color: isSelected
                                      ? Colors.white
                                      : kPrimaryColor,
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
  const NameAndPhoneInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMarginLarge),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginMedium),
          color: Colors.grey.withOpacity(0.3)),
      child: Column(
        children: [
          Consumer<AddNewAddressBloc>(
            builder: (context,bloc,child) =>
             TextFieldWithLabelInputView(
                hint: 'Please enter your name',
                label: 'Name',
                onChanged: (value) {
                  bloc.onNameChanged(value);
                }),
          ),
          const SizedBox(
            height: kMarginLarge,
          ),
          Consumer<AddNewAddressBloc>(
            builder: (context,bloc,child) => TextFieldWithLabelInputView(
                hint: 'Please enter your phone number',
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
  const StateTownshipAndMapDropdownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMarginLarge),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMarginMedium),
          color: Colors.grey.withOpacity(0.3)),
      child: Column(
        children: [
          Selector<AddNewAddressBloc,List<StateVO>>(
            selector: (context , bloc ) => bloc.states,
            builder: (context,states,child) {
              var bloc =
              Provider.of<AddNewAddressBloc>(context, listen: false);
              return DynamicDropDownWidget(
                  hintText: 'Select state',
                  label: 'State', items: states, onSelect: (value) {
                    bloc.onStateIdChanged(value.id);
              });
            }
          ),

          const SizedBox(
            height: kMarginLarge,
          ),

          Selector<AddNewAddressBloc,bool>(
            selector: (context , bloc ) => bloc.isTownshipLoading,
            builder: (context,isLoading,child) {
              if (isLoading) {
                return DynamicDropDownWidget(
                    hintText: 'Select township',
                    label: 'Township', items: [], onSelect: (value) {
                });
              }
              else {
                return Selector<AddNewAddressBloc,List<TownshipVO>>(
                    selector: (context , bloc ) => bloc.townships,
                    builder: (context,townships,child) {
                      var bloc =
                      Provider.of<AddNewAddressBloc>(context, listen: false);
                      return DynamicDropDownWidget(
                          hintText: 'Select township',
                          label: 'Township', items: townships, onSelect: (value) {
                        bloc.onTownshipIdChanged(value.id);
                      });
                    }
                );
              }
            }

          ),

          const SizedBox(
            height: kMarginMedium,
          ),

          const Text(
            '(or)',
            style: TextStyle(color: Colors.black, fontSize: kTextRegular2x),
          ),

          const SizedBox(
            height: kMarginMedium,
          ),

          ///map view
          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child:const Icon(Icons.map),
          )
        ],
      ),
    );
  }
}