import 'package:emprestapro/common/constants/app_collors.dart';
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
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 32,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  style:
                      TextStyle(color: AppColors.secoundaryText, fontSize: 18),
                ),
                const Form(
                  child: Column(
                    children: [
                      CutomTextFormField(
                        labelText: 'Email',
                        hintText: 'Insira seu email...',
                      ),
                      CutomTextFormField(
                        labelText: 'Senha',
                        hintText: 'Insira sua senha...',
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text(
                          'Esqu]eceu a Senha?',
                          style: TextStyle(color: AppColors.secoundaryText),
                        ),
                      ),
                      CustomElevatedButtom(label: 'Login')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Container(
                    color: AppColors.secoundaryBackground,
                    height: 44,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Não possui uma conta?',
                          style: TextStyle(
                              color: AppColors.primaryText, fontSize: 14),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Criar',
                                  style: TextStyle(
                                      color: AppColors.primaryGreen,
                                      fontSize: 14),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_outlined,
                                  color: AppColors.primaryGreen,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: CustomElevatedButtom(
                      label: 'Continuar como convidado',
                      backgroundColor: AppColors.secoundaryBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/chart.png',
              // width: 200,
              // height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
