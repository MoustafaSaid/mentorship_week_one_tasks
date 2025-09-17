import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/drink.dart';
import '../../data/models/order.dart';

class HiveService {
  static const String _drinksBoxName = 'drinks';
  static const String _ordersBoxName = 'orders';

  static Box<Drink>? _drinksBox;
  static Box<Order>? _ordersBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(DrinkAdapter());
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(OrderStatusAdapter());

    // Open boxes
    _drinksBox = await Hive.openBox<Drink>(_drinksBoxName);
    _ordersBox = await Hive.openBox<Order>(_ordersBoxName);

    // Initialize default drinks if empty
    await _initializeDefaultDrinks();
  }

  static Future<void> _initializeDefaultDrinks() async {
    if (_drinksBox!.isEmpty) {
      final defaultDrinks = [
        Drink(name: 'Shai', price: 20.0, category: 'Tea'),
        Drink(name: 'Ahwa', price: 25.0, category: 'Coffee'),
        Drink(name: 'Karkade', price: 25.0, category: 'Juice'),
        Drink(name: 'Turkish Coffee', price: 30.0, category: 'Coffee'),
        Drink(name: 'Hibiscus Tea', price: 20.0, category: 'Tea'),
        Drink(name: 'Fresh Juice', price: 35.0, category: 'Juice'),
        Drink(name: 'Mineral Water', price: 10.0, category: 'Water'),
      ];

      for (final drink in defaultDrinks) {
        await _drinksBox!.add(drink);
      }
    }
  }

  // Drink operations
  static Future<void> addDrink(Drink drink) async {
    await _drinksBox!.add(drink);
  }

  static Future<List<Drink>> getAllDrinks() async {
    return _drinksBox!.values.toList();
  }

  static Future<Drink?> getDrinkByName(String name) async {
    return _drinksBox!.values.firstWhere(
      (drink) => drink.name == name,
      orElse: () => Drink(name: name, price: 0.0, category: 'Unknown'),
    );
  }

  static Future<void> updateDrink(Drink drink) async {
    final index =
        _drinksBox!.values.toList().indexWhere((d) => d.name == drink.name);
    if (index != -1) {
      await _drinksBox!.putAt(index, drink);
    }
  }

  // Order operations
  static Future<void> addOrder(Order order) async {
    await _ordersBox!.add(order);
  }

  static Future<List<Order>> getAllOrders() async {
    return _ordersBox!.values.toList();
  }

  static Future<List<Order>> getOrdersByStatus(OrderStatus status) async {
    return _ordersBox!.values.where((order) => order.status == status).toList();
  }

  static Future<void> updateOrder(Order order) async {
    final index =
        _ordersBox!.values.toList().indexWhere((o) => o.id == order.id);
    if (index != -1) {
      await _ordersBox!.putAt(index, order);
    }
  }

  static Future<void> deleteOrder(String orderId) async {
    final index =
        _ordersBox!.values.toList().indexWhere((o) => o.id == orderId);
    if (index != -1) {
      await _ordersBox!.deleteAt(index);
    }
  }

  // Analytics operations
  static Future<Map<String, int>> getDrinkSalesCount() async {
    final orders = await getAllOrders();
    final completedOrders = orders.where((order) => order.isCompleted).toList();

    final Map<String, int> salesCount = {};
    for (final order in completedOrders) {
      final drinkName = order.drink.name;
      salesCount[drinkName] = (salesCount[drinkName] ?? 0) + 1;
    }

    return salesCount;
  }

  static Future<Map<String, double>> getDrinkSalesRevenue() async {
    final orders = await getAllOrders();
    final completedOrders = orders.where((order) => order.isCompleted).toList();

    final Map<String, double> salesRevenue = {};
    for (final order in completedOrders) {
      final drinkName = order.drink.name;
      salesRevenue[drinkName] =
          (salesRevenue[drinkName] ?? 0.0) + order.drink.price;
    }

    return salesRevenue;
  }

  static Future<double> getTotalRevenue() async {
    final revenueMap = await getDrinkSalesRevenue();
    double totalRevenue = 0.0;
    for (final revenue in revenueMap.values) {
      totalRevenue += revenue;
    }
    return totalRevenue;
  }

  static Future<int> getTotalOrdersServed() async {
    final orders = await getAllOrders();
    return orders.where((order) => order.isCompleted).length;
  }

  static Future<void> close() async {
    await _drinksBox?.close();
    await _ordersBox?.close();
  }
}
