import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

/// Top portion of the profile screen — avatar + name + verified badge.
class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String verifiedLabel;
  final bool isVerified;
  final VoidCallback? onChangeAvatarPressed;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.verifiedLabel,
    required this.isVerified,
    this.avatarUrl,
    this.onChangeAvatarPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    width: 4,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: context.backgroundSecondaryColor,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!)
                      : null,
                  child: avatarUrl == null
                      ? Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: context.brandPrimaryColor,
                        )
                      : null,
                ),
              ),
              if (onChangeAvatarPressed != null)
                Material(
                  color: context.brandPrimaryColor,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onChangeAvatarPressed,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                        color: context.backgroundPrimaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(16),
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          if (isVerified) ...[
            const Gap(8),
            StatusBadge(
              label: verifiedLabel,
              color: context.statusSuccessColor,
              isSmall: true,
            ),
          ],
        ],
      ),
    );
  }
}

class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          MentorXSkeleton(width: 112, height: 112, borderRadius: 56),
          SizedBox(height: 16),
          MentorXSkeleton(width: 160, height: 22, borderRadius: 6),
          SizedBox(height: 8),
          MentorXSkeleton(width: 100, height: 14, borderRadius: 4),
        ],
      ),
    );
  }
}
