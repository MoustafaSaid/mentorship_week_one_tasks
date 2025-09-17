import 'dart:math';
import '../../data/models/order.dart';
import '../../data/models/drink.dart';
import '../repositories/order_repository.dart';

/// Service class that contains business logic for order operations
/// This follows the Single Responsibility Principle by focusing only on order-related business logic
class OrderService {
  final IOrderRepository _orderRepository;

  OrderService(this._orderRepository);

  /// Creates a new order with validation and business rules
  Future<Order> createOrder({
    required String customerName,
    required String drinkName,
    required String specialInstructions,
    required String tableNumber,
  }) async {
    // Validate input
    if (customerName.trim().isEmpty) {
      throw ArgumentError('Customer name cannot be empty');
    }
    if (drinkName.trim().isEmpty) {
      throw ArgumentError('Drink name cannot be empty');
    }

    // Get drink information
    final drink = await _orderRepository.getDrinkByName(drinkName);
    if (drink == null) {
      throw ArgumentError('Drink not found: $drinkName');
    }

    // Generate unique order ID
    final orderId = _generateOrderId();

    // Create order
    final order = Order(
      id: orderId,
      customerName: customerName.trim(),
      drink: drink,
      specialInstructions: specialInstructions.trim(),
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
      tableNumber: tableNumber,
    );

    // Save order
    await _orderRepository.addOrder(order);
    return order;
  }

  /// Marks an order as completed and updates drink sales statistics
  Future<void> completeOrder(String orderId) async {
    final order = await _orderRepository.getOrderById(orderId);
    if (order == null) {
      throw ArgumentError('Order not found: $orderId');
    }

    if (order.isCompleted) {
      throw StateError('Order is already completed');
    }

    // Mark order as completed
    await _orderRepository.markOrderAsCompleted(orderId);

    // Update drink sales statistics
    await _updateDrinkSalesStatistics(order.drink);
  }

  /// Updates drink sales statistics when an order is completed
  Future<void> _updateDrinkSalesStatistics(Drink drink) async {
    // Note: In a real implementation, we would update the drink statistics here
    // For now, we'll handle this in the HiveService directly
  }

  /// Gets all pending orders
  Future<List<Order>> getPendingOrders() async {
    return await _orderRepository.getPendingOrders();
  }

  /// Gets all completed orders
  Future<List<Order>> getCompletedOrders() async {
    return await _orderRepository.getCompletedOrders();
  }

  /// Gets all orders
  Future<List<Order>> getAllOrders() async {
    return await _orderRepository.getAllOrders();
  }

  /// Gets all available drinks
  Future<List<Drink>> getAvailableDrinks() async {
    return await _orderRepository.getAllDrinks();
  }

  /// Gets sales analytics
  Future<Map<String, dynamic>> getSalesAnalytics() async {
    final totalRevenue = await _orderRepository.getTotalRevenue();
    final totalOrdersServed = await _orderRepository.getTotalOrdersServed();
    final drinkSalesCount = await _orderRepository.getDrinkSalesCount();
    final drinkSalesRevenue = await _orderRepository.getDrinkSalesRevenue();

    // Calculate top selling drinks
    final sortedDrinks = drinkSalesCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topSellingDrinks = sortedDrinks
        .take(5)
        .map((entry) => {
              'name': entry.key,
              'units': entry.value,
              'revenue': drinkSalesRevenue[entry.key] ?? 0.0,
            })
        .toList();

    return {
      'totalRevenue': totalRevenue,
      'totalOrdersServed': totalOrdersServed,
      'topSellingDrinks': topSellingDrinks,
      'drinkSalesCount': drinkSalesCount,
      'drinkSalesRevenue': drinkSalesRevenue,
    };
  }

  /// Generates a unique order ID
  String _generateOrderId() {
    final random = Random();
    final randomNumber = random.nextInt(9999).toString().padLeft(4, '0');
    return 'Order #$randomNumber';
  }

  /// Gets order statistics for dashboard
  Future<Map<String, int>> getOrderStatistics() async {
    final pendingOrders = await getPendingOrders();
    final completedOrders = await getCompletedOrders();
    final allOrders = await getAllOrders();

    return {
      'pending': pendingOrders.length,
      'completed': completedOrders.length,
      'total': allOrders.length,
    };
  }
}
