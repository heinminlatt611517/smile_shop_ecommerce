import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/my_address_bloc.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/list_items/address_list_item_view.dart';
import 'package:smile_shop/pages/edit_address_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../widgets/loading_view.dart';
import 'add_new_address_page.dart';

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAddressBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: const CustomAppBarView(title: 'My Address'),
        body: Selector<MyAddressBloc, bool>(
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

                      ///add address view
                      InkWell(
                        onTap: () async {
                          final bool? isUpdated =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => const AddNewAddressPage(),
                            ),
                          );
                          if (isUpdated == true) {
                            context.read<MyAddressBloc>().refreshAddress();
                          }
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor, width: 1),
                            borderRadius: BorderRadius.circular(kMarginMedium2),
                          ),
                          child: const Center(
                            child: Text(
                              '+ Add Address',
                              style: TextStyle(fontSize: kTextRegular2x),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 13,
                      ),

                      ///address list item view
                      Selector<MyAddressBloc, List<AddressVO>>(
                        selector: (context, bloc) => bloc.addressList,
                        builder: (context, addressList, child) =>
                            ListView.separated(
                          itemCount: addressList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context,
                                    '${addressList[index].townshipVO?.name},${addressList[index].stateVO?.name}');
                              },
                              child: AddressListItemView(
                                  addressVO: addressList[index],
                                  onTapEdit: () async {
                                    final bool? isUpdated =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) => EditAddressPage(
                                          addressVO: addressList[index],
                                        ),
                                      ),
                                    );
                                    if (isUpdated == true) {
                                      context
                                          .read<MyAddressBloc>()
                                          .refreshAddress();
                                    }
                                  }),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///loading view
              if (isLoading)
                Container(
                  color: kBackgroundColor,
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
