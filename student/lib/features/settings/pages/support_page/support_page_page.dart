import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final channels = [
      (
        Icons.chat_rounded,
        t['whatsapp'] ?? 'WhatsApp',
        '01012345678',
        AppColors.whatsAppGreen,
      ),
      (
        Icons.phone_rounded,
        t['phoneCall'] ?? 'Phone Call',
        '01012345678',
        AppColors.primary,
      ),
      (
        Icons.email_outlined,
        t['email'] ?? 'Email',
        'support@mentorx.com',
        AppColors.accent,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: Text(
          t['supportTitle'] ?? 'Support',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Support icon with ring
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.success,
                    AppColors.teal,
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.headset_mic_rounded,
                  size: 40,
                  color: AppColors.success,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              t['supportTitle'] ?? 'Support',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t['supportDesc'] ?? 'We are here to help you',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.greyDark,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Contact channels
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(channels.length, (i) {
                  final (icon, label, value, color) = channels[i];
                  final isLast = i == channels.length - 1;
                  return Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // TODO: launch URL/phone/email
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(icon, size: 22, color: color),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        label,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyDark,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: AppColors.greyDark.withValues(alpha: 0.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 0.8,
                          indent: 64,
                          color: AppColors.greyLight.withValues(alpha: 0.5),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
