// ignore_for_file: type_literal_in_constant_pattern

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/utils.dart/validator.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/features/sign_in/sign_in_controller.dart';
import 'package:emprestapro/features/sign_in/sign_in_state.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInController = locator.get<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signInController.addListener(_handleSignUpstateChange);
    _signInController.setPageController = PageController();
  }

  void _handleSignUpstateChange() {
    final state = _signInController.state;
    switch (state.runtimeType) {
      case SignInLoadingState:
        showDialog(
          context: context,
          builder: (context) => const CircularProgressIndicator(),
        );
        break;
      case SignInSuccessState:
        break;
      case SignInErrorState:
        //!TODO: DEFINIR TRATATIVA
        // Navigator.pop(context);
        break;
    }
  }

  validateAndSignIn() async {
    final valid =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (valid) {
      await _signInController.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.popAndPushNamed(
        // ignore: use_build_context_synchronously
        context,
        NamedRoute.home,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryGreen,
      body: Stack(
        clipBehavior: Clip.antiAlias,
        textDirection: TextDirection.ltr,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_nome.png',
                        width: 200,
                        height: 100,
                      ),
                    ],
                  ),
                  const Text(
                    'Bem vindo de volta',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 32),
                  ),
                  const Text(
                    'Faça login para acesar sua conta',
                    style: TextStyle(
                        color: AppColors.secoundaryText, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 340,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 32,
                  bottom: 64,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        labelText: 'Email',
                        hintText: 'Insira seu email...',
                        controller: _emailController,
                        validator: Validator.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        labelText: 'Senha',
                        hintText: 'Insira sua senha...',
                        obscureText: true,
                        controller: _passwordController,
                        validator: Validator.validatePassword,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Text(
                                'Esqueceu a Senha?',
                                style:
                                    TextStyle(color: AppColors.secoundaryText),
                              ),
                            ),
                            CustomElevatedButtom(
                              label: 'Login',
                              onPressed: () async => await validateAndSignIn(),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.secoundaryBackground,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Não possui uma conta?',
                                  style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      NamedRoute.signUp,
                                    );
                                  },
                                  child: const Text(
                                    'Criar',
                                    style: TextStyle(
                                        color: AppColors.primaryGreen,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
