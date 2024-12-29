import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/edit_profile_bloc.dart';
import 'package:smile_shop/data/vos/profile_vo.dart';
import 'package:smile_shop/utils/colors.dart';

import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';
import '../widgets/loading_view.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, this.userVo});
  final ProfileVO? userVo;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.userVo?.name ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> EditProfileBloc(widget.userVo),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
        ),
        body: Selector<EditProfileBloc,bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) =>
           Stack(
             children: [
               ///body
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Selector<EditProfileBloc,File?>(
                  selector: (_,bloc)=> bloc.imgFile,
                  builder: (_,imgFile,child) =>
                   Column(
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
                              child: imgFile == null ? CachedNetworkImageView(
                                  imageHeight: 60,
                                  imageWidth: 60,
                                  imageUrl:
                                      widget.userVo?.profileImage ?? '') : Image.file(imgFile),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<EditProfileBloc>(
                            builder: (_,bloc,child) =>
                             InkWell(
                               onTap: () => bloc.uploadImage(),
                               child: Container(
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
                             ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Consumer<EditProfileBloc>(
                        builder: (context,bloc,child) =>
                         GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            showModalBottomSheet(
                                context: context, builder: (_) => nameModalSheet(context,_nameController,bloc));
                          },
                          child:  Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Name'),
                                    Row(
                                      children: [
                                        Text(widget.userVo?.name ?? ''),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                       const Icon(Icons.chevron_right)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Phone number'),
                                Row(
                                  children: [
                                    Text(widget.userVo?.phone ?? ''),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.chevron_right)
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider()
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
}

Widget nameModalSheet(BuildContext context,TextEditingController controller,EditProfileBloc bloc) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
            child:  TextField(
              controller: controller,
              style: const TextStyle(fontSize: kTextRegular),
              decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(fontSize: kTextRegular),
                  contentPadding: EdgeInsets.only(left: 20)),
            )),
        const SizedBox(
          height: 30,
        ),
        bloc.isLoading == true ? const Center(child: CircularProgressIndicator(color: Colors.amber,),) : GestureDetector(
         onTap: () {
           bloc.onTapConfirm(name: controller.text.trim()).then((response){
           });
         },
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
