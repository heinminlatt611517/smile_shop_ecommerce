import 'package:flutter/material.dart';
import 'package:smile_shop/pages/my_team_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class CampaignDescriptionPage extends StatelessWidget {
  const CampaignDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const CustomAppBarView(
        title: '',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kMarginMedium2, vertical: kMarginMedium2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CachedNetworkImageView(
                  imageHeight: 200,
                  imageWidth: double.infinity,
                  imageUrl:
                      'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/page/category/g-series-15-5530-laptop-rf-800x620.psd?fmt=png-alpha&wid=800&hei=620'),
              const SizedBox(
                height: kMargin30,
              ),
              const Text(
                'Lenovo',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: kMargin30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kMargin25),
                height: 40,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Participants',
                      style: TextStyle(fontSize: kTextRegular),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kMargin30,
              ),
              const Text(
                'Description',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: kMarginMedium2,
              ),
              const Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using  making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).')
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(offset: Offset(5, 0), blurRadius: 10, color: Colors.grey)
        ]),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '240000000 Ks',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w500,color: kPrimaryColor),
              ),
              InkWell(
                onTap: () => showModalBottomSheet(
                    context: context, builder: (_) => _buildModalSheet(context)),
                child: Container(
                  width: 120,
                  height: 32,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(kMargin6 - 2)),
                  child: const Center(
                    child: Text(
                      'Join Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalSheet(BuildContext context) {
    return Container(
      height: 256,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kMarginMedium3),
            topRight: Radius.circular(kMarginMedium3)),
      ),
      child: Column(
        children: [
          Row(children: [
            const Spacer(),
            InkWell(
              onTap: ()=> Navigator.pop(context),
                child: const Padding(
                  padding:  EdgeInsets.only(top: kMarginMedium2,),
                  child:  Icon(Icons.close),
                ))
          ],),
        const Text(
          'Payment',
          style: TextStyle(
              fontSize: kTextRegular2x, fontWeight: FontWeight.w400),
        ),
          const SizedBox(height: kMarginMedium3,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kMarginXLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text(
              'Your current smile points',
              style: TextStyle(
                  fontSize: kTextSmall),
            ),
            Text(
              '1500000 Points',
              style: TextStyle(
                  fontSize: kTextSmall,color: kPrimaryColor),
            ),
          ],),
        ),
          const SizedBox(height: kMarginMedium2,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kMarginXLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text(
              'Points used for this campaign',
              style: TextStyle(
                  fontSize: kTextSmall),
            ),
            Text(
              '1500000 Points',
              style: TextStyle(
                  fontSize: kTextSmall,color: kPrimaryColor),
            ),
          ],),
        ),

        const SizedBox(height: kMargin12,),
        const Divider(),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Text(
            'Remaining Points',
            style: TextStyle(
                fontSize: kTextSmall),
          ),
          Text(
            '1500000 Points',
            style: TextStyle(
                fontSize: kTextSmall,color: kPrimaryColor),
          ),
        ],),
        const SizedBox(height: kMargin12,),
          InkWell(
            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const MyTeamPage())),
            child: Container(height: 39,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(kMargin6 - 2),color: kPrimaryColor),
              child: const Center(child: Text('Pay Now',style: TextStyle(color: Colors.white),),),
            ),
          )
      ],),
    );
  }
}
