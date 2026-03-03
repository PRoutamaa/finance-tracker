import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/data.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final FinanceController controller = Get.isRegistered<FinanceController>()
        ? Get.find<FinanceController>()
        : Get.put(FinanceController());
    return Column(children: [
      Text('History', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
      Text('All transactions', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
      Container(width: 500.0 ,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transaction name'),
                      Text('Date'),
                      Text('Amount'),
                      Text('Transaction type')
                    ]
                  )
              ),
      SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: controller.transactions.map((t) => Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 500.0 ,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: t.isIncome ? Colors.greenAccent : Colors.redAccent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(t.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(t.date.toString().split(' ')[0], style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                    '${t.amount}€',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(t.isIncome ? 'Income' : 'Expense'),
                  ],),
                )
              )).toList(),
            ),
          ),
    ],
    );
  }
}