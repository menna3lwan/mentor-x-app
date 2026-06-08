import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

/// Card shown after a successful student lookup, presenting the masked
/// identity of the candidate child plus a relationship picker.
class StudentPreviewCardWidget extends StatelessWidget {
  final ParentStudentLookupEntity student;
  final String relationship;
  final ValueChanged<String> onRelationshipChanged;
  final String specifyRelationshipLabel;
  final String gradeLabelPrefix;
  final Map<String, String> relationshipLabels;

  const StudentPreviewCardWidget({
    super.key,
    required this.student,
    required this.relationship,
    required this.onRelationshipChanged,
    required this.specifyRelationshipLabel,
    required this.gradeLabelPrefix,
    required this.relationshipLabels,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.08),
          ),
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
                  child: Icon(
                    Icons.person_rounded,
                    color: context.brandPrimaryColor,
                    size: 32,
                  ),
                ),
                const Gap(16),
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
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(4),
                      if (student.gradeName.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: context.backgroundTertiaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            gradeLabelPrefix,
                            style: TextStyle(
                              color: context.textSecondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
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
              specifyRelationshipLabel,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: context.textPrimaryColor,
              ),
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.backgroundTertiaryColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.08),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: relationship,
                  decoration: const InputDecoration(border: InputBorder.none),
                  dropdownColor: context.backgroundSecondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  items: relationshipLabels.entries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) onRelationshipChanged(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
