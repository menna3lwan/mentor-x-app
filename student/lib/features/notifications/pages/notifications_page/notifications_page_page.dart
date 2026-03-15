import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _readSet = <int>{};

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final notifications = [
      (
        Icons.quiz,
        t['quizCorrected']!,
        'Unit 3 Quiz - 18/20',
        t['minutesAgo']!.replaceAll('%s', '15'),
        AppColors.accent,
        true,
      ),
      (
        Icons.assignment,
        t['newAssignment']!,
        'Unit 4 - Waves Assignment',
        t['hoursAgo']!.replaceAll('%s', '2'),
        AppColors.primary,
        true,
      ),
      (
        Icons.schedule,
        t['sessionReminder']!,
        'Session 8 tomorrow at 4 PM',
        t['hoursAgo']!.replaceAll('%s', '5'),
        AppColors.success,
        true,
      ),
      (
        Icons.account_balance_wallet,
        t['walletCharged']!,
        '+200 EGP via Vodafone Cash',
        t['daysAgo']!.replaceAll('%s', '1'),
        AppColors.green,
        false,
      ),
      (
        Icons.warning_amber,
        t['absenceAlert']!,
        'You were marked absent Session 7',
        t['daysAgo']!.replaceAll('%s', '2'),
        AppColors.red,
        false,
      ),
      (
        Icons.quiz,
        t['quizCorrected']!,
        'Unit 2 Quiz - 15/20',
        t['daysAgo']!.replaceAll('%s', '3'),
        AppColors.accent,
        false,
      ),
      (
        Icons.assignment,
        t['newAssignment']!,
        'Unit 3 - Motion Assignment',
        t['daysAgo']!.replaceAll('%s', '4'),
        AppColors.primary,
        false,
      ),
      (
        Icons.schedule,
        t['sessionReminder']!,
        'Session 6 is live now',
        t['daysAgo']!.replaceAll('%s', '5'),
        AppColors.success,
        false,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['notificationsTitle']!,
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(
              () => _readSet.addAll(
                List.generate(notifications.length, (i) => i),
              ),
            ),
            child: Text(
              t['markAllRead']!,
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, i) {
          final (icon, title, body, time, color, unreadDefault) =
              notifications[i];
          final isUnread = unreadDefault && !_readSet.contains(i);
          return GestureDetector(
            onTap: () => setState(() => _readSet.add(i)),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUnread
                    ? AppColors.primary.withValues(alpha: 0.04)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: isUnread
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                      )
                    : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 20, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          body,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          time,
                          style: TextStyle(fontSize: 10, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
