import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static const String supportNumber = '201127798986';

  static Future<void> openSupport() async {
    await openByPhone(phoneNumber: supportNumber);
  }

  static Future<void> openByPhone({
    required String phoneNumber,
    String? message,
  }) async {
    final normalized = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (normalized.isEmpty) {
      return;
    }

    final text = message?.trim();
    final uri = text == null || text.isEmpty
        ? Uri.parse('https://wa.me/$normalized')
        : Uri.parse(
            'https://wa.me/$normalized?text=${Uri.encodeComponent(text)}',
          );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
