import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

part 'search_product_vo.g.dart';

@HiveType(
    typeId: kHiveTypeSearchProductVO, adapterName: kAdapterSearchProductVO)
class SearchProductVO {
  @HiveField(0)
  final String? name;

  SearchProductVO({
    this.name,
  });
}
