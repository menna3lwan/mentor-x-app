import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class StudentCardNotCreatedView extends StatelessWidget {
  final VoidCallback? onRefresh;

  const StudentCardNotCreatedView({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.brandPrimaryColor;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Premium Card Skeleton
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withValues(alpha: 0.08),
                    const Color(0xFF2EC4B6).withValues(alpha: 0.05), // Secondary Green
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.02),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    right: -20,
                    top: -20,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: primaryColor.withValues(alpha: 0.03),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.credit_card_rounded,
                            size: 40,
                            color: primaryColor.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No Card Issued",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: primaryColor.withValues(alpha: 0.8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Card Not Created Yet",
              style: context.bodyPrimaryStyle.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Your digital student card has not been generated yet. Please contact administration or try again later.",
              textAlign: TextAlign.center,
              style: context.bodySecondaryStyle.copyWith(
                fontSize: 15,
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 32),
              MentorXButton(
                text: "Refresh",
                onPressed: onRefresh,
                style: Style($box.width(200)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
