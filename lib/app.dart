import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/features/home/home_page_view.dart';
import 'package:emprestapro/features/sign_in/sign_in_page.dart';
import 'package:emprestapro/features/sign_up/sign_up_page.dart';
import 'package:emprestapro/features/teste.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        NamedRoute.signIn: (context) => const SignInPage(),
        NamedRoute.signUp: (context) => const SignUpPage(),
        NamedRoute.home: (context) => const HomePageView(),
      },
    );
  }
}
