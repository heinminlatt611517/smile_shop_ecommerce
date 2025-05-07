import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressListItemView extends StatelessWidget {
  final Function() onTapEdit;
  final AddressVO? addressVO;

  const AddressListItemView(
      {super.key, required this.onTapEdit, required this.addressVO});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMarginMedium2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on,
            color: kPrimaryColor,
          ),

          const SizedBox(
            width: kMarginMedium2,
          ),

          ///Address info view
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///name and phone number
              Row(
                children: [
                  Text(
                    addressVO?.name ?? "",
                    style: const TextStyle(fontSize: kTextRegular),
                  ),
                  const SizedBox(
                    width: kMarginMedium2,
                  ),
                  Text(
                    addressVO?.phone ?? "",
                    style: const TextStyle(
                        fontSize: kTextRegular, color: Colors.grey),
                  )
                ],
              ),

              const SizedBox(
                height: kMarginMedium,
              ),

              ///address
              Text(
                '${addressVO?.townshipVO?.name ?? ""},${addressVO?.stateVO?.name ?? ""}',
                style: const TextStyle(fontSize: kTextRegular),
              ),
              Text(
                addressVO?.address ?? "",
                style: const TextStyle(fontSize: kTextRegular),
              ),
              const SizedBox(
                height: kMarginMedium,
              ),

              ///home or office button
              Visibility(
                visible: addressVO?.categoryVO != null,
                child: IntrinsicWidth(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(kMarginMedium)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: Text(addressVO?.categoryVO?.name ?? ""),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),

          ///edit
          InkWell(
              onTap: onTapEdit,
              child: Text(
                AppLocalizations.of(context)?.edit ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular,
                    color: kPrimaryColor),
              )),
        ],
      ),
    );
  }
}
