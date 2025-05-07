import 'package:hive_flutter/hive_flutter.dart';
import 'package:smile_shop/persistence/hive_constants.dart';
import 'package:smile_shop/data/vos/cart_item_vo.dart';

class CartItemDao {
  static final CartItemDao _instance = CartItemDao._internal();
  factory CartItemDao() => _instance;
  CartItemDao._internal();

  Box<CartItemVo> getCartBox() => Hive.box<CartItemVo>(kBoxCart);

  Future<void> saveCartItem(CartItemVo item) async {
    final existingItem = getCartItem(item.variantId!);
    if (existingItem != null) {
      existingItem.quantity =
          (existingItem.quantity ?? 0) + (item.quantity ?? 1);
      await getCartBox().put(existingItem.variantId, existingItem);
    } else {
      await getCartBox().put(item.variantId, item);
    }
  }

  Future<void> removeCartItem(String variantId) async {
    await getCartBox().delete(variantId);
  }

  CartItemVo? getCartItem(String variantId) {
    return getCartBox().get(variantId);
  }

  List<CartItemVo> getAllCartItems() {
    return getCartBox().values.toList();
  }

  Future<void> clearCart() async {
    await getCartBox().clear();
  }

  Future<void> updateCartItemQuantity(String variantId, int newQuantity) async {
    print("REACHED ==========> update cart quantity $newQuantity");
    final item = getCartItem(variantId);
    if (item != null) {
      item.quantity = newQuantity;
      if (newQuantity <= 0) {
        await removeCartItem(variantId);
      } else {
        await getCartBox().put(item.variantId, item);
      }
    }
  }

  Future<void> increaseCartItemQuantity(String variantId) async {
    final item = getCartItem(variantId);
    if (item != null) {
      item.quantity = (item.quantity ?? 0) + 1;
      await saveCartItem(item);
    }
  }

  Future<void> decreaseCartItemQuantity(String variantId) async {
    final item = getCartItem(variantId);
    if (item != null && (item.quantity ?? 0) > 1) {
      item.quantity = item.quantity! - 1;
      await saveCartItem(item);
    }
  }

  Future<void> toggleCartItemSelection(String variantId) async {
    final item = getCartItem(variantId);
    if (item != null) {
      item.isSelected = !(item.isSelected ?? false);

      await getCartBox().put(item.variantId, item);
    }
  }

  Future<void> setAllCartItemsSelection(bool isSelected) async {
    final box = getCartBox();
    final items = box.values.toList();
    for (var item in items) {
      item.isSelected = isSelected;
      await box.put(item.variantId, item);
    }
  }

  

  List<CartItemVo> getSelectedCartItems() {
    return getAllCartItems().where((item) => item.isSelected ?? false).toList();
  }

  int getTotalPrice() {
    return getSelectedCartItems().fold(
        0,
        (total, item) =>
            total + (item.variantPrice ?? 0) * (item.quantity ?? 1));
  }

  Stream<List<CartItemVo>> watchCartItems() {
    return getCartBox().watch().map((_) {
      return getAllCartItems();
    });
  }
}
