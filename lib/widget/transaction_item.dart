import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  final Function onDelete;
  const TransactionItem(
    this.tx,
    this.onDelete, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(tx.Id),
      onDismissed: (direction) {
        onDelete(tx);
        //  // Remove the item from the data source.
        //   setState(() {
        //     items.removeAt(index);
        //   });

        //   // Then show a snackbar.
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text('$item dismissed')));
      },
      background: Container(
        color: Colors.red,
        // child: Text(
        //   'Delete',
        //   style: TextStyle(color: Colors.white),
        // )
      ),
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                '\$${tx.Amount.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.Title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  DateFormat.yMMMMEEEEd().format(tx.Date),
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
