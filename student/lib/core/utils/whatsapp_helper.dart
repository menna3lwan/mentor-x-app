import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static const String supportNumber = '201127798986';

  static Future<void> openSupport() async {
    final uri = Uri.parse('https://wa.me/$supportNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
