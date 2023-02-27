import 'dart:math';
import 'package:flutter/services.dart';

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

final  List<Transaction>_transactions = [];
bool _showChart = false;

List<Transaction> get _recentTransactions{
  return _transactions.where((tr) {
    return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
    ));
  }).toList();
}


  addTransaction(String title, double value, DateTime date){

    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
  setState(() {
    _transactions.removeWhere((tr) => tr.id == id);
   });
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
  final appBar = AppBar(
    title: const Text('Despesas Pessoais'),
    actions: [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
    ],
  );

   final avaliableHeight = MediaQuery.of(context).size.height
   - appBar.preferredSize.height -
       MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Row(
            children: <Widget>[
              Text('Exibir Gráfico'),
              Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
              ),
            ],
          ),
          if (_showChart)
              SizedBox(
              height: avaliableHeight * 0.3,
              child: Chart(_recentTransactions)
          ),
          if (!_showChart)
          SizedBox(
              height: avaliableHeight * 0.7,
              child: TransactionList(_transactions, _removeTransaction)
          ),
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
