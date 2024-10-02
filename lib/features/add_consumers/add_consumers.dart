import 'package:emprestapro/common/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:uuid/uuid.dart';

class AddConsumerPage extends StatefulWidget {
  const AddConsumerPage({Key? key}) : super(key: key);

  @override
  _AddConsumerPageState createState() => _AddConsumerPageState();
}

class _AddConsumerPageState extends State<AddConsumerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pixController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _pixController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _addConsumer(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final newConsumer = ConsumerModel(
        uid: Uuid().v4(),
        name: _nameController.text,
        pix: _pixController.text,
        phone: _phoneController.text,
        imageUrl: '',
        email: _emailController.text,
        creationTime: DateTime.now(),
        updateTime: DateTime.now(),
        loanIds: [],
        active: true,
        address: AddressModel(
          street: _streetController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipCodeController.text,
        ),
      );

      Navigator.pop(context); // Volta para a tela anterior após adicionar o consumidor
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        title: const Text(
          'Adicionar Cliente',
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
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'Nome',
                  hintText: 'Insira o nome do cliente...',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um nome válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'PIX',
                  hintText: 'Insira a chave PIX...',
                  controller: _pixController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma chave PIX válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Telefone',
                  hintText: 'Insira o telefone...',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um telefone válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Email',
                  hintText: 'Insira o email...',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Insira um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Rua',
                  hintText: 'Insira o nome da rua...',
                  controller: _streetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma rua válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Cidade',
                  hintText: 'Insira a cidade...',
                  controller: _cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma cidade válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Estado',
                  hintText: 'Insira o estado...',
                  controller: _stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um estado válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'CEP',
                  hintText: 'Insira o CEP...',
                  controller: _zipCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um CEP válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      label: 'Cancelar',
                      backgroundColor: AppColors.primaryRed,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomElevatedButton(
                      label: 'Adicionar',
                      onPressed: () => _addConsumer(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
