import 'package:flutter/material.dart';
import '../components/transaction_item.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada !',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions.map((tr) {
            return TransactionItem(
              key: UniqueKey(),
              tr: tr,
              onRemove: onRemove,
            );
          }).toList());
    // ListView.builder(
    //    itemCount: transactions.length,
    //    itemBuilder: (ctx, index) {
    //      final tr = transactions[index];
    //      return TransactionItem(
    //        tr: tr,
    //        onRemove: onRemove,
    //      );
    //    },
    //  );
  }
}
