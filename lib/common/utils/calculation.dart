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

  static LoanModel processTransaction(double transactionAmount, LoanModel loan) {
    // Pegar os juros do empréstimo (usando um valor padrão de 0.0 caso seja nulo)
    double interestAmount = loan.fees ?? 0.0;

    // Verificar se a transação é suficiente para cobrir os juros
    if (transactionAmount < interestAmount) {
      // Se o valor for menor que os juros, acumular o restante para o próximo mês
      double remainingInterest = interestAmount - transactionAmount;

      // Acrescenta o restante dos juros no próximo mês, garantindo que loan.fees não seja nulo
      loan.fees = (loan.fees ?? 0.0) + remainingInterest;
      print(
          'Juros não pagos totalmente. Restante acumulado para o próximo mês: $remainingInterest');
    } else {
      // Se o valor for suficiente para pagar os juros
      double leftoverAmount = transactionAmount - interestAmount;

      if (leftoverAmount > 0) {
        // Caso o valor seja maior que os juros, abater do valor do empréstimo
        loan.amount = (loan.amount ?? 0.0) - leftoverAmount;

        // Verificar se o empréstimo foi quitado
        if ((loan.amount ?? 0.0) <= 0) {
          loan.concluded = true; // Marcar o empréstimo como quitado
          loan.amount =
              0; // Garantir que o valor do empréstimo não seja negativo
          print('Empréstimo quitado completamente.');
        } else {
          print(
              'Juros pagos, e R\$ $leftoverAmount foi abatido do valor do empréstimo.');
        }
      } else {
        print(
            'Juros pagos completamente, mas sem abater do valor do empréstimo.');
      }
    }

    // Atualizar o estado do empréstimo no banco de dados
    return loan;
  }
}
