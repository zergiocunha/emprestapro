// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures, library_private_types_in_public_api, use_super_parameters

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/enums/transaction_status.dart';
import 'package:emprestapro/common/constants/transaction_result.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_popup.dart';
import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:emprestapro/pages/home/home_controller.dart';
import 'package:emprestapro/pages/transaction/transaction_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTransactionPage extends StatefulWidget {
  final LoanModel loan;
  final TransactionModel? transaction;

  const AddTransactionPage({
    Key? key,
    required this.loan,
    this.transaction,
  }) : super(key: key);

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  final _transactionController = locator.get<TransactionController>();
  final _homeController = locator.get<HomeController>();
  final _transactionTimeController = TextEditingController();
  DateTime? _selectedTransactionTime = DateTime.now();
  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    if (isEditing) {
      _textEditingController.text = widget.transaction!.amount.toString();
      _selectedTransactionTime = widget.transaction!.transactionTime;
    }
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
      uid: isEditing ? widget.transaction!.uid : const Uuid().v1(),
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

    if (isEditing) {
      await _transactionController.update(transactionModel: transaction);
    } else {
      await _transactionController.insert(newTransaction: transaction);
    }
    if (_homeController.creditorModel.calculate!) {
      final processResult =
          Calculation.processTransaction(transaction, widget.loan, isEditing);
      await _transactionController.updateLoan(
          loan: processResult['loan'] as LoanModel);

      return processResult;
    }
    return {
      'status': TransactionStatus.succesWithoutCalculate,
      'message': "Transação realizada com sucesso!"
    };
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        title: Text(
          isEditing ? 'Editar Transação' : 'Adicionar Transação',
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DescriptionValueWidget(
                    descrtiption: 'Empréstimo',
                    value: 'R\$${widget.loan.amount!.toStringAsFixed(2)}',
                  ),
                  DescriptionValueWidget(
                    descrtiption: 'Juros',
                    value:
                        'R\$${Calculation.feesAmount(widget.loan).toStringAsFixed(2)}',
                  ),
                  DescriptionValueWidget(
                    descrtiption: 'Total',
                    value:
                        'R\$${(Calculation.feesAmount(widget.loan) + widget.loan.amount!).toStringAsFixed(2)}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                    label: isEditing ? 'Editar' : 'Adicionar',
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
