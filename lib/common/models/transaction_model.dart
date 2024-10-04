import 'package:emprestapro/common/constants/enums/transaction_status.dart';

class TransactionModel {
  final String? uid;
  final String? consumerId;
  final String? creditorId;
  final String? loanId;
  final double? amount;
  final DateTime? transactionTime;
  final DateTime? creationTime;
  final DateTime? updateTime;
  final TransactionStatus? status;

  TransactionModel({
    this.uid,
    this.consumerId,
    this.creditorId,
    this.loanId,
    this.amount,
    this.transactionTime,
    this.creationTime,
    this.updateTime,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'consumerId': consumerId,
      'creditorId': creditorId,
      'loanId': loanId,
      'amount': amount,
      'transactionTime': transactionTime?.toIso8601String(),
      'creationTime': creationTime?.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
      'status': status?.name,
    };
  }

  // Método para criar uma TransactionModel a partir de um Map
  factory TransactionModel.fromMap({required Map<String, dynamic> map}) {
    return TransactionModel(
      uid: map['uid'],
      consumerId: map['consumerId'],
      creditorId: map['creditorId'],
      loanId: map['loanId'],
      amount: map['amount'],
      transactionTime: DateTime.parse(map['transactionTime']),
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: DateTime.parse(map['updateTime']),
      status: TransactionStatus.values.byName(map['status']),
    );
  }
}
