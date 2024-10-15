import 'package:emprestapro/common/constants/enums/transaction_status.dart';
import 'package:emprestapro/common/constants/transaction_result.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';

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

  static Map<String, dynamic> processTransaction(
      TransactionModel transaction, LoanModel loan) {
    double feesAmount =
        double.parse(Calculation.feesAmount(loan).toStringAsFixed(2));
    TransactionStatus status;
    String message;
    final nextDueDate = DateTime(
      loan.dueDate!.year,
      loan.dueDate!.month + 1,
      loan.dueDate!.day,
    );

    if (transaction.amount! < feesAmount) {
      double remainingInterest =
          double.parse((feesAmount - transaction.amount!).toStringAsFixed(2));
      loan.amount = double.parse(
          ((loan.amount ?? 0.0) + remainingInterest).toStringAsFixed(2));
      status = TransactionStatus.insufficientInterest;
      message = TransactionResult.insufficientInterest(
          remainingInterest.toStringAsFixed(2));
      loan.dueDate = nextDueDate;
    } else {
      double leftoverAmount =
          double.parse((transaction.amount! - feesAmount).toStringAsFixed(2));

      if (leftoverAmount > 0) {
        loan.amount = double.parse(
            ((loan.amount ?? 0.0) - leftoverAmount).toStringAsFixed(2));

        if ((loan.amount ?? 0.0) <= 0) {
          loan.concluded = true;
          loan.amount = 0;
          loan.dueDate = nextDueDate;
          message = TransactionResult.loanConcluded;
          status = TransactionStatus.loanConcluded;
        } else {
          message = TransactionResult.partiallyPaid(
              leftoverAmount.toStringAsFixed(2));
          status = TransactionStatus.partiallyPaid;
          loan.dueDate = nextDueDate;
        }
      } else {
        message = TransactionResult.interestPaid;
        status = TransactionStatus.interestPaid;
        loan.dueDate = nextDueDate;
      }
    }

    return {'loan': loan, 'status': status, 'message': message};
  }
}
