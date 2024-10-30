import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/utils/data_manipulation.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:flutter/material.dart';

class ConsumerInfoContainer extends StatefulWidget {
  final ConsumerModel consumerModel;

  const ConsumerInfoContainer({
    super.key,
    required this.consumerModel,
  });

  @override
  State<ConsumerInfoContainer> createState() => _ConsumerInfoContainerState();
}

class _ConsumerInfoContainerState extends State<ConsumerInfoContainer> {
  @override
  Widget build(BuildContext context) {
    final fullAddress =
        '${widget.consumerModel.address?.street ?? 'Não informado'}, ${widget.consumerModel.address?.city ?? 'Não informado'}, ${widget.consumerModel.address?.state ?? 'Não informado'}, ${widget.consumerModel.address?.country ?? 'Não informado'}';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppColors.background3D,
        boxShadow: const [
          BoxShadow(
            color: AppColors.secoundaryBackground,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    DescriptionValueWidget(
                      descrtiption: 'Nome',
                      value: widget.consumerModel.name!,
                    ),
                    DescriptionValueWidget(
                      descrtiption: 'Telefone',
                      value: DataManipulation.formatPhoneNumber(
                        widget.consumerModel.phone.toString(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        foregroundImage: widget.consumerModel.photoURL == ''
                            ? null
                            : CachedNetworkImageProvider(
                                widget.consumerModel.photoURL!),
                        child: widget.consumerModel.photoURL == ''
                            ? const Icon(
                                Icons.person,
                                size: 80,
                              )
                            : null,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          NamedRoute.addConsumer,
                          arguments: widget.consumerModel,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.primaryText,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            DescriptionValueWidget(
              descrtiption: 'Email',
              value: widget.consumerModel.email ?? 'Não informado',
              descriptionSize: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DescriptionValueWidget(
                  descrtiption: 'Pix',
                  value: widget.consumerModel.pix ?? 'Não informado',
                  descriptionSize: 200,
                ),
                DescriptionValueWidget(
                  descrtiption: 'Ativo',
                  value: widget.consumerModel.active! ? 'Ativo' : 'Inativo',
                ),
              ],
            ),
            DescriptionValueWidget(
              descrtiption: 'Endereço',
              value: fullAddress,
              descriptionSize: 300,
            ),
          ],
        ),
      ),
    );
  }
}
