class DataManipulation {
  DataManipulation();

  static String chargeMessage({
    required String consumerName,
    required String message,
  }) {
    return 'Olá $consumerName, \n$message';
  }

  static String defaultMessage({
    required String clientName,
    required double loanAmount,
    required String dueDate,
    required double feeAmount,
    String? pix = 'responda que irei enviar.',
  }) {
    return '''
Oi, $clientName!

Seu pagamento do juros de R\$${feeAmount.toStringAsFixed(2)}, ou quitação do empréstimo de R\$${(loanAmount + feeAmount).toStringAsFixed(2)}, venceu em $dueDate. Por favor, faça o acerto o quanto antes.

Minha chave pix: $pix

Qualquer dúvida, estou por aqui!

Obrigado!
''';
  }

  static String androidUrl({
    required String phoneNumber,
    required String message,
  }) {
    return 'whatsapp://send?phone=55$phoneNumber&text=$message';
  }

  static String iosUrl({
    required String phoneNumber,
    required String message,
  }) {
    return 'https://wa.me/55$phoneNumber?text=${Uri.parse(message)}';
  }

  static String webUrl({
    required String phoneNumber,
    required String message,
  }) {
    return 'https://api.whatsapp.com/send/?phone=55$phoneNumber&text=$message';
  }

  static List<dynamic> sortByDueDateDescending(List<dynamic> transactions) {
    transactions.sort((a, b) {
      return b.transactionTime!.compareTo(a.transactionTime!);
    });
    return transactions;
  }
}
