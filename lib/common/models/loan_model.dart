class LoanModel {
  String? uid;
  String? consumerId;
  String? creditorId;
  double? amount;
  double? initialAmount;
  double? fees;
  DateTime? dueDate;
  DateTime? creationTime;
  DateTime? updateTime;
  bool? concluded;

  LoanModel({
    this.uid,
    this.consumerId,
    this.creditorId,
    this.amount,
    this.initialAmount,
    this.fees,
    this.dueDate,
    this.creationTime,
    this.updateTime,
    this.concluded,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'consumerId': consumerId,
      'creditorId': creditorId,
      'amount': amount,
      'initialAmount': initialAmount,
      'fees': fees,
      'dueDate': dueDate?.toIso8601String(),
      'creationTime': creationTime?.toIso8601String(),
      'updateTime': updateTime?.toIso8601String(),
      'concluded': concluded,
    };
  }

  factory LoanModel.fromMap({required Map<String, dynamic> map}) {
    return LoanModel(
      uid: map['uid'],
      consumerId: map['consumerId'],
      creditorId: map['creditorId'],
      amount: map['amount'],
      initialAmount: map['initialAmount'],
      fees: map['fees'],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      creationTime: map['creationTime'] != null ? DateTime.parse(map['creationTime']) : null,
      updateTime: map['updateTime'] != null ? DateTime.parse(map['updateTime']) : null,
      concluded: map['concluded'],
    );
  }
}
