import 'package:emprestapro/common/constants/enums/loan_filter.dart';

extension LoanFilterExtension on LoanFilter {
  String get description {
    switch (this) {
      case LoanFilter.concluded:
        return 'Concluídos';
      case LoanFilter.notConcluded:
        return 'Não Concluídos';
      case LoanFilter.overdue:
        return 'Vencidos';
      case LoanFilter.all:
        return 'Todos';
      default:
        return '';
    }
  }
}