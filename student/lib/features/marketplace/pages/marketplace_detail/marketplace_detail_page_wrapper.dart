import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../cubit/marketplace_cart_cubit.dart';

import 'bloc/marketplace_detail_bloc.dart';
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
      MarketplaceDetailBloc,
      MarketplaceDetailPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case MarketplaceDetailNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context
              .select<MarketplaceDetailBloc, LoadingState>(
                (bloc) => bloc.state.loadingState,
              );
          final item = context
              .select<MarketplaceDetailBloc, MarketplaceItemEntity?>(
                (bloc) => bloc.state.item,
              );

          return MarketplaceDetailPage(
            loadingState: loadingState,
            item: item,
            onRetry: () {
              if (item?.id != null) {
                context.read<MarketplaceDetailBloc>().add(
                  MarketplaceDetailLoadEvent(item!.id),
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
