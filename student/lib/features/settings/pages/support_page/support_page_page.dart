import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});
  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final channels = [
      (Icons.chat, t['whatsapp']!, '01012345678', AppColors.green),
      (Icons.phone, t['phoneCall']!, '01012345678', AppColors.primary),
      (
        Icons.email_outlined,
        t['email']!,
        'support@mentorx.com',
        AppColors.accent,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['supportTitle']!,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.headset_mic,
                size: 48,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t['supportTitle']!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t['supportDesc']!,
              style: TextStyle(fontSize: 13, color: AppColors.greyDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ...channels.map((ch) {
              final (icon, label, value, color) = ch;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
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
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.greyDark,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.greyDark,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
