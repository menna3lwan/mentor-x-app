import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:parent/core/core.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/routing/app_routes.dart';

class ChildSwitcher extends StatelessWidget {
  const ChildSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.children.isEmpty || state.selectedChild == null) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 140,
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: state.children.length + 1,
            itemBuilder: (context, index) {
              if (index == state.children.length) {
                return FadeInRight(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 80 * index),
                  child: const _AddChildButton(),
                );
              }

              final child = state.children[index];
              final isSelected = child.id == state.selectedChild!.id;
              
              return FadeInRight(
                duration: const Duration(milliseconds: 600),
                delay: Duration(milliseconds: 80 * index),
                child: _ChildAvatarItem(
                  name: child.name.split(' ').first,
                  imageUrl: child.profileImageUrl,
                  isSelected: isSelected,
                  onTap: () {
                    context.read<HomeBloc>().add(HomeChildSwitched(child));
                  },
                ),
              );
            },
          ),
        );
      },
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
                    color: isSelected ? context.brandPrimaryColor : context.borderPrimaryColor.withValues(alpha: 0.1),
                    width: isSelected ? 3 : 1.5,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: context.brandPrimaryColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ] : [
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
                    backgroundColor: isSelected ? context.brandPrimaryColor.withValues(alpha: 0.05) : context.backgroundSecondaryColor,
                    backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                    child: imageUrl == null 
                        ? Text(
                            name[0].toUpperCase(),
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
                color: isSelected ? context.textPrimaryColor : context.textTertiaryColor,
                letterSpacing: isSelected ? -0.2 : 0,
              ),
              child: Text(name),
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
  const _AddChildButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const AddChildLinkRoute().go(context),
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
                style: BorderStyle.solid, // Using solid for simplicity but visually distinct
              ),
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(Icons.add_rounded, color: context.textTertiaryColor, size: 32),
            ),
          ),
          const Gap(12),
          Text(
            'Add Child',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: context.textTertiaryColor,
              letterSpacing: -0.2,
            ),
          ),
          const Gap(12), // Align with indicator height
        ],
      ),
    );
  }
}
