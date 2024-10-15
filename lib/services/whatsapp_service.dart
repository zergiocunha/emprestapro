// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

class WhatsAppService {
  final String accountSid = 'US13440268d71040bfa9cbc3befae9c594';
  final String authToken = '55f6dea4611912d439517485a5659404';
  final String twilioWhatsAppNumber = 'whatsapp:+14155238886';

  Future<void> sendWhatsAppMessage({
    required String toPhoneNumber,
    required String contentSid,
    required Map<String, String> contentVariables,
  }) async {
    final String url =
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

    final Map<String, dynamic> body = {
      'From': twilioWhatsAppNumber,
      'To': 'whatsapp:+$toPhoneNumber',
      'ContentSid': contentSid,
      'ContentVariables': jsonEncode(contentVariables),
    };

    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken'));

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print('Message sent successfully: ${response.body}');
      } else {
        print(
            'Failed to send message: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending WhatsApp message: $e');
    }
  }
}
