import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../../../../core/routing/app_routes.dart';

class ChildSwitcher extends StatelessWidget {
  final List<ParentChildEntity> children;
  final ParentChildEntity? selectedChild;
  final ValueChanged<ParentChildEntity> onChildSwitched;

  const ChildSwitcher({
    super.key,
    required this.children,
    required this.selectedChild,
    required this.onChildSwitched,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty || selectedChild == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'SELECT CHILD',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: context.textTertiaryColor,
              letterSpacing: 2.0,
            ),
          ),
        ),
        const Gap(16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            itemCount: children.length + 1,
            itemBuilder: (context, index) {
              if (index == children.length) {
                return FadeInRight(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 100 * index),
                  child: const _AddChildButton(),
                );
              }

              final child = children[index];
              final isSelected = child.id == selectedChild!.id;

              return FadeInRight(
                duration: const Duration(milliseconds: 600),
                delay: Duration(milliseconds: 100 * index),
                child: _ChildAvatarItem(
                  name: child.name.split(' ').first,
                  imageUrl: child.profileImageUrl,
                  isSelected: isSelected,
                  onTap: () => onChildSwitched(child),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChildAvatarItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChildAvatarItem({
    required this.name,
    this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuart,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected 
                      ? context.brandPrimaryColor 
                      : context.borderPrimaryColor.withValues(alpha: 0.1),
                  width: isSelected ? 2.5 : 1,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ] : [],
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected 
                      ? context.brandPrimaryColor.withValues(alpha: 0.05) 
                      : Colors.transparent,
                ),
                child: Hero(
                  tag: 'child_avatar_${name}_$isSelected',
                  child: ClipOval(
                    child: AppDynamicImage(
                      imageUrl ?? '',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorWidget: Container(
                        color: context.backgroundSecondaryColor,
                        child: Center(
                          child: Text(
                            name[0].toUpperCase(),
                            style: TextStyle(
                              color: context.brandPrimaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(12),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                color: isSelected ? context.textPrimaryColor : context.textTertiaryColor,
                letterSpacing: -0.2,
              ),
              child: Text(name),
            ),
            if (isSelected)
              FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 16,
                  height: 3,
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor,
                    borderRadius: BorderRadius.circular(2),
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
  const _AddChildButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const AddChildLinkRoute().go(context),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.2),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              color: context.backgroundSecondaryColor.withValues(alpha: 0.3),
            ),
            child: Icon(
              Icons.add_rounded, 
              color: context.textTertiaryColor, 
              size: 28,
            ),
          ),
          const Gap(12),
          Text(
            'Add',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: context.textTertiaryColor,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
