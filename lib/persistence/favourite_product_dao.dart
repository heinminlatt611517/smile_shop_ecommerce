import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

class FavouriteProductDao {
  ///Must be singleton
  static final FavouriteProductDao _singleton = FavouriteProductDao._internal();

  factory FavouriteProductDao() {
    return _singleton;
  }

  FavouriteProductDao._internal();

  /**------------------------- CRUD OPERATIONS --------------------------**/

  ///save single product to hive
  void saveFavouriteProduct(ProductVO product) async {
    await getFavouriteProductBox().put(product.id, product);
  }

  ///get products list
  List<ProductVO> getFavouriteProducts() {
    return getFavouriteProductBox().values.toList();
  }

  ///delete product
  void deleteFavouriteProductByProductId(int productId) async {
    await getFavouriteProductBox().delete(productId);
  }

  ///get product by name
  ProductVO? getProductByName(String title)  {
     return getFavouriteProductBox().get(title);
  }

  ///get product by id
  ProductVO? getProductById(int id)  {
    return getFavouriteProductBox().get(id);
  }

  ///clear product
  void clearFavouriteProducts() async {
    await getFavouriteProductBox().clear();
  }

  ///watch product box
  Stream<void> watchFavouriteProductBox() {
    return getFavouriteProductBox().watch();
  }

  /**--------------------------- GET BOX ------------------------------**/
  ///get product box
  Box<ProductVO> getFavouriteProductBox() {
    return Hive.box<ProductVO>(kBoxFavouriteProduct);
  }
}