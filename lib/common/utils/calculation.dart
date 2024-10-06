import 'package:emprestapro/common/models/loan_model.dart';

class Calculation {
  Calculation._();

  static double totalBorrowed(List<LoanModel> loans) {
    double total = 0;
    loans = loans.where((loan) => loan.concluded == false).toList();
    for (var loan in loans) {
      total += loan.amount!;
    }
    return total;
  }

  static double feesAmount(LoanModel loan) {
    return loan.amount! * (loan.fees! / 100);
  }

  static double minimumFeesToReceive(List<LoanModel> loans) {
    double total = 0;
    loans = loans.where((loan) => loan.concluded == false).toList();
    for (var loan in loans) {
      double fee = loan.amount! * (loan.fees! / 100);
      total += fee;
    }
    return total;
  }

  static DateTime? nextToDueDate(List<LoanModel> loans) {
    return loans
        .reduce((a, b) => a.dueDate!.isBefore(b.dueDate!) ? a : b)
        .dueDate;
  }
}
