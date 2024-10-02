import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/features/add_consumers/add_consumers.dart';
import 'package:emprestapro/features/home/home_page_view.dart';
import 'package:emprestapro/features/add_loans/add_loans_page.dart';
import 'package:emprestapro/features/sign_in/sign_in_page.dart';
import 'package:emprestapro/features/sign_up/sign_up_page.dart';
import 'package:emprestapro/features/splash/splash_page.dart';
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
        NamedRoute.addLoan: (context) => const AddLoanPage(),
        NamedRoute.add_consumer: (context) => const AddConsumerPage(),
      },
    );
  }
}
