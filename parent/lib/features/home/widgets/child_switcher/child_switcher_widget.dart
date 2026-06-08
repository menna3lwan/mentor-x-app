import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

/// Horizontal avatar carousel that lets a parent swap between their linked
/// children. Purely presentational — the wrapper provides the data and
/// callbacks.
class ChildSwitcherWidget extends StatelessWidget {
  final List<ParentChildEntity> children;
  final String? selectedChildId;
  final ValueChanged<ParentChildEntity> onChildSelected;
  final VoidCallback onAddChildPressed;
  final String addChildLabel;

  const ChildSwitcherWidget({
    super.key,
    required this.children,
    required this.selectedChildId,
    required this.onChildSelected,
    required this.onAddChildPressed,
    required this.addChildLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: children.length + 1,
        itemBuilder: (context, index) {
          if (index == children.length) {
            return FadeInRight(
              duration: const Duration(milliseconds: 600),
              delay: Duration(milliseconds: 80 * index),
              child: _AddChildButton(
                onTap: onAddChildPressed,
                label: addChildLabel,
              ),
            );
          }

          final child = children[index];
          final isSelected = child.id == selectedChildId;

          return FadeInRight(
            duration: const Duration(milliseconds: 600),
            delay: Duration(milliseconds: 80 * index),
            child: _ChildAvatarItem(
              name: _firstName(child.name),
              imageUrl: child.profileImageUrl,
              isSelected: isSelected,
              onTap: () => onChildSelected(child),
            ),
          );
        },
      ),
    );
  }

  /// Picks the first whitespace-separated token, trims it, and falls back
  /// to an em-dash if the name is missing/blank. Defensive against API
  /// payloads that send empty strings or whitespace-only values.
  static String _firstName(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return '—';
    final first = trimmed.split(RegExp(r'\s+')).first;
    return first.isEmpty ? '—' : first;
  }
}

class _ChildAvatarItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChildAvatarItem({
    required this.name,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              scale: isSelected ? 1.15 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? context.brandPrimaryColor
                        : context.borderPrimaryColor.withValues(alpha: 0.1),
                    width: isSelected ? 3 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Hero(
                  tag: 'child_avatar_${name}_$isSelected',
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: isSelected
                        ? context.brandPrimaryColor.withValues(alpha: 0.05)
                        : context.backgroundSecondaryColor,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: imageUrl == null
                        ? Text(
                            name.isEmpty ? '?' : name[0].toUpperCase(),
                            style: TextStyle(
                              color: context.brandPrimaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            const Gap(12),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                color: isSelected
                    ? context.textPrimaryColor
                    : context.textTertiaryColor,
                letterSpacing: isSelected ? -0.2 : 0,
              ),
              child: SizedBox(
                width: 72,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (isSelected)
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddChildButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const _AddChildButton({required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: context.backgroundSecondaryColor,
              child: Icon(
                Icons.add_rounded,
                color: context.textTertiaryColor,
                size: 32,
              ),
            ),
          ),
          const Gap(12),
          SizedBox(
            width: 72,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: context.textTertiaryColor,
                letterSpacing: -0.2,
              ),
            ),
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
