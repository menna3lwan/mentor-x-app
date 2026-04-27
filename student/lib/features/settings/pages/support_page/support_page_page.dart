import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

enum _SupportChannelType { whatsapp, phone, email }

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final channels = [
      (
        _SupportChannelType.whatsapp,
        Icons.chat_rounded,
        t['whatsapp'] ?? 'WhatsApp',
        '01012345678',
        const Color(0xFF25D366),
      ),
      (
        _SupportChannelType.phone,
        Icons.phone_rounded,
        t['phoneCall'] ?? 'Phone Call',
        '01012345678',
        palette.brandPrimary,
      ),
      (
        _SupportChannelType.email,
        Icons.email_outlined,
        t['email'] ?? 'Email',
        'support@mentorx.com',
        palette.brandSecondary,
      ),
    ];

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: palette.brandPrimary,
            title: Text(
              t['supportTitle'] ?? 'Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Gap(12),

            // Support icon with ring
            ZoomIn(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      palette.statusSuccess,
                      palette.brandPrimary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: palette.brandPrimary.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: palette.backgroundPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.headset_mic_rounded,
                    size: 52,
                    color: palette.statusSuccess,
                  ),
                ),
              ),
            ),
            const Gap(24),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Column(
                children: [
                  Text(
                    t['supportTitle'] ?? 'Support Center',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    t['supportDesc'] ?? 'We are here to help you around the clock',
                    style: TextStyle(
                      fontSize: 15,
                      color: palette.textSecondary,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Gap(32),

            // Contact channels
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: Container(
                decoration: BoxDecoration(
                  color: palette.backgroundPrimary,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(channels.length, (i) {
                    final (type, icon, label, value, color) = channels[i];
                    final isLast = i == channels.length - 1;
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await _openSupportChannel(
                                context: context,
                                type: type,
                                value: value,
                              );
                            },
                            borderRadius: BorderRadius.circular(28),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(icon, size: 24, color: color),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          label,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: palette.textPrimary,
                                          ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: palette.textSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: palette.textTertiary.withValues(alpha: 0.4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1.5,
                            indent: 72,
                            endIndent: 20,
                            color: palette.backgroundSecondary,
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openSupportChannel({
    required BuildContext context,
    required _SupportChannelType type,
    required String value,
  }) async {
    final uri = switch (type) {
      _SupportChannelType.whatsapp => Uri.parse(
          'https://wa.me/${value.replaceAll(RegExp(r'[^0-9]'), '')}',
        ),
      _SupportChannelType.phone => Uri(
          scheme: 'tel',
          path: value.replaceAll(RegExp(r'[^0-9+]'), ''),
        ),
      _SupportChannelType.email => Uri(
          scheme: 'mailto',
          path: value,
          queryParameters: {'subject': 'MentorX Support'},
        ),
    };

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open support channel.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
