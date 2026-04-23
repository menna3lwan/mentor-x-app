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
                return const _AddChildButton();
              }

              final child = state.children[index];
              final isSelected = child.id == state.selectedChild!.id;
              
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: AvatarSwitcherItem(
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

class _AddChildButton extends StatelessWidget {
  const _AddChildButton();

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
              backgroundColor: context.backgroundPrimaryColor,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.textTertiaryColor.withValues(alpha: 0.5),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.add, color: context.textTertiaryColor, size: 28),
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
              color: context.textTertiaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
