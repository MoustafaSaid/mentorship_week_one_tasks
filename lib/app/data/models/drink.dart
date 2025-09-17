import 'package:hive/hive.dart';

part 'drink.g.dart';

@HiveType(typeId: 0)
class Drink extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final int totalSold;

  @HiveField(4)
  final double totalRevenue;

  Drink({
    required this.name,
    required this.price,
    required this.category,
    this.totalSold = 0,
    this.totalRevenue = 0.0,
  });

  Drink copyWith({
    String? name,
    double? price,
    String? category,
    int? totalSold,
    double? totalRevenue,
  }) {
    return Drink(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      totalSold: totalSold ?? this.totalSold,
      totalRevenue: totalRevenue ?? this.totalRevenue,
    );
  }

  @override
  String toString() {
    return 'Drink(name: $name, price: $price, category: $category, totalSold: $totalSold, totalRevenue: $totalRevenue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Drink && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
