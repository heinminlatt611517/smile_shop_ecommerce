import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/pages/order_detail_page.dart';
import 'package:smile_shop/utils/colors.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('My Orders'),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: TabBar(
                labelColor: kFillingFastColor,
                dividerColor: Colors.transparent,
                indicatorColor: kFillingFastColor,
                isScrollable: true,
                labelPadding: const EdgeInsets.all(13),
                indicatorPadding: const EdgeInsets.only(bottom: 5),
                tabAlignment: TabAlignment.center,
                controller: _tabController,
                tabs: const [
                  Text('All'),
                  Text('To Pay'),
                  Text('To Ship'),
                  Text('To Receive'),
                  Text('To Review'),
                ])),
      ),
      body: TabBarView(controller: _tabController, children: [
        _myOrderView(),
        _myOrderView(),
        _myOrderView(),
        _myOrderView(),
        _myOrderView(),
      ]),
    );
  }

  Widget _myOrderView() {
    return Container(
      color: kBackgroundColor,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const OrderDetailPage()));
              },
              child: const MyOrderListItemView(
                isRefundView: false,
              ),
            );
          }),
    );
  }
}
