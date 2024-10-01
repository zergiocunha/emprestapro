import 'package:emprestapro/common/constants/enums/transaction_status.dart';

class TransactionModel {
  final String uid;
  final String consumerId;
  final String loanId;
  final double amount;
  final DateTime transactionTime;
  final DateTime creationTime;
  final DateTime updateTime;
  final TransactionStatus status;

  TransactionModel({
    required this.uid,
    required this.consumerId,
    required this.loanId,
    required this.amount,
    required this.transactionTime,
    required this.creationTime,
    required this.updateTime,
    required this.status,
  });

  // Método para converter um TransactionModel para um Map (útil para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'consumerId': consumerId,
      'loanId': loanId,
      'amount': amount,
      'transactionTime': transactionTime.toIso8601String(),
      'creationTime': creationTime.toIso8601String(),
      'updateTime': updateTime.toIso8601String(),
      'status': status.name,
    };
  }

  // Método para criar uma TransactionModel a partir de um Map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      uid: map['uid'],
      consumerId: map['consumerId'],
      loanId: map['loanId'],
      amount: map['amount'],
      transactionTime: DateTime.parse(map['transactionTime']),
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: DateTime.parse(map['updateTime']),
      status: TransactionStatus.values.byName(map['status']),
    );
  }
}
