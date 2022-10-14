import 'package:flutter/foundation.dart';

class Transaction {
  @required
  final String Id;
  @required
  final String Title;
  @required
  final double Amount;
  @required
  final DateTime Date;
  Transaction(this.Id, this.Title, this.Amount, this.Date);

  // String get myId {
  //   return 'ID ${this.Id}';
  // }
}
