import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/address_model.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:flutter/material.dart';

class ConsumerInfoContainer extends StatefulWidget {
  final String name;
  final String? phone;
  final String? email;
  final String? pix;
  final String? status;
  final String? imageUrl;
  final AddressModel? address;

  const ConsumerInfoContainer({
    super.key,
    required this.name,
    this.phone,
    this.email,
    this.pix,
    this.status,
    this.imageUrl,
    this.address,
  });

  @override
  State<ConsumerInfoContainer> createState() => _ConsumerInfoContainerState();
}

class _ConsumerInfoContainerState extends State<ConsumerInfoContainer> {
  @override
  Widget build(BuildContext context) {
    final fullAddress =
        '${widget.address?.street ?? 'Não informado'}, ${widget.address?.city ?? 'Não informado'}, ${widget.address?.state ?? 'Não informado'}, ${widget.address?.country ?? 'Não informado'}';

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
                      value: widget.name,
                    ),
                    DescriptionValueWidget(
                      descrtiption: 'Telefone',
                      value: widget.phone ?? 'Não informado',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        foregroundImage:
                            CachedNetworkImageProvider(widget.imageUrl!),
                        child: widget.imageUrl == ''
                            ? const Icon(
                                Icons.person,
                                size: 80,
                              )
                            : null,
                      ),
                    ],
                  ),
                )
              ],
            ),
            DescriptionValueWidget(
              descrtiption: 'Email',
              value: widget.email ?? 'Não informado',
              descriptionSize: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DescriptionValueWidget(
                  descrtiption: 'Pix',
                  value: widget.pix ?? 'Não informado',
                  descriptionSize: 200,
                ),
                DescriptionValueWidget(
                  descrtiption: 'Ativo',
                  value: widget.status ?? 'Indefinido',
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
