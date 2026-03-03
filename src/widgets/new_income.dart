//import 'package:finance_tracker/models/models.dart';
import 'package:flutter/material.dart';
import '../models/data.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NewIncomePage extends StatefulWidget {
  const NewIncomePage({super.key});

  @override
  State<NewIncomePage> createState() => _NewIncomePageState();
}

class _NewIncomePageState extends State<NewIncomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  FinanceController get controller => Get.find<FinanceController>();

  void _clear() {
    _formKey.currentState?.reset();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      await controller.addTransaction(
        values['title'],
        double.parse(values['amount']),
        values['isIncome'] ?? false,
        date: values['date'],
      );
      _clear();
      Get.snackbar('Success', 'Transaction added');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      initialValue: {
        'isIncome': false,
        'date': DateTime.now(),
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New Transaction",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
          ),
          FormBuilderTextField(
            name: 'title',
            decoration: InputDecoration(
              hintText: 'Transaction name',
              border: OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.always,
            validator: FormBuilderValidators.required(),
            ),
          FormBuilderTextField(
            name: 'amount',
            decoration: InputDecoration(
              hintText: 'Amount 0.0€',
              border: OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.always,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(errorText: 'Must be a valid number'),
              FormBuilderValidators.min(0.01, errorText: 'Amount must be positive'),
            ])
            
            ),
          FormBuilderDateTimePicker(
            name: 'date',
            decoration: InputDecoration(
              hintText: 'Set date',
              border: OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.always,
            validator: FormBuilderValidators.required(),
            ),
          
          // informational text and checkbox wrapped in outlined box
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select only for income, for expense, leave unchecked!'),
                FormBuilderCheckbox(name: 'isIncome', title: Text('Income')),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _clear,
                child: Text("Clear"),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text("Submit"),
              )
            ],
          )
          ]
          ),
          
    );
    
  }
}
