class TransactionModel {
  final String? uid;
  final String? consumerId;
  final String? creditorId;
  final String? loanId;
  final double? amount;
  final double? feesAmount;
  final DateTime? transactionTime;
  final DateTime? creationTime;
  final DateTime? updateTime;

  TransactionModel({
    this.uid,
    this.consumerId,
    this.creditorId,
    this.loanId,
    this.amount,
    this.feesAmount,
    this.transactionTime,
    this.creationTime,
    this.updateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'consumerId': consumerId,
      'creditorId': creditorId,
      'loanId': loanId,
      'amount': amount,
      'feesAmount': feesAmount,
      'transactionTime': transactionTime?.toIso8601String(),
      'creationTime': creationTime?.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
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
      feesAmount: map['feesAmount'],
      transactionTime: map['transactionTime'] != null
          ? DateTime.parse(map['transactionTime'])
          : null,
      creationTime: map['creationTime'] != null
          ? DateTime.parse(map['creationTime'])
          : null,
      updateTime:
          map['updateTime'] != null ? DateTime.parse(map['updateTime']) : null,
    );
  }
}
