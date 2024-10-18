import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/pages/consumer/add_consumer_page.dart';
import 'package:emprestapro/pages/consumer/consumer_details_page.dart';
import 'package:emprestapro/pages/consumer/consumers_page.dart';
import 'package:emprestapro/pages/loan/add_loan_page.dart';
import 'package:emprestapro/pages/profile/edit_message_page.dart';
import 'package:emprestapro/pages/transaction/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/pages/home/home_page_view.dart';
import 'package:emprestapro/pages/loan/loan_detail_page.dart';
import 'package:emprestapro/pages/loan/loans_page.dart';
import 'package:emprestapro/pages/profile/profile_page.dart';
import 'package:emprestapro/pages/sign_in/sign_in_page.dart';
import 'package:emprestapro/pages/sign_up/sign_up_page.dart';
import 'package:emprestapro/pages/splash/splash_page.dart';

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
          case NamedRoute.consumers:
            return MaterialPageRoute(builder: (_) => const ConsumersPage());
          case NamedRoute.editMessage:
            return MaterialPageRoute(builder: (_) => const EditMessagePage());
          case NamedRoute.addLoan:
            final loan = settings.arguments == null
                ? null
                : settings.arguments as LoanModel;

            return MaterialPageRoute(
              builder: (_) => AddLoanPage(
                loan: loan,
              ),
            );
          case NamedRoute.addConsumer:
            final consumer = settings.arguments == null
                ? null
                : settings.arguments as ConsumerModel;
            return MaterialPageRoute(
              builder: (_) => AddConsumerPage(consumer: consumer),
            );
          case NamedRoute.loanDetail:
            final loan = settings.arguments as LoanModel;
            return MaterialPageRoute(
              builder: (_) => LoanDetailPage(loan: loan),
            );
          case NamedRoute.addTransaction:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => AddTransactionPage(
                loan: args['loan'] as LoanModel,
                transaction: args['transaction'] as TransactionModel?,
              ),
            );
          case NamedRoute.consumerDetail:
            final consumer = settings.arguments as ConsumerModel;
            return MaterialPageRoute(
              builder: (_) => ConsumerDetailsPage(consumer: consumer),
            );
          default:
            return MaterialPageRoute(builder: (_) => const SplashPage());
        }
      },
    );
  }
}
