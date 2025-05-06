import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/address_model.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/utils/data_manipulation.dart';
import 'package:emprestapro/common/utils/validator.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CustomConsumerModal extends StatefulWidget {
  final bool isEditing;
  final String creditorId;
  final ConsumerModel? consumer;

  const CustomConsumerModal({
    super.key,
    required this.creditorId,
    required this.isEditing,
    this.consumer,
  });

  @override
  State<CustomConsumerModal> createState() => _CustomConsumerModalState();
}

class _CustomConsumerModalState extends State<CustomConsumerModal> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _pixController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  bool get isEditing => widget.consumer != null;

  Future<ConsumerModel?> addConsumer(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final newConsumer = ConsumerModel(
        uid: isEditing ? widget.consumer!.uid : const Uuid().v4(),
        creditorId: widget.creditorId,
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
      Navigator.pop(context, newConsumer);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                keyboardType: TextInputType.streetAddress,
                labelText: 'Rua',
                hintText: 'Insira o nome da rua...',
                controller: _streetController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                keyboardType: TextInputType.streetAddress,
                labelText: 'Cidade',
                hintText: 'Insira a cidade...',
                controller: _cityController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                keyboardType: TextInputType.streetAddress,
                labelText: 'Estado',
                hintText: 'Insira o estado...',
                controller: _stateController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                labelText: 'CEP',
                hintText: 'Insira o CEP...',
                controller: _zipCodeController,
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
                    label: 'Adicionar',
                    onPressed: () async => await addConsumer(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
