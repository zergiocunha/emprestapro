// ignore_for_file: type_literal_in_constant_pattern, use_build_context_synchronously

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/utils/validator.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/pages/sign_up/sign_up_controller.dart';
import 'package:emprestapro/pages/sign_up/sign_up_state.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signUpController = locator.get<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _signUpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signUpController.addListener(_handleSignUpstateChange);
    _signUpController.setPageController = PageController();
  }

  void _handleSignUpstateChange() {
    final state = _signUpController.state;
    switch (state.runtimeType) {
      case SignUpLoadingState:
        showDialog(
          context: context,
          builder: (context) => const CircularProgressIndicator(),
        );
        break;
      case SignUpSuccessState:
        break;
      case SignUpErrorState:
        Navigator.pop(context);
        break;
    }
  }

  validateAndSignUp() async {
    final valid =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (valid) {
      final logged = await _signUpController.signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (logged) {
        Navigator.popAndPushNamed(
          context,
          NamedRoute.home,
        );
      }
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
            top: -80,
            left: 0,
            right: 250,
            child: SizedBox(
              child: Image.asset('assets/images/black_circle.png'),
            ),
          ),
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            child: SizedBox(
              child: Image.asset('assets/images/black_cilinder.png'),
            ),
          ),
          Positioned(
            top: -80,
            left: 200,
            right: 0,
            child: SizedBox(
              child: Image.asset('assets/images/black_cilinder.png'),
            ),
          ),
          const Positioned(
            top: 80,
            left: 150,
            right: 0,
            child: Text(
              'Cadastrar',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          CustomTextFormField(
                            controller: _nameController,
                            labelText: 'Nome',
                            hintText: 'Seu nome',
                            fillColor: AppColors.secoundaryBackground,
                            validator: Validator.validateName,
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: 'Seu email',
                            fillColor: AppColors.secoundaryBackground,
                            validator: Validator.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            labelText: 'Escolha uma senha',
                            hintText: '********',
                            fillColor: AppColors.secoundaryBackground,
                            validator: Validator.validatePassword,
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            obscureText: true,
                            labelText: 'Confirme a senha',
                            hintText: '********',
                            fillColor: AppColors.secoundaryBackground,
                            validator: (value) =>
                                Validator.validatePasswordConfirmation(
                              value,
                              _passwordController.text,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomElevatedButton(
                            label: 'Cadastrar',
                            size: 200,
                            onPressed: () async {
                              await validateAndSignUp();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 64,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Já possui uma conta?',
                              style: TextStyle(color: AppColors.secoundaryText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
