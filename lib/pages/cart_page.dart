import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Cart'),
        bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Cart'),
                  Text(
                    'Manage',
                    style: TextStyle(color: kPrimaryColor),
                  )
                ],
              ),
            )),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const CartListItemView();
          }),
    );
  }
}
