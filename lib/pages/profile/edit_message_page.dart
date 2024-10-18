// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/pages/home/home_controller.dart';
import 'package:emprestapro/pages/profile/profile_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class EditMessagePage extends StatefulWidget {
  const EditMessagePage({super.key});

  @override
  _EditMessagePageState createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage> {
  final TextEditingController _messageController = TextEditingController();
  final homeController = locator.get<HomeController>();
  final profileController = locator.get<ProfileController>();

  @override
  void initState() {
    super.initState();
    _loadTemplate();
  }

  Future<void> _loadTemplate() async {
    _messageController.text = homeController.creditorModel.message ?? '';
  }

  Future<void> _saveTemplate() async {
    await profileController.changeMessageTemplate(
      creditorModel: homeController.creditorModel,
      template: _messageController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secoundaryBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        title: const Text(
          'Editar Mensagem Padrão',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.background3D,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomTextFormField(
              keyboardType: TextInputType.text,
              labelText: 'Insira uma nova mensagem...',
              hintText: 'Insira uma nova mensagem...',
              controller: _messageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira uma mensagem válida';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  label: 'Cancelar',
                  backgroundColor: AppColors.secoundaryRed,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CustomElevatedButton(
                  label: 'Salvar',
                  onPressed: () async {
                    await _saveTemplate();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
