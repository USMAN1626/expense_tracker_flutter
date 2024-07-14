import 'package:flutter/material.dart';
import 'screens/expense_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        // Customize theme here
        primaryColor: Colors.green,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      // Consider using named routes for better navigation management
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/expenseList': (context) => ExpenseListScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/1.jpeg'),
            Text('Welcome to Expense Tracker'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/expenseList');
              },
              child: Text('View Expenses'),
            ),
          ],
        ),
      ),
    );
  }
}
