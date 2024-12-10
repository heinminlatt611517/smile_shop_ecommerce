import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

class SearchProductDao {
  ///Must be singleton
  static final SearchProductDao _singleton = SearchProductDao._internal();

  factory SearchProductDao() {
    return _singleton;
  }

  SearchProductDao._internal();

  /**------------------------- CRUD OPERATIONS --------------------------**/

  ///save single search product to hive
  void saveSingleSearchProduct(SearchProductVO product) async {
    await getSearchProductBox().put(product.name, product);
  }

  ///get search products list
  List<SearchProductVO> getSearchProducts() {
    return getSearchProductBox().values.toList();
  }

  ///delete search product
  void deleteSearchProduct(String title) async {
    await getSearchProductBox().delete(title);
  }

  ///get search product by name
  SearchProductVO? getSearchProductByName(String title)  {
     return getSearchProductBox().get(title);
  }

  ///clear search product
  void clearSearchProduct() async {
    await getSearchProductBox().clear();
  }

  ///watch search product box
  Stream<void> watchSearchProductBox() {
    return getSearchProductBox().watch();
  }

  /**--------------------------- GET BOX ------------------------------**/
  ///get search product box
  Box<SearchProductVO> getSearchProductBox() {
    return Hive.box<SearchProductVO>(kBoxSearchProduct);
  }
}