// ignore_for_file: use_build_context_synchronously

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/profile/profile_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = locator.get<ProfileController>();
    final homeController = locator.get<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  profileController
                      .pickAndUploadImage(homeController.creditorModel.uid!);
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: homeController.creditorModel.photoURL != null
                      ? NetworkImage(homeController.creditorModel.photoURL!)
                      : null,
                  backgroundColor: AppColors.secoundaryBackground,
                  child: homeController.creditorModel.photoURL == null
                      ? const Icon(
                          Icons.person,
                          color: AppColors.primaryText,
                          size: 80,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                homeController.creditorModel.name ?? 'Não informado',
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ProfileButton(
                icon: Icons.edit,
                text: "Alterar Nome",
                onTap: () => profileController.changeName(),
              ),
              const SizedBox(height: 15),
              ProfileButton(
                icon: Icons.lock,
                text: "Alterar Senha",
                onTap: () => profileController.changePassword(),
              ),
              const SizedBox(height: 15),
              ProfileButton(
                icon: Icons.message,
                text: "Alterar Mensagem Padrão",
                onTap: () async {
                  await Navigator.pushNamed(context, NamedRoute.editMessage);
                },
              ),
              const SizedBox(height: 15),
              ProfileButton(
                icon: Icons.description,
                text: "Acordos",
                onTap: () => profileController.showAgreements(),
              ),
              const SizedBox(height: 15),
              ProfileButton(
                icon: Icons.delete,
                text: "Deletar Conta",
                onTap: () => profileController.deleteAccount(),
                backgroundColor: AppColors.primaryRed,
                textColor: AppColors.primaryText,
              ),
              const SizedBox(height: 15),
              ProfileButton(
                icon: Icons.logout,
                text: "Sair",
                onTap: () async {
                  await profileController.logOut();
                  profileController.dispose();
                  homeController.clearData();
                  Navigator.pushNamed(context, NamedRoute.signIn);
                },
                backgroundColor: AppColors.primaryRed,
                textColor: AppColors.primaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const ProfileButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
      ),
      icon: Icon(icon, color: textColor ?? AppColors.primaryText, size: 24),
      label: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onTap,
    );
  }
}
