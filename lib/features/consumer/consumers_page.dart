import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/features/consumer/consumer_controller.dart';
import 'package:emprestapro/features/consumer/widgets/consumer_container.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class ConsumersPage extends StatefulWidget {
  const ConsumersPage({super.key});

  @override
  State<ConsumersPage> createState() => _ConsumersPageState();
}

class _ConsumersPageState extends State<ConsumersPage> {
  final _consumerController = locator.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    final List<ConsumerModel> consumers = _consumerController.consumers;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        shadowColor: AppColors.secoundaryBackground,
        title: const Text(
          'Clientes',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16, bottom: 10),
              itemCount: consumers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConsumerContainer(
                    consumerName: consumers[index].name ?? 'Cliente',
                    phoneNumber: consumers[index].phone ?? 'Telefone não disponível',
                    email: consumers[index].email ?? 'Email não disponível',
                    imageUrl: consumers[index].imageUrl!,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
