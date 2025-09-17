import '../../data/models/order.dart';
import '../../data/models/drink.dart';
import '../services/hive_service.dart';

/// Repository interface defining the contract for order data operations
/// This follows the Repository pattern to abstract data access
abstract class IOrderRepository {
  Future<List<Order>> getAllOrders();
  Future<List<Order>> getPendingOrders();
  Future<List<Order>> getCompletedOrders();
  Future<Order?> getOrderById(String id);
  Future<void> addOrder(Order order);
  Future<void> updateOrder(Order order);
  Future<void> deleteOrder(String id);
  Future<void> markOrderAsCompleted(String id);
  Future<List<Drink>> getAllDrinks();
  Future<Drink?> getDrinkByName(String name);
  Future<Map<String, int>> getDrinkSalesCount();
  Future<Map<String, double>> getDrinkSalesRevenue();
  Future<double> getTotalRevenue();
  Future<int> getTotalOrdersServed();
}

/// Concrete implementation of IOrderRepository using Hive for data persistence
/// This class encapsulates all data access logic and provides a clean interface
class OrderRepository implements IOrderRepository {
  @override
  Future<List<Order>> getAllOrders() async {
    return await HiveService.getAllOrders();
  }

  @override
  Future<List<Order>> getPendingOrders() async {
    return await HiveService.getOrdersByStatus(OrderStatus.pending);
  }

  @override
  Future<List<Order>> getCompletedOrders() async {
    return await HiveService.getOrdersByStatus(OrderStatus.completed);
  }

  @override
  Future<Order?> getOrderById(String id) async {
    final orders = await getAllOrders();
    try {
      return orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addOrder(Order order) async {
    await HiveService.addOrder(order);
  }

  @override
  Future<void> updateOrder(Order order) async {
    await HiveService.updateOrder(order);
  }

  @override
  Future<void> deleteOrder(String id) async {
    await HiveService.deleteOrder(id);
  }

  @override
  Future<void> markOrderAsCompleted(String id) async {
    final order = await getOrderById(id);
    if (order != null) {
      final updatedOrder = order.copyWith(
        status: OrderStatus.completed,
        completedAt: DateTime.now(),
      );
      await updateOrder(updatedOrder);
    }
  }

  @override
  Future<List<Drink>> getAllDrinks() async {
    return await HiveService.getAllDrinks();
  }

  @override
  Future<Drink?> getDrinkByName(String name) async {
    return await HiveService.getDrinkByName(name);
  }

  @override
  Future<Map<String, int>> getDrinkSalesCount() async {
    return await HiveService.getDrinkSalesCount();
  }

  @override
  Future<Map<String, double>> getDrinkSalesRevenue() async {
    return await HiveService.getDrinkSalesRevenue();
  }

  @override
  Future<double> getTotalRevenue() async {
    return await HiveService.getTotalRevenue();
  }

  @override
  Future<int> getTotalOrdersServed() async {
    return await HiveService.getTotalOrdersServed();
  }
}
