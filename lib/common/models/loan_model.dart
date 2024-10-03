class LoanModel {
  final String? uid;
  final String? consumerId;
  final String? creditorId;
  final double? amount;
  final double? fees;
  final DateTime? dueDate;
  final DateTime? creationTime;
  final DateTime? updateTime;
  final bool? concluded;

  LoanModel({
    this.uid,
    this.consumerId,
    this.creditorId,
    this.amount,
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
      fees: map['fees'],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      creationTime: map['creationTime'] != null ? DateTime.parse(map['creationTime']) : null,
      updateTime: map['updateTime'] != null ? DateTime.parse(map['updateTime']) : null,
      concluded: map['concluded'],
    );
  }
}
