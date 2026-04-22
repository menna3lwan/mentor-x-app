import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/routing/app_routes.dart';

class ChildSwitcher extends StatelessWidget {
  const ChildSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.children.isEmpty || state.selectedChild == null) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 110,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.children.length + 1,
            itemBuilder: (context, index) {
              if (index == state.children.length) {
                return _AddChildButton(palette: palette);
              }

              final child = state.children[index];
              final isSelected = child.id == state.selectedChild!.id;
              
              return GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(HomeChildSwitched(child));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected 
                                ? palette.brandPrimary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: isSelected 
                              ? palette.brandPrimary.withValues(alpha: 0.1)
                              : palette.backgroundSecondary,
                          backgroundImage: child.profileImageUrl != null 
                              ? NetworkImage(child.profileImageUrl!) 
                              : null,
                          child: child.profileImageUrl == null 
                              ? Text(
                                  child.name.isNotEmpty ? child.name[0] : '?',
                                  style: TextStyle(
                                    color: isSelected ? palette.brandPrimary : palette.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        child.name.split(' ').first,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 13,
                          color: isSelected ? palette.brandPrimary : palette.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _AddChildButton extends StatelessWidget {
  final MentorXThemeColorPalette palette;

  const _AddChildButton({required this.palette});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const AddChildLinkRoute().go(context),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: palette.backgroundPrimary,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: palette.textTertiary.withValues(alpha: 0.5),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.add, color: palette.textTertiary, size: 28),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Add Child',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: palette.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
