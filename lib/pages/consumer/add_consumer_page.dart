// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/address_model.dart';
import 'package:emprestapro/common/utils/data_manipulation.dart';
import 'package:emprestapro/common/utils/validator.dart';
import 'package:emprestapro/pages/consumer/consumer_controller.dart';
import 'package:emprestapro/pages/home/home_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:uuid/uuid.dart';

class AddConsumerPage extends StatefulWidget {
  final ConsumerModel? consumer;

  const AddConsumerPage({
    super.key,
    this.consumer,
  });

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
  final _consumerController = locator.get<ConsumerController>();
  final _homeController = locator.get<HomeController>();

  bool get isEditing => widget.consumer != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameController.text = widget.consumer!.name ?? '';
      _phoneController.text = formatPhoneNumber(widget.consumer!.phone);
      _emailController.text = widget.consumer!.email ?? '';
      _pixController.text = widget.consumer!.pix ?? '';
      _streetController.text = widget.consumer!.address!.street ?? '';
      _cityController.text = widget.consumer!.address!.city ?? '';
      _stateController.text = widget.consumer!.address!.state ?? '';
      _zipCodeController.text = widget.consumer!.address!.zipCode ?? '';
    }
  }

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

  String formatPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return '';
    } else {
      return DataManipulation.formatPhoneNumber(phoneNumber);
    }
  }

  Future<void> _addConsumer(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final newConsumer = ConsumerModel(
        uid: isEditing ? widget.consumer!.uid : const Uuid().v4(),
        creditorId: _homeController.creditorModel.uid,
        name: _nameController.text,
        pix: _pixController.text,
        phone: DataManipulation.removePhoneNumberFormatting(
          _phoneController.text,
        ),
        photoURL: '',
        email: _emailController.text,
        creationTime: DateTime.now(),
        updateTime: DateTime.now(),
        active: true,
        address: AddressModel(
          street: _streetController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipCodeController.text,
        ),
      );
      if (isEditing) {
        await _consumerController.update(consumerModel: newConsumer);
        setState(() {});
        Navigator.popAndPushNamed(context, NamedRoute.home);
      } else {
        await _consumerController.insert(newConsumer: newConsumer);
        setState(() {});
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secoundaryBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        title: Text(
          isEditing ? 'Editar Consumidor' : 'Adicionar Consumidor',
          style: const TextStyle(
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  keyboardType: TextInputType.name,
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
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Insira uma chave PIX válida';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  labelText: 'Telefone',
                  hintText: 'Insira o telefone...',
                  controller: _phoneController,
                  validator: (value) {
                    if (Validator.isValidPhoneNumber(value!)) {
                      return null;
                    }
                    return 'Insira um telefone válido';
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  hintText: 'Insira o email...',
                  controller: _emailController,
                  // validator: (value) {
                  //   if (value == null ||
                  //       value.isEmpty ||
                  //       !value.contains('@')) {
                  //     return 'Insira um email válido';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  keyboardType: TextInputType.streetAddress,
                  labelText: 'Rua',
                  hintText: 'Insira o nome da rua...',
                  controller: _streetController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Insira uma rua válida';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  keyboardType: TextInputType.streetAddress,
                  labelText: 'Cidade',
                  hintText: 'Insira a cidade...',
                  controller: _cityController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Insira uma cidade válida';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  keyboardType: TextInputType.streetAddress,
                  labelText: 'Estado',
                  hintText: 'Insira o estado...',
                  controller: _stateController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Insira um estado válido';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  labelText: 'CEP',
                  hintText: 'Insira o CEP...',
                  controller: _zipCodeController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Insira um CEP válido';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 32),
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
                      label: isEditing ? 'Editar' : 'Adicionar',
                      onPressed: () async => await _addConsumer(context),
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
