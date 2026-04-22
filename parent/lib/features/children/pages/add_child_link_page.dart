import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/children_bloc.dart';
import 'package:go_router/go_router.dart';

class AddChildLinkPage extends StatefulWidget {
  const AddChildLinkPage({super.key});

  @override
  State<AddChildLinkPage> createState() => _AddChildLinkPageState();
}

class _AddChildLinkPageState extends State<AddChildLinkPage> {
  final _queryController = TextEditingController();
  String _relationship = 'father';

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Link a Child'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF183764)),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<ChildrenBloc, ChildrenState>(
          listener: (context, state) {
            if (state.status == ChildrenStatus.success && state.lookedUpStudent == null && state.children.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Child linked successfully!')),
              );
              context.pop();
            }
            if (state.status == ChildrenStatus.failure && state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Link Your Child',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF183764),
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your child\'s admission number or registered phone number to link their account.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: MentorXTextFormField(
                          controller: _queryController,
                          label: 'Admission Number / Phone',
                          icon: Icons.search,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF183764),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(16),
                        ),
                        icon: state.status == ChildrenStatus.loading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : const Icon(Icons.arrow_forward),
                        onPressed: state.status == ChildrenStatus.loading
                            ? null
                            : () {
                                if (_queryController.text.isNotEmpty) {
                                  context.read<ChildrenBloc>().add(
                                        ChildrenLookupRequested(_queryController.text),
                                      );
                                }
                              },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (state.lookedUpStudent != null) ...[
                    _StudentPreviewCard(
                      student: state.lookedUpStudent!,
                      relationship: _relationship,
                      onRelationshipChanged: (value) {
                        setState(() {
                          _relationship = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    MentorXButton(
                      text: 'Confirm & Link',
                      onPressed: state.status == ChildrenStatus.loading
                          ? null
                          : () {
                              context.read<ChildrenBloc>().add(
                                    ChildLinkConfirmed(
                                      studentId: state.lookedUpStudent!.studentId,
                                      relationship: _relationship,
                                    ),
                                  );
                            },
                      loading: state.status == ChildrenStatus.loading,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StudentPreviewCard extends StatelessWidget {
  final ParentStudentLookupEntity student;
  final String relationship;
  final ValueChanged<String?> onRelationshipChanged;

  const _StudentPreviewCard({
    required this.student,
    required this.relationship,
    required this.onRelationshipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      colors: [Colors.white, Colors.white.withValues(alpha: 0.9)],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF183764).withValues(alpha: 0.1),
                child: const Icon(Icons.person, color: Color(0xFF183764), size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.maskedName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF183764),
                      ),
                    ),
                    Text(
                      'Grade: ${student.gradeName}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text(
            'Relationship',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: relationship,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'father', child: Text('Father')),
              DropdownMenuItem(value: 'mother', child: Text('Mother')),
              DropdownMenuItem(value: 'guardian', child: Text('Guardian')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            onChanged: onRelationshipChanged,
          ),
        ],
      ),
    );
  }
}
