// ignore_for_file: use_build_context_synchronously

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/widgets/custom_dropdown.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/loan/loan_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddLoanPage extends StatefulWidget {
  const AddLoanPage({super.key});

  @override
  State<AddLoanPage> createState() => _AddLoanPageState();
}

class _AddLoanPageState extends State<AddLoanPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _loanController = locator.get<LoanController>();
  final _homeController = locator.get<HomeController>();

  ConsumerModel? _selectedConsumer;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _interestRateController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  void getData() async {
    await _loanController.getUserData();
    await _loanController.getCreditorData();
    await _loanController.getConsumerList();
    if (mounted) setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dueDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _navigateToAddConsumer() async {
    await Navigator.pushNamed(context, NamedRoute.addConsumer);
    getData();
  }

  Future<void> _addLoan() async {
    final loan = LoanModel(
      uid: const Uuid().v1(),
      consumerId: _selectedConsumer?.uid,
      amount: double.parse(_amountController.text),
      creditorId: _loanController.creditorModel.uid,
      fees: double.parse(_interestRateController.text),
      dueDate: _selectedDate,
      creationTime: DateTime.now(),
      concluded: false,
    );
    await _loanController.addLoan(newLoan: loan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secoundaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        title: const Text(
          'Adicionar Empréstimo',
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomDropdownButtonFormField<ConsumerModel>(
                labelText: 'Selecione o Cliente',
                value: _selectedConsumer,
                items: _loanController.consumersList.map((consumer) {
                  return DropdownMenuItem<ConsumerModel>(
                    value: consumer,
                    child: Text(consumer.name!),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedConsumer = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um cliente';
                  }
                  return null;
                },
              ),
              TextButton(
                onPressed: () async {
                 await _navigateToAddConsumer();
                },
                child: const Text(
                  'Adicionar Novo Cliente',
                  style: TextStyle(color: AppColors.primaryGreen),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'Valor do Empréstimo',
                hintText: 'Insira o valor...',
                controller: _amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um valor válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'Taxa de Juros (%)',
                hintText: 'Insira a taxa de juros...',
                controller: _interestRateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma taxa de juros válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    labelText: 'Data de Vencimento',
                    hintText: 'Escolha a data de vencimento...',
                    controller: _dueDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Escolha uma data válida';
                      }
                      return null;
                    },
                  ),
                ),
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
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await _addLoan();
                        Navigator.pop(context);
                        _homeController.jumpToHomePage();
                      }
                    },
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
