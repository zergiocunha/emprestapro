import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Stack(
        clipBehavior: Clip.antiAlias,
        textDirection: TextDirection.ltr,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            top: 0,
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
                    style: TextStyle(color: AppColors.primaryText, fontSize: 32),
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
            top: 120,
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
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const CutomTextFormField(
                        labelText: 'Email',
                        hintText: 'Insira seu email...',
                      ),
                      const SizedBox(height: 16),
                      const CutomTextFormField(
                        labelText: 'Senha',
                        hintText: 'Insira sua senha...',
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Text(
                                'Esqueceu a Senha?',
                                style: TextStyle(
                                    color: AppColors.secoundaryText),
                              ),
                            ),
                            CustomElevatedButtom(label: 'Login')
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
