import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/children_bloc.dart';

final class AddChildLinkPage extends StatefulWidget {
  const AddChildLinkPage({super.key});

  @override
  State<AddChildLinkPage> createState() => _AddChildLinkPageState();
}

final class _AddChildLinkPageState extends State<AddChildLinkPage> {
  final TextEditingController _queryController = TextEditingController();
  String _relationship = 'Father';
  int _linkedCount = 0;

  @override
  void initState() {
    super.initState();
    _linkedCount = context.read<ChildrenBloc>().state.children.length;
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChildrenBloc, ChildrenState>(
      listenWhen: (previous, current) =>
          previous.isSaving &&
          !current.isSaving &&
          current.children.length > _linkedCount,
      listener: (context, state) {
        _linkedCount = state.children.length;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Link New Child')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Student Code or Phone Number'),
                const SizedBox(height: 8),
                TextField(
                  controller: _queryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter code or phone',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _relationship,
                  items: const [
                    DropdownMenuItem(value: 'Father', child: Text('Father')),
                    DropdownMenuItem(value: 'Mother', child: Text('Mother')),
                    DropdownMenuItem(
                      value: 'Guardian',
                      child: Text('Guardian'),
                    ),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _relationship = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isSaving
                        ? null
                        : () {
                            final query = _queryController.text.trim();
                            if (query.isEmpty) {
                              return;
                            }
                            context.read<ChildrenBloc>().add(
                              ChildrenLinked(
                                query: query,
                                relationship: _relationship,
                              ),
                            );
                          },
                    child: state.isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Link Child'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
