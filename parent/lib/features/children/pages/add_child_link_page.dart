import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
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
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: BlocConsumer<ChildrenBloc, ChildrenState>(
        listener: (context, state) {
          if (state.status == ChildrenStatus.success && state.lookedUpStudent == null && state.children.isNotEmpty) {
            MentorXUI.showToast(message: 'Child linked successfully!');
            context.pop();
          }
          if (state.status == ChildrenStatus.failure && state.errorMessage != null) {
            MentorXUI.showToast(message: state.errorMessage!, isError: true);
          }
        },
        builder: (context, state) {
          return AppDashboardScaffold(
            title: 'Link a Child',
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Link Your Child',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your child\'s admission number or registered phone number to link their account.',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.textSecondaryColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Search Row
                  Row(
                    children: [
                      Expanded(
                        child: MentorXTextFormField(
                          label: 'Search Child',
                          controller: _queryController,
                          hint: 'Admission Number / Phone',
                          icon: Icons.search_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.brandPrimaryColor,
                              context.brandPrimaryColor.withValues(alpha: 0.8)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: context.brandPrimaryColor.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: state.status == ChildrenStatus.loading
                              ? null
                              : () {
                                  if (_queryController.text.isNotEmpty) {
                                    context.read<ChildrenBloc>().add(
                                          ChildrenLookupRequested(_queryController.text),
                                        );
                                  }
                                },
                          icon: state.status == ChildrenStatus.loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
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
                    const SizedBox(height: 40),
                    MentorXButton(
                      text: 'Confirm & Link Child',
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
            ),
          );
        },
      ),
    );
  }
}

// Removed _BuildHeader in favor of AppDashboardScaffold

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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_rounded, color: context.brandPrimaryColor, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.maskedName,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: context.backgroundSecondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Grade: ${student.gradeName}',
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(),
          ),
          Text(
            'Specify Relationship',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: relationship,
                decoration: const InputDecoration(border: InputBorder.none),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                items: const [
                  DropdownMenuItem(value: 'father', child: Text('Father')),
                  DropdownMenuItem(value: 'mother', child: Text('Mother')),
                  DropdownMenuItem(value: 'guardian', child: Text('Guardian')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: onRelationshipChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
