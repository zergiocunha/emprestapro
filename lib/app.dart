import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/features/consumer/add_consumer_page.dart';
import 'package:emprestapro/features/consumer/consumers_page.dart';
import 'package:emprestapro/features/home/home_page_view.dart';
import 'package:emprestapro/features/loan/add_loan_page.dart';
import 'package:emprestapro/features/loan/loans_page.dart';
import 'package:emprestapro/features/profile/profile_page.dart';
import 'package:emprestapro/features/sign_in/sign_in_page.dart';
import 'package:emprestapro/features/sign_up/sign_up_page.dart';
import 'package:emprestapro/features/splash/splash_page.dart';
import 'package:emprestapro/features/transaction/add_transaction_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      routes: {
        NamedRoute.signUp: (context) => const SignUpPage(),
        NamedRoute.signIn: (context) => const SignInPage(),
        NamedRoute.home: (context) => const HomePageView(),
        NamedRoute.profile: (context) => const ProfilePage(),
        NamedRoute.addLoan: (context) => const AddLoanPage(),
        NamedRoute.addConsumer: (context) => const AddConsumerPage(),
        NamedRoute.loans: (context) => const LoansPage(),
        NamedRoute.addTransaction: (context) => const AddTransactionPage(),
        NamedRoute.consumers: (context) => const ConsumersPage(),
      },
    );
  }
}
