import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/enums/transaction_status.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/features/transaction/transaction_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importando para formatação de data
import 'package:uuid/uuid.dart';

class AddTransactionPage extends StatefulWidget {
  final LoanModel loan;

  const AddTransactionPage({
    super.key,
    required this.loan,
  });

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _transactionController = locator.get<TransactionController>();
  final _transactionTimeController = TextEditingController();
  DateTime? _selectedTransactionTime;

  @override
  void dispose() {
    _amountController.dispose();
    _transactionTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTransactionTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedTransactionTime) {
      setState(() {
        _selectedTransactionTime = picked;
        _transactionTimeController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<bool> _addTransaction() async {
    final transaction = TransactionModel(
      uid: const Uuid().v1(),
      consumerId: widget.loan.consumerId,
      creditorId: widget.loan.creditorId,
      loanId: widget.loan.uid,
      amount: double.parse(_amountController.text),
      transactionTime: _selectedTransactionTime ?? DateTime.now(), // Usa a data selecionada ou agora
      creationTime: DateTime.now(),
      status: TransactionStatus.pending,
    );

    await _transactionController.addTransaction(newTransaction: transaction);
    final processedLoan = Calculation.processTransaction(transaction.amount!, widget.loan);
    await _transactionController.updateLoan(loan: processedLoan);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secoundaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        title: const Text(
          'Adicionar Transação',
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
              CustomTextFormField(
                labelText: 'ID do Consumidor',
                hintText: 'Insira o ID do consumidor...',
                controller: TextEditingController()..text = widget.loan.consumerId ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um ID válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'ID do Credor',
                hintText: 'Insira o ID do credor...',
                controller: TextEditingController()..text = widget.loan.creditorId ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um ID válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'ID do Empréstimo',
                hintText: 'Insira o ID do empréstimo...',
                controller: TextEditingController()..text = widget.loan.uid ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um ID válido';
                  }
                  return null;
                },
              ),
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
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectTransactionTime(context),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    labelText: 'Data da Transação',
                    hintText: 'Escolha a data da transação...',
                    controller: _transactionTimeController,
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
                        final success = await _addTransaction();
                        Navigator.pop(context, success);
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
