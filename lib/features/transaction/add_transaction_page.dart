import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _transactionDateController = TextEditingController();
  final _homeController = locator.get<HomeController>();

  DateTime? _selectedTransactionDate;

  @override
  void dispose() {
    _amountController.dispose();
    _transactionDateController.dispose();
    super.dispose();
  }

  Future<void> _selectTransactionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedTransactionDate) {
      setState(() {
        _selectedTransactionDate = picked;
        _transactionDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _addTransaction() async {
    final loan = TransactionModel(
      uid: const Uuid().v1(),
      amount: double.parse(_amountController.text),
      creditorId: _homeController.creditorModel.uid,
      creationTime: DateTime.now(),
    );
    // await _transactionController.addLoan(newLoan: loan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryGreen,
      body: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            top: 20,
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
                    'Adicionar Transação',
                    style: TextStyle(color: AppColors.primaryText, fontSize: 32),
                  ),
                  const Text(
                    'Preencha as informações abaixo',
                    style: TextStyle(color: AppColors.secoundaryText, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 340,
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
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        labelText: 'Valor da Transação',
                        hintText: 'Insira o valor...',
                        controller: _amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira um valor válido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _selectTransactionDate(context),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            labelText: 'Data da Transação',
                            hintText: 'Escolha a data da transação...',
                            controller: _transactionDateController,
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Adiciona a transação com os dados fornecidos
                                // await _transactionController.addTransaction(
                                //   amount: double.parse(_amountController.text),
                                //   transactionTime: _selectedTransactionDate ?? DateTime.now(),
                                // );
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
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
