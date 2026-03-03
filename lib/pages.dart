import 'package:flutter/material.dart';

class Page {
  const Page(this.icon, this.label, this.address);
  final IconData icon;
  final String label;
  final String address;
}

const List<Page> destinations = <Page>[
  Page(Icons.calendar_month_rounded, 'Main page', '/'),
  Page(Icons.money, 'New Income', '/newincome'),
  Page(Icons.query_stats_outlined, 'Statistics', '/statistics'),
  Page(Icons.history_outlined, 'History', '/history'),
];