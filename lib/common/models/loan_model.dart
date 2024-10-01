class LoanModel {
  final String uid;
  final String consumerId;
  final List<String> transactionIds;
  final double amount;
  final double fees;
  final DateTime dueDate;
  final DateTime creationTime;
  final DateTime updateTime;
  final bool concluded;

  LoanModel({
    required this.uid,
    required this.consumerId,
    required this.transactionIds,
    required this.amount,
    required this.fees,
    required this.dueDate,
    required this.creationTime,
    required this.updateTime,
    required this.concluded,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'consumerId': consumerId,
      'amount': amount,
      'fees': fees,
      'transactionIds': transactionIds,
      'dueDate': dueDate.toIso8601String(),
      'creationTime': creationTime.toIso8601String(),
      'updateTime': updateTime.toIso8601String(),
      'concluded': concluded,
    };
  }

  factory LoanModel.fromMap(Map<String, dynamic> map) {
    return LoanModel(
      uid: map['uid'],
      consumerId: map['consumerId'],
      transactionIds: map['transactionIds'],
      amount: map['amount'],
      fees: map['fees'],
      dueDate: DateTime.parse(map['dueDate']),
      creationTime: DateTime.parse(map['creationTime']),
      updateTime: DateTime.parse(map['updateTime']),
      concluded: map['concluded'],
    );
  }
}
