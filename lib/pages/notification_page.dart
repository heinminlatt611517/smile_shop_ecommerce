import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/notification_bloc.dart';
import 'package:smile_shop/data/vos/notification_vo.dart';
import 'package:smile_shop/pages/blog_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationBloc(),
      child: Scaffold(
        appBar: CustomAppBarView(
          title: AppLocalizations.of(context)!.notification,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Selector<NotificationBloc, List<NotificationVO>?>(
          selector: (context, bloc) => bloc.notificationList,
          builder: (context, notiList, child) => notiList == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                  itemCount: notiList.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      noti: notiList[index],
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationVO noti;
  const NotificationCard({
    super.key,
    required this.noti,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlogPage(
            notificationVO: noti,
          ),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kMarginMedium),
          child: Column(
            spacing: kMarginMedium,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                child: Text(
                  noti.title ?? '',
                  style: const TextStyle(fontSize: kTextRegular2x),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                child: Text(noti.content ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImageView(
                    imageHeight: 100,
                    imageWidth: double.infinity,
                    imageUrl: noti.image ?? '',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
