import 'package:emprestapro/common/constants/enums/transaction_status.dart';

class TransactionModel {
  final String id;
  final String consumerId;
  final String loanId;
  final double amount;
  final DateTime transactionDate;
  final DateTime creationDate;
  final DateTime updateDate;
  final TransactionStatus status;

  TransactionModel({
    required this.id,
    required this.consumerId,
    required this.loanId,
    required this.amount,
    required this.transactionDate,
    required this.creationDate,
    required this.updateDate,
    required this.status,
  });

  // Método para converter um TransactionModel para um Map (útil para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consumerId': consumerId,
      'loanId': loanId,
      'amount': amount,
      'transactionDate': transactionDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'status': status.name,
    };
  }

  // Método para criar uma TransactionModel a partir de um Map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      consumerId: map['consumerId'],
      loanId: map['loanId'],
      amount: map['amount'],
      transactionDate: DateTime.parse(map['transactionDate']),
      creationDate: DateTime.parse(map['creationDate']),
      updateDate: DateTime.parse(map['updateDate']),
      status: TransactionStatus.values.byName(map['status']),
    );
  }
}
