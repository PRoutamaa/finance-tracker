import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/data.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, this.selectedIndex});

  final int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    final FinanceController controller = Get.isRegistered<FinanceController>()
        ? Get.find<FinanceController>()
        : Get.put(FinanceController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE, d MMMM').format(DateTime.now()),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Obx(
                  () => _SummaryCard(
                    title: 'Overall incomes, 30 days',
                    amount: controller.totalIncome,
                    icon: Icons.arrow_downward,
                    color: Colors.green,
                    backgroundColor: Colors.green.withValues(alpha: 0.1),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Obx(
                  () => _SummaryCard(
                    title: 'Overall expenses, 30 days',
                    amount: controller.totalExpense,
                    icon: Icons.arrow_upward,
                    color: Colors.red,
                    backgroundColor: Colors.red.withValues(alpha: 0.1),
                  ),
                ),
              ),
              
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Obx(
                  () => _SummaryCard(
                    title: 'Balance, 30 days',
                    amount: controller.balance,
                    icon: Icons.account_circle_outlined,
                    color: Colors.blueAccent,
                    backgroundColor: Colors.blue.withValues(alpha: 0.1),
                  ),
                ),
          ),
          
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: 
                ElevatedButton(
                  child: SizedBox(
                    height: 100,
                    child: Center(child: Text("Add new Transaction")),
                  ),
                  onPressed: () => controller.changePage(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  final String title;
  final double amount;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
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
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${amount.toStringAsFixed(2)}€',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
