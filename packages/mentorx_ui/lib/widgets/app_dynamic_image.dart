part of '../mentorx_ui.dart';

final class AppDynamicImage extends StatelessWidget {
  final BoxFit fit;
  final String path;
  final Color? color;
  final double? width;
  final double? height;
  final bool matchTextDirection;
  final BorderRadius? borderRadius;
  final Widget? errorWidget;

  const AppDynamicImage(
    this.path, {
    super.key,
    this.width,
    this.color,
    this.height,
    this.fit = BoxFit.cover,
    this.matchTextDirection = true,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (path.isEmpty) {
      if (errorWidget != null) {
        imageWidget = errorWidget!;
      } else {
        imageWidget = _PlaceHolderImage(
          height: height,
          width: width,
          borderRadius: borderRadius,
        );
      }
    } else if (path.endsWith('svg')) {
      imageWidget = VectorGraphic(
        loader: AssetBytesLoader(path),
        fit: fit,
        width: width,
        height: height,
        matchTextDirection: matchTextDirection,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else if (path.startsWith('http')) {
      imageWidget = LayoutBuilder(
        builder: (context, constraints) {
          final imageWidth = constraints.hasBoundedWidth ? constraints.maxWidth : width;
          final imageHeight = constraints.hasBoundedHeight ? constraints.maxHeight : height;

          return CachedNetworkImage(
            fit: fit,
            color: color,
            width: imageWidth,
            imageUrl: path,
            height: imageHeight,
            matchTextDirection: matchTextDirection,
            placeholder: (context, url) => _PlaceHolderImage(
              height: imageHeight,
              width: imageWidth,
              borderRadius: borderRadius,
            ),
            errorWidget: (context, url, error) =>
                errorWidget ??
                _PlaceHolderImage(
                  height: imageHeight,
                  width: imageWidth,
                  borderRadius: borderRadius,
                ),
            imageBuilder: borderRadius != null
                ? (context, imageProvider) => Container(
                      width: imageWidth,
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: fit,
                        ),
                      ),
                    )
                : null,
          );
        },
      );
    } else {
      imageWidget = Image.asset(
        path,
        fit: fit,
        color: color,
        width: width,
        height: height,
        matchTextDirection: matchTextDirection,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _PlaceHolderImage(height: height, width: width, borderRadius: borderRadius),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

final class _PlaceHolderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const _PlaceHolderImage({required this.height, required this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? context.mediumRadius,
      child: ColoredBox(
        color: context.backgroundSecondaryColor,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Opacity(
                opacity: 0.5,
                child: MentorXLogo(
                  size: (width != null && height != null)
                      ? (width! < height! ? width! : height!) * 0.4
                      : 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
