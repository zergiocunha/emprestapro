import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/features/profile/profile_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = locator.get<ProfileController>();

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
              // Foto de perfil
              GestureDetector(
                onTap: () {
                  controller.changeProfilePicture();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: controller.profilePicture != null
                      ? NetworkImage(controller.profilePicture!)
                      : null,
                  backgroundColor: AppColors.secoundaryBackground,
                  child: controller.profilePicture == null
                      ? const Icon(
                          Icons.person,
                          color: AppColors.primaryText,
                          size: 80,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              // Nome do usuário
              Text(
                controller.userName,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Botão Alterar Nome
              ProfileButton(
                icon: Icons.edit,
                text: "Alterar Nome",
                onTap: () => controller.changeName(),
              ),
              const SizedBox(height: 15),

              // Botão Alterar Senha
              ProfileButton(
                icon: Icons.lock,
                text: "Alterar Senha",
                onTap: () => controller.changePassword(),
              ),
              const SizedBox(height: 15),

              // Botão Acordos
              ProfileButton(
                icon: Icons.description,
                text: "Acordos",
                onTap: () => controller.showAgreements(),
              ),
              const SizedBox(height: 15),

              // Botão Deletar Conta
              ProfileButton(
                icon: Icons.delete,
                text: "Deletar Conta",
                onTap: () => controller.deleteAccount(),
                backgroundColor: AppColors.primaryRed,
                textColor: AppColors.primaryText,
              ),
              const SizedBox(height: 15),

              // Botão Sair
              ProfileButton(
                icon: Icons.logout,
                text: "Sair",
                onTap: () => {
                  controller.logOut(),
                  Navigator.pushNamed(context, NamedRoute.signIn),
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
