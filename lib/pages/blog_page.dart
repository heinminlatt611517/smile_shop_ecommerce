// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:smile_shop/data/vos/notification_vo.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class BlogPage extends StatelessWidget {
  final NotificationVO? notificationVO;
  const BlogPage({
    super.key,
    this.notificationVO,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String? data = args?['data'];
    NotificationVO? notiFromNotiTap;
    if (data != null) {
      Map<String, dynamic>? formatData = jsonDecode(data);
      notiFromNotiTap = NotificationVO.fromJson(formatData ?? {});
    }
    return Scaffold(
      appBar: const CustomAppBarView(
        title: '',
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: notificationVO?.image ?? ''),
            const SizedBox(
              height: kMarginMedium,
            ),
            HtmlWidget(notificationVO?.content ?? (notiFromNotiTap?.content ?? '')),
          ],
        ),
      ),
    );
  }
}
