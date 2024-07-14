import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  ExpenseListItem({required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.name),
      subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
      trailing: Text(expense.category),
      onTap: onTap,
    );
  }
}