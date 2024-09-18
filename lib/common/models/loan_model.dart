class LoanModel {
  final String id;
  final String consumerId;
  final List<String> transactionIds;
  final double amount;
  final DateTime dueDate;
  final DateTime creationDate;
  final DateTime updateDate;
  final bool concluded;

  LoanModel({
    required this.id,
    required this.consumerId,
    required this.transactionIds,
    required this.amount,
    required this.dueDate,
    required this.creationDate,
    required this.updateDate,
    required this.concluded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consumerId': consumerId,
      'amount': amount,
      'transactionIds': transactionIds,
      'dueDate': dueDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'concluded': concluded,
    };
  }

  factory LoanModel.fromMap(Map<String, dynamic> map) {
    return LoanModel(
      id: map['id'],
      consumerId: map['consumerId'],
      transactionIds: map['transactionIds'],
      amount: map['amount'],
      dueDate: DateTime.parse(map['dueDate']),
      creationDate: DateTime.parse(map['creationDate']),
      updateDate: DateTime.parse(map['updateDate']),
      concluded: map['concluded'],
    );
  }
}
