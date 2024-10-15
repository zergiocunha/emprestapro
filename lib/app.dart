import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/features/consumer/add_consumer_page.dart';
import 'package:emprestapro/features/consumer/consumer_detail_page.dart';
import 'package:emprestapro/features/consumer/consumers_page.dart';
import 'package:emprestapro/features/loan/add_loan_page.dart';
import 'package:emprestapro/features/profile/edit_message_page.dart';
import 'package:emprestapro/features/transaction/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/features/home/home_page_view.dart';
import 'package:emprestapro/features/loan/loan_detail_page.dart';
import 'package:emprestapro/features/loan/loans_page.dart';
import 'package:emprestapro/features/profile/profile_page.dart';
import 'package:emprestapro/features/sign_in/sign_in_page.dart';
import 'package:emprestapro/features/sign_up/sign_up_page.dart';
import 'package:emprestapro/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case NamedRoute.signUp:
            return MaterialPageRoute(builder: (_) => const SignUpPage());
          case NamedRoute.signIn:
            return MaterialPageRoute(builder: (_) => const SignInPage());
          case NamedRoute.home:
            return MaterialPageRoute(builder: (_) => const HomePageView());
          case NamedRoute.profile:
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case NamedRoute.loans:
            return MaterialPageRoute(builder: (_) => const LoansPage());
          case NamedRoute.addLoan:
            return MaterialPageRoute(builder: (_) => const AddLoanPage());
          case NamedRoute.addConsumer:
            return MaterialPageRoute(builder: (_) => const AddConsumerPage());
          case NamedRoute.consumers:
            return MaterialPageRoute(builder: (_) => const ConsumersPage());
          case NamedRoute.editMessage:
            return MaterialPageRoute(builder: (_) => const EditMessagePage());
          case NamedRoute.loanDetail:
            final loan = settings.arguments as LoanModel;
            return MaterialPageRoute(
              builder: (_) => LoanDetailPage(loan: loan),
            );
          case NamedRoute.addTransaction:
            final loan = settings.arguments as LoanModel;
            return MaterialPageRoute(
              builder: (_) => AddTransactionPage(loan: loan),
            );
          case NamedRoute.consumerDetail:
            final consumer = settings.arguments as ConsumerModel;
            return MaterialPageRoute(
              builder: (_) => ConsumerDetailPage(consumer: consumer),
            );
          default:
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}
