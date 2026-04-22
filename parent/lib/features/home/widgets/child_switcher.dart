import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

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
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.children.length,
            itemBuilder: (context, index) {
              final child = state.children[index];
              final isSelected = child.id == state.selectedChild!.id;
              
              return GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(HomeChildSwitched(child));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: isSelected 
                            ? Theme.of(context).primaryColor 
                            : Colors.grey[200],
                        child: Text(
                          child.name.isNotEmpty ? child.name[0] : '?',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        child.name.split(' ').first,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
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
