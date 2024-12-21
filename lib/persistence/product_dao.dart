import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/persistence/hive_constants.dart';

class ProductDao {
  ///Must be singleton
  static final ProductDao _singleton = ProductDao._internal();

  factory ProductDao() {
    return _singleton;
  }

  ProductDao._internal();

  /**------------------------- CRUD OPERATIONS --------------------------**/

  ///save single product to hive
  void saveSearchProduct(ProductVO product) async {
    await getProductBox().put(product.id, product);
  }

  ///get products list
  List<ProductVO> getProducts() {
    return getProductBox().values.toList();
  }

  ///delete product
  void deleteSearchProduct(int productId) async {
    await getProductBox().delete(productId);
  }

  ///get product by name
  ProductVO? getProductByName(String title)  {
     return getProductBox().get(title);
  }

  ///clear product
  void clearProduct() async {
    await getProductBox().clear();
  }

  ///watch product box
  Stream<void> watchProductBox() {
    return getProductBox().watch();
  }

  /**--------------------------- GET BOX ------------------------------**/
  ///get product box
  Box<ProductVO> getProductBox() {
    return Hive.box<ProductVO>(kBoxProduct);
  }
}