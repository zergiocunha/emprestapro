// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/enums/transaction_status.dart';
import 'package:emprestapro/common/constants/transaction_result.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_popup.dart';
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
  final _textEditingController = TextEditingController();
  final _transactionController = locator.get<TransactionController>();
  final _transactionTimeController = TextEditingController();
  DateTime? _selectedTransactionTime = DateTime.now();

  @override
  void initState() {
    _transactionTimeController.text =
        DateFormat('dd/MM/yyyy').format(_selectedTransactionTime!);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
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
        _transactionTimeController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<Map<String, dynamic>> _addTransaction() async {
    final transaction = TransactionModel(
      uid: const Uuid().v1(),
      consumerId: widget.loan.consumerId,
      creditorId: widget.loan.creditorId,
      loanId: widget.loan.uid,
      amount: double.parse(_textEditingController.text),
      transactionTime: _selectedTransactionTime ?? DateTime.now(),
      creationTime: DateTime.now(),
    );

    if (_transactionIsNotValid(transaction, widget.loan)) {
      return {
        'status': TransactionStatus.invalid,
        'message': TransactionResult.invalid
      };
    }

    await _transactionController.addTransaction(newTransaction: transaction);
    final processResult =
        Calculation.processTransaction(transaction, widget.loan);
    await _transactionController.updateLoan(
        loan: processResult['loan'] as LoanModel);

    return processResult;
  }

  _transactionIsNotValid(
    TransactionModel transaction,
    LoanModel loan,
  ) {
    if (transaction.amount! <= (loan.amount! + Calculation.feesAmount(loan))) {
      return false;
    }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 340,
                    child: AutoSizeText(
                      'Empréstimo: R\$${widget.loan.amount!.toStringAsFixed(2)}  |  Juros: R\$${Calculation.feesAmount(widget.loan).toStringAsFixed(2)}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                labelText: 'Valor da Transação',
                hintText: 'Insira o valor...',
                controller: _textEditingController,
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
                    keyboardType: TextInputType.datetime,
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
                        final transactionResult = await _addTransaction();
                        await popup(
                          context: context,
                          title: 'Resultado da Transação',
                          message: transactionResult['message'],
                          backgroundColor: transactionResult['status'] ==
                                  TransactionStatus.invalid
                              ? AppColors.secondaryRed
                              : null,
                        );
                        if (transactionResult['status'] !=
                            TransactionStatus.invalid)
                          Navigator.pop(context, true);
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
