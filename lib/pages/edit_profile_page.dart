import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';

import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 60,),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const CachedNetworkImageView(
                        imageHeight: 60,
                        imageWidth: 60,
                        imageUrl:
                            'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 18,
                  width: 96,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      'Change photo',
                      style: TextStyle(fontSize: kTextSmall),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (_) => nameModalSheet(context));
              },
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name'),
                        Row(
                          children: [
                            Text('Jonny'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider()
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone number'),
                      Row(
                        children: [
                          Text('099999999999'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      )
                    ],
                  ),
                ),
                Divider()
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change password'),
                      Row(
                        children: [
                          Text(''),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      )
                    ],
                  ),
                ),
                Divider()
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget nameModalSheet(BuildContext context) {
  return Container(
    height: 204,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            const Text(
              'Name',
              style: TextStyle(fontSize: kTextRegular2x),
            ),
            const SizedBox(),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ))
          ],
        ),
        const Text(
          'Fast & Last Name',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: const TextField(
              style: TextStyle(fontSize: kTextRegular),
              decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(fontSize: kTextRegular),
                  contentPadding: EdgeInsets.only(left: 20)),
            )),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
            child: const Center(
              child: Text(
                'Confirm',
                style: TextStyle(color: kBackgroundColor),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
