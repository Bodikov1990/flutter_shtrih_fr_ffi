import 'validation_exception.dart';

/// Representation of an item/position in the check.
class ItemModel {
  /// Display name of the item.
  final String name;

  /// Price in whole currency units.
  final int price;

  /// Quantity of the item.
  final int quantity;

  /// Creates a new [ItemModel].
  ///
  /// Throws [ValidationException] if:
  /// - [name] is empty
  /// - [price] is negative
  /// - [quantity] is zero or negative
  ItemModel({required this.name, required this.price, required this.quantity}) {
    if (name.trim().isEmpty) {
      throw ValidationException(
        'Must not be empty',
        parameterName: 'name',
      );
    }
    if (price < 0) {
      throw ValidationException(
        'Must not be negative',
        parameterName: 'price',
      );
    }
    if (quantity <= 0) {
      throw ValidationException(
        'Must be positive',
        parameterName: 'quantity',
      );
    }
  }
}
