/// Representation of an item/position in the check.
class ItemModel {
  /// Display name of the item.
  final String name;

  /// Price in whole currency units.
  final int price;

  /// Quantity of the item.
  final int quantity;

  /// Creates a new [ItemModel].
  ItemModel({required this.name, required this.price, required this.quantity});
}
