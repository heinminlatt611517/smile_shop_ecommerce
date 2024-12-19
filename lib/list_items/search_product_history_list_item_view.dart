import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../blocs/search_product_bloc.dart';

class SearchProductHistoryListItemView extends StatelessWidget {
  final SearchProductVO? searchProductVO;
  final SearchProductBloc bloc;

  const SearchProductHistoryListItemView(
      {super.key, required this.searchProductVO, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){
                bloc.queryStreamController.sink.add(searchProductVO?.name ?? "");
              },
                child: Text(searchProductVO?.name ?? "",style:const TextStyle(fontSize: kTextRegular),)),
            const Spacer(),
            InkWell(
                onTap: () {
                  bloc.onTapClearSingleSearchProduct(
                      searchProductVO?.name ?? "");
                },
                child: const Icon(
                  Icons.clear,
                  size: 14,
                  color: Colors.grey,
                ))
          ],
        ),
        Container(
          margin:const EdgeInsets.symmetric(vertical: kMarginMedium2),
          width: double.infinity,
         height: 1,color: Colors.grey,)
      ],
    );
  }
}
