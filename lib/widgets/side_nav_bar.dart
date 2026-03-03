import 'package:finance_tracker/models/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({
    super.key,
    required this.backgroundColor,
    this.selectedPage,
  });
  final Color backgroundColor;
  final ValueChanged<int>? selectedPage;

  @override
  Widget build(BuildContext context) {
    final FinanceController controller = Get.find<FinanceController>();
    //final colorScheme = Theme.of(context).colorScheme;
    return Obx(() => NavigationRail(
      selectedIndex: controller.selectedIndex.value,
      backgroundColor: backgroundColor,
      onDestinationSelected: selectedPage,
      leading: Column(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      groupAlignment: -0.85,
      destinations: destinations.map((d) {
        return NavigationRailDestination(
          icon: Icon(d.icon),
          label: Text(d.label),
        );
      }).toList(),
    ));
  }
}