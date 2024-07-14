import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';
import 'expense_details_screen.dart';
import 'package:expense_tracker/widgets/expense_item.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Expense> _userExpenses = [];
  String _selectedFilter = 'All';

  void _addNewExpense(Expense expense) {
    setState(() {
      _userExpenses.add(expense);
    });
  }

  void _deleteExpense(int index) {
    setState(() {
      _userExpenses.removeAt(index);
    });
  }
  void _startAddNewExpense(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return AddExpenseScreen(onAddExpense: _addNewExpense);
        },
      ),
    );
  }

  void _viewExpenseDetails(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ExpenseDetailsScreen(
            expense: _userExpenses[index],
          );
        },
      ),
    );
  }

  List<Expense> get _filteredExpenses {
    if (_selectedFilter == 'All') {
      return _userExpenses;
    } else {
      return _userExpenses.where((expense) => expense.category == _selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _filteredExpenses.fold(0.0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: <Widget>[
          Center(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewExpense(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Total Amount Spent: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton<String>(
              value: _selectedFilter,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
              items: <String>['All', 'Food', 'Transport', 'Entertainment', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredExpenses.length,
              itemBuilder: (ctx, index) {
                return ExpenseListItem(
                  expense: _filteredExpenses[index],
                  onTap: () => _viewExpenseDetails(context, index),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}
