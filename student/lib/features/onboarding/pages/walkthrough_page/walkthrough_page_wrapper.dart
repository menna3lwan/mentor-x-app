import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import 'bloc/walkthrough_page_bloc.dart';
import 'walkthrough_page_page.dart';

final class WalkthroughPageWrapper extends StatefulWidget {
  const WalkthroughPageWrapper({super.key});

  @override
  State<WalkthroughPageWrapper> createState() => _WalkthroughPageWrapperState();
}

final class _WalkthroughPageWrapperState extends State<WalkthroughPageWrapper> {
  static const int _totalSteps = 3;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  void _onNext(WalkthroughPageBloc bloc) {
    if (_currentPage < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    bloc.add(const WalkthroughPageCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      WalkthroughPageBloc,
      WalkthroughPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case WalkthroughPageCompletedPresentationEvent():
            const TenantSelectionPageRoute().go(context);
          case WalkthroughPageFailurePresentationEvent():
            break;
        }
      },
      child: BlocBuilder<WalkthroughPageBloc, WalkthroughPageState>(
        builder: (context, state) {
          final bloc = context.read<WalkthroughPageBloc>();
          return WalkthroughPagePage(
            pageController: _pageController,
            currentPage: _currentPage,
            onPageChanged: _onPageChanged,
            isLoading: state.isSubmitting,
            onNext: () => _onNext(bloc),
            onSkip: () => bloc.add(const WalkthroughPageSkipped()),
          );
        },
      ),
    );
  }
}
