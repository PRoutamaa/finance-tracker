import '../models/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({
    super.key,
    this.selectedPage,
  });

  final ValueChanged<int>? selectedPage;

  @override
  Widget build(BuildContext context) {
    final FinanceController controller = Get.find();
    return Obx(() => NavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      destinations: destinations.map<NavigationDestination>((d) {
        return NavigationDestination(icon: Icon(d.icon), label: d.label);
      }).toList(),
      selectedIndex: controller.selectedIndex.value,
      onDestinationSelected: selectedPage,
    ));
  }
}