import 'dart:io';

import 'package:emprestapro/common/utils/data_manipulation.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  Future<String> send({
    required String phoneNumber,
    required String message,
  }) async {
    String androidUrl = DataManipulation.androidUrl(
        phoneNumber: phoneNumber, message: message);
    String iosUrl =
        DataManipulation.iosUrl(phoneNumber: phoneNumber, message: message);
    String webUrl =
        DataManipulation.webUrl(phoneNumber: phoneNumber, message: message);

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(
            Uri.parse(iosUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw 'launch by web';
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(
            Uri.parse(androidUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw 'launch by web';
        }
      }
      return 'success';
    } catch (e) {
      await launchUrl(
        Uri.parse(webUrl),
        mode: LaunchMode.externalApplication,
      );
      return 'success';
    }
  }
}
