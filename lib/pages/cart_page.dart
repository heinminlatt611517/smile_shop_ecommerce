import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/pages/checkout_page.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const CartListItemView(
              isCheckout: false,
            );
          }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: kCartColor)),
                  child: const Icon(
                    Icons.check,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Select All'),
              ],
            ),
            const Row(
              children: [
                Text('Total: '),
                Text(
                  'Ks 30000',
                  style: TextStyle(color: kFillingFastColor),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const CheckoutPage()));
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: kFillingFastColor,
                    borderRadius: BorderRadius.circular(4)),
                child: const Text(
                  'Check Out (1)',
                  style: TextStyle(color: kBackgroundColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
