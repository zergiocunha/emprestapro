class TransactionResult {
  TransactionResult._({this.message});
  final String? message;

  // Mensagens fixas
  static const String loanConcluded = "Empréstimo quitado completamente!";
  static const String interestPaid =
      "Juros pagos completamente, sem abater o valor do empréstimo.";
  static const String invalid =
      "Valor da transação maior que o empréstimo total + juros! Ajuste o valor e tente novamente.";

  // Método para mensagens que requerem interpolação
  static String insufficientInterest(String remainingInterest) {
    return "Juros não pagos totalmente. Restante acumulado para o próximo mês: R\$$remainingInterest";
  }

  static String partiallyPaid(String leftoverAmount) {
    return "Juros pagos, e R\$$leftoverAmount foi abatido do valor do empréstimo.";
  }
}
