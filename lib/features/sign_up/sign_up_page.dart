import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 200, // Início fora da tela (ou abaixo da tela)
      end: 0, // Posição original
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Iniciar a animação ao abrir o widget
    _controller.forward();
  }

  @override
  void dispose() {
    // Libera o AnimationController imediatamente
    _controller.dispose();

    // Certifica-se de chamar o super.dispose() diretamente
    super.dispose();
  }

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
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
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
                          const Form(
                            child: Column(
                              children: [
                                SizedBox(height: 32),
                                CutomTextFormField(
                                  labelText: 'Nome',
                                  hintText: 'Seu nome',
                                  fillColor: AppColors.secoundaryBackground,
                                ),
                                SizedBox(height: 16),
                                CutomTextFormField(
                                  labelText: 'Email',
                                  hintText: 'Seu email',
                                  fillColor: AppColors.secoundaryBackground,
                                ),
                                SizedBox(height: 16),
                                CutomTextFormField(
                                  labelText: 'Escolha uma senha',
                                  hintText: 'Escolha uma senha',
                                  fillColor: AppColors.secoundaryBackground,
                                ),
                                SizedBox(height: 16),
                                CutomTextFormField(
                                  labelText: 'Confirme a senha',
                                  hintText: 'Confirme a senha',
                                  fillColor: AppColors.secoundaryBackground,
                                ),
                                SizedBox(height: 16),
                                CustomElevatedButtom(
                                  label: 'Cadastrar',
                                  size: 200,
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
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.reverse().then((_) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text(
                                      'Já possui uma conta?',
                                      style: TextStyle(
                                          color: AppColors.secoundaryText),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
