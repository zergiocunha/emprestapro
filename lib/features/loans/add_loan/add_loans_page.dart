// import 'package:emprestapro/common/constants/app_collors.dart';
// import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
// import 'package:emprestapro/common/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AddLoanPage extends StatefulWidget {
//   const AddLoanPage({super.key});

//   @override
//   State<AddLoanPage> createState() => _AddLoanPageState();
// }

// class _AddLoanPageState extends State<AddLoanPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _interestRateController = TextEditingController();
//   final _dueDateController = TextEditingController();
//   // final _addLoanController = locator.get<AddLoanController>();

//   DateTime? _selectedDate;

//   @override
//   void dispose() {
//     _amountController.dispose();
//     _interestRateController.dispose();
//     _dueDateController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _dueDateController.text = DateFormat('yyyy-MM-dd').format(picked);
//       });
//     }
//   }

//   Future<void> validateAndAddLoan() async {
//     final valid = _formKey.currentState?.validate() ?? false;
//     if (valid) {
//       // await _addLoanController.addLoan(
//       //   amount: double.parse(_amountController.text),
//       //   interestRate: double.parse(_interestRateController.text),
//       //   dueDate: _selectedDate ?? DateTime.now(),
//       // );

//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.primaryGreen,
//       body: Stack(
//         clipBehavior: Clip.antiAlias,
//         // textDirection: TextDirection.LTR,
//         alignment: AlignmentDirectional.topCenter,
//         children: [
//           Positioned(
//             top: 20,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 64),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/logo_nome.png',
//                         width: 200,
//                         height: 100,
//                       ),
//                     ],
//                   ),
//                   const Text(
//                     'Adicionar Empréstimo',
//                     style:
//                         TextStyle(color: AppColors.primaryText, fontSize: 32),
//                   ),
//                   const Text(
//                     'Preencha as informações abaixo',
//                     style: TextStyle(
//                         color: AppColors.secoundaryText, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 340,
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 16,
//                   right: 16,
//                   top: 32,
//                   bottom: 64,
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 16),
//                       CustomTextFormField(
//                         labelText: 'Valor do Empréstimo',
//                         hintText: 'Insira o valor...',
//                         controller: _amountController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Insira um valor válido';
//                           }
//                           return null;
//                         },
//                         // keyboardType: TextInputType.number,
//                       ),
//                       const SizedBox(height: 16),
//                       CustomTextFormField(
//                         labelText: 'Taxa de Juros (%)',
//                         hintText: 'Insira a taxa de juros...',
//                         controller: _interestRateController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Insira uma taxa de juros válida';
//                           }
//                           return null;
//                         },
//                         // keyboardType: TextInputType.number,
//                       ),
//                       const SizedBox(height: 16),
//                       GestureDetector(
//                         onTap: () => _selectDate(context),
//                         child: AbsorbPointer(
//                           child: CustomTextFormField(
//                             labelText: 'Data de Vencimento',
//                             hintText: 'Escolha a data de vencimento...',
//                             controller: _dueDateController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Escolha uma data válida';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 32),
//                         child: CustomElevatedButtom(
//                           label: 'Adicionar',
//                           onPressed: () async => await validateAndAddLoan(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
