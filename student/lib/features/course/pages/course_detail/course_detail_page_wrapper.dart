import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/course_detail_bloc.dart';
import 'course_detail_page.dart';

final class CourseDetailPageWrapper extends StatefulWidget {
  const CourseDetailPageWrapper({super.key});
  @override
  State<CourseDetailPageWrapper> createState() =>
      _CourseDetailPageWrapperState();
}

final class _CourseDetailPageWrapperState
    extends State<CourseDetailPageWrapper> {
  bool _isBottomSheetOpen = false;

  void _showCheckoutBottomSheet(BuildContext parentContext, CourseDetailBloc bloc) {
    setState(() {
      _isBottomSheetOpen = true;
    });
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: const _CheckoutBottomSheetContent(),
        );
      },
    ).then((_) {
      if (mounted) {
        setState(() {
          _isBottomSheetOpen = false;
        });
      }
      bloc.add(const CourseDetailRemoveCouponRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      CourseDetailBloc,
      CourseDetailPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case CourseDetailEnrollSuccessPresentationEvent():
            context.showSuccessSnackBar(context.t.course.detail.enrollSuccess);
            if (_isBottomSheetOpen) {
              Navigator.of(context).pop();
            }
          case CourseDetailEnrollFailurePresentationEvent(:final message):
            context.showErrorSnackBar(
              message.isNotEmpty
                  ? message
                  : context.t.course.detail.enrollFailed,
            );
          case CourseDetailFailurePresentationEvent():
            break;
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<CourseDetailBloc>();
          final course = context.select(
            (CourseDetailBloc bloc) => bloc.state.course,
          );
          final sessions = context.select(
            (CourseDetailBloc bloc) => bloc.state.sessions,
          );
          final sessionItems = context.select(
            (CourseDetailBloc bloc) => bloc.state.sessionItems,
          );
          final sessionWeeks = context.select(
            (CourseDetailBloc bloc) => bloc.state.sessionWeeks,
          );
          final enrollment = context.select(
            (CourseDetailBloc bloc) => bloc.state.enrollment,
          );
          final selectedTab = context.select(
            (CourseDetailBloc bloc) => bloc.state.selectedTab,
          );
          final isCourseLoading = context.select(
            (CourseDetailBloc bloc) => bloc.state.isCourseLoading,
          );
          final isSessionsLoading = context.select(
            (CourseDetailBloc bloc) => bloc.state.isSessionsLoading,
          );
          final isEnrolling = context.select(
            (CourseDetailBloc bloc) => bloc.state.isEnrolling,
          );
          final isEnrolled = context.select(
            (CourseDetailBloc bloc) => bloc.state.isEnrolled,
          );
          final isCourseFailure = context.select(
            (CourseDetailBloc bloc) => bloc.state.isCourseFailure,
          );
          final errorMessage = context.select(
            (CourseDetailBloc bloc) => bloc.state.errorMessage,
          );

          return CourseDetailPage(
            course: course,
            sessions: sessions,
            sessionItems: sessionItems,
            sessionWeeks: sessionWeeks,
            enrollment: enrollment,
            selectedTab: selectedTab,
            isCourseLoading: isCourseLoading,
            isSessionsLoading: isSessionsLoading,
            isEnrolling: isEnrolling,
            isEnrolled: isEnrolled,
            errorMessage: isCourseFailure ? errorMessage : null,
            onTabChanged: (tab) => bloc.add(CourseDetailTabChanged(tab)),
            onEnrollTap: () {
              if (course != null && !course.isFree && course.price > 0) {
                _showCheckoutBottomSheet(context, bloc);
              } else {
                bloc.add(const CourseDetailEnrollRequested());
              }
            },
            onContinueTap: () => _handleContinueTap(context),
            onSessionItemTap: (item) => _handleItemTap(context, item),
            onRefresh: () async => bloc.add(const CourseDetailRefreshed()),
          );
        },
      ),
    );
  }

  void _handleContinueTap(BuildContext context) {
    final state = context.read<CourseDetailBloc>().state;
    // Find the first available session item across all sessions.
    for (final session in state.sessions) {
      final items = state.sessionItems[session.id] ?? [];
      if (items.isNotEmpty) {
        _handleItemTap(context, items.first);
        return;
      }
    }
    // No items found — switch to Sessions tab so the user can see the list.
    context.read<CourseDetailBloc>().add(
          const CourseDetailTabChanged(CourseDetailTab.sessions),
        );
  }

  void _handleItemTap(BuildContext context, SessionItemEntity item) {
    final state = context.read<CourseDetailBloc>().state;
    final enrollment = state.enrollment;

    // Guard: non-enrolled students can only access free items.
    if (enrollment == null && !item.isFree) {
      context.showInfoSnackBar(context.t.course.detail.enrollToAccess);
      return;
    }

    // Guard: expired enrollment cannot access content.
    if (enrollment != null && enrollment.status == EnrollmentStatus.expired) {
      context.showErrorSnackBar(context.t.course.detail.courseExpired);
      return;
    }

    switch (item.itemType) {
      case SessionItemType.video:
      case SessionItemType.youtube:
        VideoPlayerRoute(
          itemId: item.id,
          title: item.title,
          enrollmentId: enrollment?.id,
          completedLessons: enrollment?.completedLessons ?? 0,
          totalLessons: enrollment?.totalLessons ?? 0,
        ).push(context);
      case SessionItemType.document:
        PdfViewerRoute(
          itemId: item.id,
          title: item.title,
          enrollmentId: enrollment?.id,
          completedLessons: enrollment?.completedLessons ?? 0,
          totalLessons: enrollment?.totalLessons ?? 0,
          contentUrl: item.embedUrl ?? item.fileUrl,
        ).push(context);
      case SessionItemType.link:
        if (item.fileUrl != null) {
          context.showInfoSnackBar(
            context.t.core.opening(url: item.fileUrl!),
          );
        }

      case SessionItemType.quiz:
        QuizIntroRoute(quizId: item.id).push(context);
      case SessionItemType.assignment:
        AssignmentDetailRoute(assignmentId: item.id).push(context);
      case SessionItemType.audio:
        context.showInfoSnackBar(context.t.core.comingSoon);
    }
  }
}

final class _CheckoutBottomSheetContent extends StatefulWidget {
  const _CheckoutBottomSheetContent();

  @override
  State<_CheckoutBottomSheetContent> createState() =>
      __CheckoutBottomSheetContentState();
}

class __CheckoutBottomSheetContentState extends State<_CheckoutBottomSheetContent> {
  late final TextEditingController _couponController;

  @override
  void initState() {
    super.initState();
    _couponController = TextEditingController();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailState>(
      builder: (context, state) {
        final t = context.t;
        final walletBalance = state.walletBalance ?? 0.0;
        final originalPrice = state.course?.price ?? 0.0;
        final finalPrice = state.finalPrice ?? originalPrice;
        final discountAmount = state.discountAmount ?? 0.0;
        final isBalanceSufficient = walletBalance >= finalPrice;
        final deficit = finalPrice - walletBalance;

        if (state.appliedCouponCode == null && _couponController.text.isNotEmpty) {
          _couponController.clear();
        }

        return Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.05),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            left: 24,
            right: 24,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.textTertiaryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(24),
              Text(
                t.course.courseDetail,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(16),
              _SummaryRow(
                label: t.marketplace.walletBalance,
                value: '${walletBalance.toStringAsFixed(2)} ${t.core.currency}',
                valueColor: isBalanceSufficient
                    ? context.statusSuccessColor
                    : context.statusDangerColor,
                isBold: true,
              ),
              const Gap(16),
              const Divider(height: 1),
              const Gap(16),
              
              if (state.appliedCouponCode == null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MentorXTextFormField(
                        label: t.course.detail.couponCode,
                        hintText: t.course.detail.enterCouponCode,
                        controller: _couponController,
                        prefixIcon: Icons.local_offer_rounded,
                        enabled: !state.isCouponLoading,
                        errorText: state.couponErrorMessage,
                      ),
                    ),
                    const Gap(12),
                    SizedBox(
                      height: 56,
                      child: MentorXButton(
                        width: 100,
                        loading: state.isCouponLoading,
                        onPressed: () {
                          if (_couponController.text.trim().isNotEmpty) {
                            context.read<CourseDetailBloc>().add(
                                  CourseDetailApplyCouponRequested(
                                    _couponController.text.trim(),
                                  ),
                                );
                          }
                        },
                        label: t.course.detail.apply,
                      ),
                    ),
                  ],
                ),
                if (state.validCoupons.isNotEmpty) ...[
                  const Gap(12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.validCoupons.length,
                      separatorBuilder: (_, _) => const Gap(8),
                      itemBuilder: (context, index) {
                        final coupon = state.validCoupons[index];
                        final displayLabel = coupon.discountPercentage != null
                            ? '${coupon.code} (${coupon.discountPercentage!.toInt()}% OFF)'
                            : coupon.discountAmount != null
                                ? '${coupon.code} (-${coupon.discountAmount!.toInt()} ${t.core.currency})'
                                : coupon.code;
                        return InkWell(
                          onTap: () {
                            context.read<CourseDetailBloc>().add(
                                  CourseDetailApplyCouponRequested(coupon.code),
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: context.brandPrimaryColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: context.brandPrimaryColor.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_offer,
                                  size: 14,
                                  color: context.brandPrimaryColor,
                                ),
                                const Gap(6),
                                Text(
                                  displayLabel,
                                  style: context.smallTextStyle.copyWith(
                                    color: context.brandPrimaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.statusSuccessColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: context.statusSuccessColor.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: context.statusSuccessColor,
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.course.detail.couponApplied,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: context.statusSuccessColor,
                              ),
                            ),
                            Text(
                              '${state.appliedCouponCode} (${state.couponDiscountSummary ?? ''})',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: context.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MentorXIconButton(
                        icon: Icons.close_rounded,
                        color: context.statusDangerColor,
                        onPressed: () {
                          context.read<CourseDetailBloc>().add(
                                const CourseDetailRemoveCouponRequested(),
                              );
                        },
                        size: MentorXIconButtonSize.small,
                      ),
                    ],
                  ),
                ),
              ],
              
              const Gap(24),
              const Divider(height: 1),
              const Gap(16),
              
              _SummaryRow(
                label: t.course.detail.originalPriceLabel,
                value: '${originalPrice.toStringAsFixed(2)} ${t.core.currency}',
              ),
              if (discountAmount > 0) ...[
                const Gap(8),
                _SummaryRow(
                  label: t.course.detail.discountLabel,
                  value: '-${discountAmount.toStringAsFixed(2)} ${t.core.currency}',
                  valueColor: context.statusSuccessColor,
                ),
              ],
              const Gap(8),
              _SummaryRow(
                label: t.course.detail.finalPriceLabel,
                value: '${finalPrice.toStringAsFixed(2)} ${t.core.currency}',
                isBold: true,
              ),
              
              if (!isBalanceSufficient) ...[
                const Gap(16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.statusDangerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${t.course.detail.insufficientBalance} (Deficit: ${deficit.toStringAsFixed(2)} ${t.core.currency})',
                    style: TextStyle(
                      color: context.statusDangerColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              
              const Gap(24),
              MentorXButton(
                loading: state.isEnrolling,
                onPressed: isBalanceSufficient
                    ? () {
                        context
                            .read<CourseDetailBloc>()
                            .add(const CourseDetailEnrollRequested());
                      }
                    : null,
                label: isBalanceSufficient
                    ? t.course.detail.confirmPayment
                    : t.course.detail.insufficientBalance,
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textTertiaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? context.textPrimaryColor,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
