import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/address_model.dart';
import 'package:flutter/material.dart';

class ConsumerInfoContainer extends StatefulWidget {
  final String name;
  final String? phone;
  final String? email;
  final String? pix;
  final String? status;
  final AddressModel? address;

  const ConsumerInfoContainer({
    super.key,
    required this.name,
    this.phone,
    this.email,
    this.pix,
    this.status,
    this.address,
  });

  @override
  State<ConsumerInfoContainer> createState() => _ConsumerInfoContainerState();
}

class _ConsumerInfoContainerState extends State<ConsumerInfoContainer> {
  @override
  Widget build(BuildContext context) {
    final fullAddress = '${widget.address?.street ?? 'Não informado'}, ${widget.address?.city ?? 'Não informado'}, ${widget.address?.state ?? 'Não informado'}, ${widget.address?.country ?? 'Não informado'}';

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
              children: [
                const Text(
                  'Nome:',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Telefone:',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.phone ?? 'Não informado',
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.email ?? 'Não informado',
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Pix:',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.pix ?? 'Não informado',
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Ativo:',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.status ?? 'Indefinido',
                    style: TextStyle(
                      color: widget.status == 'Sim'
                          ? AppColors.primaryGreen
                          : AppColors.primaryRed,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Endereço:',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    fullAddress,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
