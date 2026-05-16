import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../cubit/marketplace_cart_cubit.dart';

import 'bloc/marketplace_detail_page_bloc.dart';
import 'marketplace_detail_page.dart';

final class MarketplaceDetailPageWrapper extends StatefulWidget {
  const MarketplaceDetailPageWrapper({super.key});

  @override
  State<MarketplaceDetailPageWrapper> createState() =>
      _MarketplaceDetailPageWrapperState();
}

class _MarketplaceDetailPageWrapperState
    extends State<MarketplaceDetailPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      MarketplaceDetailPageBloc,
      MarketplaceDetailPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MarketplaceDetailPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context
              .select<MarketplaceDetailPageBloc, LoadingState>(
                (bloc) => bloc.state.loadingState,
              );
          final item = context
              .select<MarketplaceDetailPageBloc, MarketplaceItemEntity?>(
                (bloc) => bloc.state.item,
              );

          return MarketplaceDetailPagePage(
            loadingState: loadingState,
            item: item,
            onRetry: () {
              if (item?.id != null) {
                context.read<MarketplaceDetailPageBloc>().add(
                  MarketplaceDetailPageLoadEvent(item!.id),
                );
              }
            },
            onAddToCart: (item) {
              HapticFeedback.mediumImpact();
              context.read<MarketplaceCartCubit>().addItem(item);
              MentorXUI.showToast(
                message: '${item.title} ${context.t.marketplace.addedToCart}',
              );
            },
          );
        },
      ),
    );
  }
}
