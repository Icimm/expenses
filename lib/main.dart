import 'dart:math';
import 'models/transactions.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
final ThemeData tema = ThemeData();

  ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MyhomePage(),
      theme: ThemeData(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.lightBlue,
          secondary: Colors.lightBlue,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
         titleTextStyle: TextStyle(
          fontFamily: 'QuickSand',
           fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.white,
         ),
        ),
      ),
    );
  }
}

class MyhomePage extends StatefulWidget {

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}
class _MyhomePageState extends State<MyhomePage> {

final  List<Transaction>_transactions = [
  Transaction(
    id: 't0',
    title: 'Conta Antiga',
    value: 400.00,
    date: DateTime.now().subtract(Duration(days: 33)),
  ),
  Transaction(
    id: 't2',
    title: 'Conta de Luz',
    value: 211.30,
    date: DateTime.now().subtract(Duration(days: 4)),
  ),
];

List<Transaction> get _recentTransactions{
  return _transactions.where((tr) {
    return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
    ));
  }).toList();
}


  addTransaction(String title, double value){

    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(addTransaction);
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: IconButton(
                icon: Icon(Icons.add),
              onPressed: () => _opentransactionFormModal(context),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Chart(_recentTransactions),
          TransactionList(_transactions),
        ],
       ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
