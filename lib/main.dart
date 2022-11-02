import 'package:db_test/view/expense_list.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '支出一覧',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => const ExpenseList(),
      },
    );
  }
}
