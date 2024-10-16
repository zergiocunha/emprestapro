import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  Future<String> send({
    required String phoneNumber,
    required String message,
  }) async {
    final Uri url =
        Uri.parse("https://api.whatsapp.com/send?phone=55$phoneNumber&text=$message");

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
        return 'success';
      } else {
        print("Could not launch WhatsApp URL");
        return 'Could not launch WhatsApp';
      }
    } catch (e) {
      print('Erro ao enviar WhatsApp: $e');
      return 'error: $e';
    }
  }
}
