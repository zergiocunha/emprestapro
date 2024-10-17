import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_modal_bottom_sheet.dart';
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

class _ConsumersPageState extends State<ConsumersPage>
    with CustomModalSheetMixin {
  final _homeController = locator.get<HomeController>();
  final _consumerController = locator.get<ConsumerController>();
  bool? confirmDelete = false;

  @override
  Widget build(BuildContext context) {
    final List<ConsumerModel> consumers = _homeController.consumers;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  child: Dismissible(
                    key: UniqueKey(),
                    dismissThresholds: const {DismissDirection.endToStart: 0.5},
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      if (confirmDelete!) {
                        _consumerController.deleteConsumer(
                            consumerModel: consumers[index]);
                        setState(() {
                          consumers.removeAt(index);
                        });
                      }
                    },
                    confirmDismiss: (direction) async {
                      confirmDelete = await showCustomModalBottomSheet(
                        context: context,
                        content: 'Confirmar exclusão do cliente?',
                        actions: [
                          Flexible(
                            child: CustomElevatedButton(
                              label: 'Cancelar',
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Flexible(
                            child: CustomElevatedButton(
                              label: 'Confirmar',
                              onPressed: () {
                                if (mounted) {
                                  Navigator.pop(context, true);
                                }
                              },
                            ),
                          ),
                        ],
                      );

                      return confirmDelete;
                    },
                    child: ConsumerContainer(
                      consumerName: consumers[index].name ?? 'Cliente',
                      phoneNumber:
                          consumers[index].phone ?? 'Telefone não disponível',
                      email: consumers[index].email ?? 'Email não disponível',
                      imageUrl: consumers[index].photoURL!,
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          NamedRoute.consumerDetail,
                          arguments: consumers[index],
                        );
                      },
                    ),
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
