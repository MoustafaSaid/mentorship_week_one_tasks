import 'package:flutter/material.dart';
import 'package:mentorship_week_one_tasks/app/domain/services/order_service.dart';
import 'package:mentorship_week_one_tasks/app/domain/repositories/order_repository.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late OrderService _orderService;
  Map<String, dynamic> _analytics = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _orderService = OrderService(OrderRepository());
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    try {
      final analytics = await _orderService.getSalesAnalytics();
      setState(() {
        _analytics = analytics;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading analytics: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Top Selling Drinks',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadAnalytics,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sales Summary Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Sales',
                                style: TextStyle(
                                  color: Color(0xFF8B5A3C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.trending_up,
                                      color: Color(0xFF4CAF50),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${_analytics['totalOrdersServed'] ?? 0} orders',
                                      style: const TextStyle(
                                        color: Color(0xFF4CAF50),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${(_analytics['totalRevenue'] ?? 0.0).toStringAsFixed(0)} EGP',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Bar Chart
                          SizedBox(
                            height: 200,
                            child: _buildBarCharts(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Detailed Breakdown
                    const Text(
                      'Top Selling Drinks',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Drink Items
                    if (_analytics['topSellingDrinks'] != null)
                      ...(_analytics['topSellingDrinks'] as List).map((drink) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildDrinkItem(
                            drink['name'],
                            '${drink['units']} units',
                            '${drink['revenue'].toStringAsFixed(0)} EGP',
                            _getDrinkIcon(drink['name']),
                          ),
                        );
                      }),
                    if (_analytics['topSellingDrinks'] == null ||
                        (_analytics['topSellingDrinks'] as List).isEmpty)
                      const Center(
                        child: Text(
                          'No sales data available',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onBottomNavTap,
      // ),
    );
  }

  Widget _buildBarCharts() {
    final topDrinks = _analytics['topSellingDrinks'] as List? ?? [];
    if (topDrinks.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    final maxUnits = topDrinks.isNotEmpty
        ? topDrinks
            .map((drink) => drink['units'] as int)
            .reduce((a, b) => a > b ? a : b)
        : 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: topDrinks.take(4).map((drink) {
        final height = (drink['units'] as int) / maxUnits * 150.0;
        return _buildBarChart(drink['name'], height);
      }).toList(),
    );
  }

  Widget _buildBarChart(String label, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFFD2691E),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8B5A3C),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  IconData _getDrinkIcon(String drinkName) {
    switch (drinkName.toLowerCase()) {
      case 'shai':
      case 'tea':
      case 'hibiscus tea':
        return Icons.local_drink_outlined;
      case 'ahwa':
      case 'coffee':
      case 'turkish coffee':
        return Icons.coffee_outlined;
      case 'juice':
      case 'fresh juice':
        return Icons.local_drink_outlined;
      case 'water':
      case 'mineral water':
        return Icons.water_drop_outlined;
      default:
        return Icons.local_drink_outlined;
    }
  }

  Widget _buildDrinkItem(
      String name, String units, String price, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8B5A3C),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  units,
                  style: const TextStyle(
                    color: Color(0xFF8B5A3C),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
