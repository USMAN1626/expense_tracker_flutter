import 'package:flutter/material.dart';
import '../models/expense.dart';
class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;

  ExpenseDetailsScreen({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${expense.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Amount: \$${expense.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Category: ${expense.category}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Date: ${expense.date.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Edit expense logic
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Delete expense logic
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  List<Expense> expenses = [];

  String selectedCategory = 'All';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();

  List<Expense> get filteredExpenses {
    if (selectedCategory == 'All') {
      return expenses;
    } else {
      return expenses.where((expense) => expense.category == selectedCategory).toList();
    }
  }

  void _addExpense() {
    final String name = _nameController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final String category = _selectedCategory;
    final DateTime date = _selectedDate;

    if (name.isNotEmpty && amount > 0) {
      setState(() {
        expenses.add(Expense(name: name, amount: amount, category: category, date: date));
      });

      _nameController.clear();
      _amountController.clear();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Expense Name'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: <String>['Food', 'Utilities', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Date: ${_selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 20.0,),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _addExpense,
                  child: Text('Add Expense'),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: <String>['All', 'Food', 'Utilities', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExpenses.length,
              itemBuilder: (context, index) {
                final expense = filteredExpenses[index];
                return ListTile(
                  title: Text(expense.name),
                  subtitle: Text('\$${expense.amount.toStringAsFixed(2)} - ${expense.category} - ${expense.date.toLocal().toString().split(' ')[0]}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseDetailsScreen(expense: expense),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
