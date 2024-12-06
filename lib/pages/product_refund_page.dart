import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/pages/refund_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

class ProductRefundPage extends StatelessWidget {
  const ProductRefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Product Refund'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You need to send your refund item to our address.',
                style: TextStyle(fontSize: kTextRegular),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: kFillingFastColor,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Smile Shop',
                              style: TextStyle(fontSize: kTextRegular),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                '09888888888',
                                style: TextStyle(fontSize: kTextRegular),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'No 34, Baho Road, Hlaing Township',
                          style: TextStyle(fontSize: kTextRegular),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const MyOrderListItemView(
                isRefundView: true,
              ),
              const SizedBox(
                height: 20,
              ),
              //drop down
              const RefundDropDown(),

              // upload photo
              const SizedBox(
                height: 20,
              ),
              const UploadPhotoView(),

              const SizedBox(
                height: 50,
              ),
              //button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const RefundPage()));
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: kBackgroundColor),
                    ),
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

class RefundDropDown extends StatefulWidget {
  const RefundDropDown({super.key});

  @override
  @override
  State<RefundDropDown> createState() => _RefundDropDownState();
}

class _RefundDropDownState extends State<RefundDropDown> {
  String? _selectedValue; // Selected value, initially null.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose refund reason',style: TextStyle(fontSize: kTextRegular2x),),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kHintSearchLocationColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            underline: const SizedBox.shrink(),
            value: _selectedValue,
            isExpanded: true,
            hint: const Text('Choose One'),
            items: <String>['Option 1', 'Option 2', 'Option 3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}

class UploadPhotoView extends StatefulWidget {
  const UploadPhotoView({super.key});

  @override
  State<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Photo'),
        const SizedBox(
          height: 20,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Image.asset(kPhotoFrameImage),
            ),
            const Icon(Icons.add)
          ],
        )
      ],
    );
  }
}
