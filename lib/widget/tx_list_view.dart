import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'transaction_item.dart';

class TxList extends StatefulWidget {
  final List<Transaction> transactionList;
  final Function onDelete;
  const TxList(
      {super.key, required this.transactionList, required this.onDelete});

  @override
  State<TxList> createState() => _TxListState();
}

class _TxListState extends State<TxList> {
  // final List<Transaction> _transactionList;
  // _TxListState(this._transactionList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.transactionList.length,
      itemBuilder: (context, index) {
        return TransactionItem(widget.transactionList[index], widget.onDelete);
      },
      shrinkWrap: true,
    );
  }
}
