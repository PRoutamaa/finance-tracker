import 'models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FinanceController extends GetxController {
  final _box = GetStorage('storage');
  var transactions = <Transaction>[].obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTransactionsFromStorage();
  }

  void _loadTransactionsFromStorage() {
    List? storedTransactions = _box.read<List>('transactions');
    print(storedTransactions);
    if (storedTransactions != null) {
      transactions.assignAll(
          storedTransactions.map((e) => Transaction.fromJson(e)).toList());
    }
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }

  Future<void> addTransaction(String title, double amount, bool isIncome,
      {DateTime? date}) async {
    final transaction = Transaction(
      title: title,
      amount: amount,
      date: date ?? DateTime.now(),
      isIncome: isIncome,
    );
    transactions.add(transaction);
    print(transaction);
    await _box.write('transactions', transactions.map((e) => e.toJson()).toList());
    print(_box);
  }

  double get totalIncome => transactions
      .where((t) => t.isIncome)
      .fold(0.0, (sum, item) => sum + item.amount);

  List<Transaction> get incomes => transactions.where((t) => t.isIncome).toList();

  List<Transaction> get expenses => transactions.where((t) => !t.isIncome).toList();

  double get totalExpense => transactions
      .where((t) => !t.isIncome)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get balance => totalIncome - totalExpense;
}