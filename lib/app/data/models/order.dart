import 'package:hive/hive.dart';
import 'drink.dart';

part 'order.g.dart';

@HiveType(typeId: 1)
enum OrderStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  completed,
  @HiveField(2)
  cancelled,
}

@HiveType(typeId: 2)
class Order extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String customerName;

  @HiveField(2)
  final Drink drink;

  @HiveField(3)
  final String specialInstructions;

  @HiveField(4)
  final OrderStatus status;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? completedAt;

  @HiveField(7)
  final String tableNumber;

  Order({
    required this.id,
    required this.customerName,
    required this.drink,
    required this.specialInstructions,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.tableNumber,
  });

  Order copyWith({
    String? id,
    String? customerName,
    Drink? drink,
    String? specialInstructions,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? tableNumber,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      drink: drink ?? this.drink,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      tableNumber: tableNumber ?? this.tableNumber,
    );
  }

  bool get isPending => status == OrderStatus.pending;
  bool get isCompleted => status == OrderStatus.completed;
  bool get isCancelled => status == OrderStatus.cancelled;

  @override
  String toString() {
    return 'Order(id: $id, customerName: $customerName, drink: $drink, status: $status, tableNumber: $tableNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
