import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.photoUrl,
    required this.displayName,
    required this.amount,
  });

  final String photoUrl;
  final String displayName;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: AppColors.secoundaryBackground,
        gradient: AppColors.background3D,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: photoUrl != ''
                      ? CachedNetworkImageProvider(
                          photoUrl,
                        )
                      : null,
                  child: photoUrl == ''
                      ? const Icon(
                          Icons.person,
                          color: AppColors.primaryText,
                          size: 40,
                        )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Bem vindo, ',
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            displayName,
                            style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 230,
                        child: AutoSizeText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          'Os detalhes da sua conta estão abaixo',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Total Emprestado',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'R\$' '${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
