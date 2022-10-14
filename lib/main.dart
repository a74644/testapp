import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './widget/tx_list_view.dart';
import 'model/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Transaction records'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<Transaction> _txList = [
    Transaction('t1', 'Buy book', 99.10, DateTime.now()),
    Transaction('t2', 'Paid bill', 55.50, DateTime.now()),
  ];
  var _ctr = 1;
  void addTransaction() {
    setState(() {
      _txList.add(Transaction('Id$_ctr', titleController.text,
          double.parse(amountController.text), DateTime.now()));
      titleController.text = "";
      amountController.text = "";
      _ctr++;
    });
  }

  void _deleteItem(Transaction tx) {
    setState(() {
      _txList.remove(tx);
    });
  }

  void presentActionSheet() => showModalBottomSheet<void>(
        //  isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Record new transaction',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Title',
                          hintText: 'Enter transaction title'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Amount',
                          hintText: 'Enter transaction amount'),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // foregroundColor: Colors.purple,
                        // side: const BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Save'),
                      onPressed: () {
                        if (titleController.text.isNotEmpty &&
                            amountController.text.isNotEmpty) {
                          addTransaction();
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Title and Amount is required.',
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: presentActionSheet, icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Card(
              child: Text('CHART'),
            ),
            Expanded(
                child: _txList.isEmpty
                    ? const Text('No Data',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                    : TxList(
                        transactionList: _txList,
                        onDelete: _deleteItem,
                      )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.purple,
        elevation: 10,
        tooltip: 'Add transaction',
        onPressed: presentActionSheet,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
