import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class CartListItemView extends StatelessWidget {
  const CartListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 150,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Icon(
              Icons.check_box_outlined,
              color: kPrimaryColor,
              size: 20,
            ),
          ),
          const SizedBox(
            width: kMargin30,
          ),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Name',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: kMargin10,
                ),
                Row(
                  children: [
                    const Text(
                      'Hair Care',
                      style: TextStyle(
                          color: kTpinTextColor, fontSize: kTextSmall),
                    ),
                    const SizedBox(width: kMargin6 + 1,),
                    Container(
                      color: kCartColor.withOpacity(0.4),
                      height: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Center(
                        child: Text(
                          'Color Family: White',
                          style: TextStyle(fontSize: kTextSmall),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: kMargin10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      'Ks 100000.00',
                      style: TextStyle(fontSize: kTextRegular2x),
                    ),
                    SizedBox(width: kMargin30,),
                    Text(
                      '100 pt',
                      style:
                          TextStyle(color: kPrimaryColor, fontSize: kTextSmall),
                    )
                  ],
                ),
                const SizedBox(
                  height: kMargin10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.remove_circle,
                          color: kCartColor,
                        )),
                    const Text('1'),
                    TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.add_circle,
                          color: kCartColor,
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
