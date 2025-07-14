import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/order_bloc.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/order_detail_page.dart';
import 'package:smile_shop/pages/payment_method_page.dart';
import 'package:smile_shop/pages/product_refund_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../utils/images.dart';
import '../widgets/loading_view.dart';
import '../widgets/svg_image_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key, this.tabIndex});

  final int? tabIndex;

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    print("TAB INDEX ===========> ${widget.tabIndex}");
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.animateTo(widget.tabIndex ?? 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> myOrderTabBarDummyData = [
      AppLocalizations.of(context)?.all ?? '',
      AppLocalizations.of(context)?.inWareHouse ?? '',
      AppLocalizations.of(context)?.onGoing ?? '',
      AppLocalizations.of(context)?.delivered ?? '',
      AppLocalizations.of(context)?.failed ?? '',
    ];
    return ChangeNotifierProvider(
      create: (context) => OrderBloc(widget.tabIndex ?? 0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SvgImageView(
                  imageName: kBackSvgIcon,
                  imageHeight: 26,
                  imageWidth: 26,
                ),
              ),
              const Spacer(),
              Text(
                AppLocalizations.of(context)?.myOrders ?? '',
                style: const TextStyle(
                    fontSize: kTextRegular3x,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Text(''),
            ],
          ),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: Consumer<OrderBloc>(
                builder: (context, bloc, child) => TabBar(
                    labelColor: kFillingFastColor,
                    // physics: const NeverScrollableScrollPhysics(),
                    dividerColor: Colors.transparent,
                    indicatorColor: kFillingFastColor,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.all(13),
                    indicatorPadding: const EdgeInsets.only(bottom: 5),
                    tabAlignment: TabAlignment.center,
                    controller: _tabController,
                    onTap: (index) {
                      if (index == 0) {
                        bloc.getAllOrder();
                      }
                      if (index == 1) {
                        bloc.getOrdersByType(kTypeInWarehouse);
                      }
                      // if (index == 2) {
                      //   bloc.getOrdersByType(kTypeToShip);
                      // }
                      if (index == 2) {
                        bloc.getOrdersByType(kTypeStartDeliver);
                      }
                      if (index == 3) {
                        bloc.getOrdersByType(kTypeDelivered);
                      }
                      if (index == 4) {
                        bloc.getOrdersByType(kTypeFailed);
                      }
                    },
                    tabs: myOrderTabBarDummyData.map((value) {
                      return Text(value.toTitleCase);
                    }).toList()),
              )),
        ),
        body: Selector<OrderBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Selector<OrderBloc, List<OrderVO>>(
                selector: (context, bloc) => bloc.orders,
                builder: (context, orders, child) => orders.isEmpty
                    ? const Center(
                        child: Text(''),
                      )
                    : TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                            _myOrderView(orders),
                            _myOrderView(orders),
                            _myOrderView(orders),
                            _myOrderView(orders),
                            _myOrderView(orders),
                          ]),
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

  Widget _myOrderView(List<OrderVO> orderList) {
    print("LENGTH ===========> ${orderList.length}");
    return Selector<OrderBloc, bool>(
      selector: (_, bloc) => bloc.isLoading,
      builder: (_, isLoading, child) => Container(
        color: kBackgroundColor,
        child: ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              print("Index ===========> $index");
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => OrderDetailPage(
                            // orderStatus: orderList[index].paymentStatus ?? "",
                            orderNumber: orderList[index].orderNo ?? '',
                            // deliveryHistory: orderList[index].deliveryHistory ?? [],
                          )));

                  // if (orderList[index].paymentStatus != "not_pay") {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (_) => OrderDetailPage(
                  //             orderStatus: orderList[index].paymentStatus ?? "",
                  //             orderNumber: orderList[index].orderNo ?? '',
                  //             deliveryHistory: orderList[index].deliveryHistory ?? [],
                  //           )));
                  // }
                },
                child: MyOrderListItemView(
                  orderVO: orderList[index],
                  isRefundView: false,
                  onTapPayment: (orderId, subTotal) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => PaymentMethodPage(
                              isFromMyOrderPage: true,
                              orderSubTotal: subTotal.toString(),
                              orderNumber: orderList[index].orderNo ?? '',
                              deliveryType:
                                  orderList[index].deliveryType ?? 'delivery',
                              addressId: orderList[index].addressVO?.id ?? 0,
                            )));
                  },
                  onTapCancel: (String orderId) {
                    var bloc = context.read<OrderBloc>();
                    bloc.onTapCancelOrder(orderId);
                  },
                  onTapRefund: (orderNo) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => ProductRefundPage(
                              orderVO: orderNo,
                            )));
                  },
                ),
              );
            }),
      ),
    );
  }
}
