import 'dart:ui';
import 'widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'models/data.dart' as data;
import 'widgets/side_nav_bar.dart';
import 'widgets/top_nav_bar.dart';
import 'widgets/new_income.dart';
import 'widgets/statistics.dart';
import 'widgets/history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('storage');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
    _colorScheme.primary.withAlpha(36),
    _colorScheme.surface,
  );
  final data.FinanceController controller = Get.put(data.FinanceController());

  bool wideScreen = false;

  final List<Widget> pages = const [
    Dashboard(),
    NewIncomePage(),
    StatisticsPage(),
    HistoryPage(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wideScreen
          ? Row(
              children: [
                SideNavigationBar(
                  backgroundColor: _backgroundColor,
                  selectedPage: (index) {
                    setState(() {
                      controller.changePage(index);
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    color: _backgroundColor,
                    child: Obx(() => pages[controller.selectedIndex.value]),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                TopNavigationBar(
                  selectedPage: (index) {
                    setState(() {
                      controller.changePage(index);
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    color: _backgroundColor,
                    child: Obx(() => pages[controller.selectedIndex.value]),
                  ),
                ),
              ],
            ),
    );
  }
}