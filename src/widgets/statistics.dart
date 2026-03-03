import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/data.dart';
import '../models/models.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {

    final FinanceController controller = Get.isRegistered<FinanceController>()
        ? Get.find<FinanceController>()
        : Get.put(FinanceController());
    return Center(
      child: Column(
        children: [
          const Text(
            'Statistics',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Obx(
              () => SummaryCard(
                title: 'Incomes',
                transactions: controller.incomes,
                icon: Icons.arrow_downward,
                color: Colors.green,
                backgroundColor: Colors.green.withValues(alpha: 0.1),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () => SummaryCard(
                title: 'Expenses',
                transactions: controller.expenses,
                icon: Icons.arrow_upward,
                color: Colors.red,
                backgroundColor: Colors.red.withValues(alpha: 0.1),
              ),
            ),
          ),
        ],
      )
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    required this.title,
    required this.transactions,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  final String title;
  final List<Transaction> transactions;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final recentTransactions =
        transactions.where((t) => t.date.isAfter(sevenDaysAgo)).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                '$title in the last 30d',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text('Total number of transactions: ${recentTransactions.length}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),),
          Text('Total $title : ${recentTransactions.fold(0.0, (sum, item) => sum + item.amount)}€',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: recentTransactions.map((t) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: color),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(children: [
                    Text(t.date.toString().split(' ')[0], style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                    '${t.amount}€',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ],),
                )
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}