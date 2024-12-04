import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';

class RefundListItemView extends StatelessWidget {
  const RefundListItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            // height: 24,
            padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kFillingFastColor)),
            child: const Center(
              child: Row(
                children: [
                  Icon(Icons.payment,size: 20,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      'Your payment has been done at Nov 30.',
                      style: TextStyle(fontSize: kTextSmall),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 7,),
          const Row(
            children: [
              Spacer(),
              Text(
                'Pending',
                style: TextStyle(color: kFillingFastColor),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const CachedNetworkImageView(
                    imageHeight: 80,
                    imageWidth: 80,
                    imageUrl:
                        'https://media.istockphoto.com/id/1311107708/photo/focused-cute-stylish-african-american-female-student-with-afro-dreadlocks-studying-remotely.jpg?s=612x612&w=0&k=20&c=OwxBza5YzLWkE_2abTKqLLW4hwhmM2PW9BotzOMMS5w='),
              ),
              const SizedBox(
                width: kMarginMedium3,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Name',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: kMargin10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Ks 100000.00',
                          style: TextStyle(fontSize: kTextRegular2x),
                        ),
                        SizedBox(
                          width: kMargin30,
                        ),
                        Text(
                          'Qty: 1',
                          style: TextStyle(fontSize: kTextSmall),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    const Row(
                      children: [
                        Spacer(),
                        Text(
                          'Total(1 item): Ks 3,500',
                          style: TextStyle(fontSize: kTextSmall),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
