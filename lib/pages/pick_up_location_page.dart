import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class PickUpLocationPage extends StatelessWidget {
  const PickUpLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarView(title: 'Pick Up Location'),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pick_up_map.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("You can pick up your parcel here"),
                      Container(
                        margin: const EdgeInsets.only(top: kMarginMedium2),
                        padding: const EdgeInsets.all(kMarginMedium2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: const Border(
                            left: BorderSide(
                              color: kPrimaryColor,
                              width: 6,
                            ),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: kMarginMedium2),
                            Expanded(
                              child: Text(
                                "09985753854",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: kTextRegular2x,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: kMarginMedium2),
                        padding: const EdgeInsets.all(kMarginMedium2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: const Border(
                            left: BorderSide(
                              color: kPrimaryColor,
                              width: 6,
                            ),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.location_pin),
                            SizedBox(width: kMarginMedium2),
                            Expanded(
                              child: Text(
                                "No. 24, Pin Long Road, North Okklapa Township, Yangon",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: kTextRegular2x,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: -60,
                  child: Image.asset(
                    kAppLogoImage,
                    width: 100,
                    height: 100,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
