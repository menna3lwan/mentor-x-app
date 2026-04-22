import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/children_bloc.dart';

class AddChildLinkPage extends StatelessWidget {
  const AddChildLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Link a Child')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Student Admission Number',
                  hintText: 'e.g., ADM-2023-001',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // context.read<ChildrenBloc>().add(const ChildrenLookupRequested(...));
                },
                child: const Text('Lookup Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
