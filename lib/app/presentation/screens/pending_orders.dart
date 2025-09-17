import 'package:flutter/material.dart';

class PendingOrdersScreen extends StatefulWidget {
  const PendingOrdersScreen({super.key});

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  final List<Map<String, String>> _pendingOrders = [
    {
      'name': 'Omar Hassan',
      'orderNumber': 'Order #12345',
    },
    {
      'name': 'Layla Ibrahim',
      'orderNumber': 'Order #12346',
    },
    {
      'name': 'Ahmed EL-Sayed',
      'orderNumber': 'Order #12347',
    },
    {
      'name': 'Fatima Ali',
      'orderNumber': 'Order #12348',
    },
    {
      'name': 'Youssef Mahmoud',
      'orderNumber': 'Order #12349',
    },
    {
      'name': 'Salma Tarek',
      'orderNumber': 'Order #12350',
    },
  ];

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
          'Pending Orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _pendingOrders.length,
        itemBuilder: (context, index) {
          final order = _pendingOrders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildPendingOrderItem(
              order['name']!,
              order['orderNumber']!,
            ),
          );
        },
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onBottomNavTap,
      // ),
    );
  }

  Widget _buildPendingOrderItem(String customerName, String orderNumber) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customerName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            orderNumber,
            style: const TextStyle(
              color: Color(0xFF8B5A3C),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
