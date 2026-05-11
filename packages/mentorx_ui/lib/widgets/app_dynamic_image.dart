part of '../mentorx_ui.dart';

final class AppDynamicImage extends StatelessWidget {
  final BoxFit fit;
  final String path;
  final Color? color;
  final double? width;
  final double? height;
  final bool matchTextDirection;
  final BorderRadius? borderRadius;

  const AppDynamicImage(
    this.path, {
    super.key,
    this.width,
    this.color,
    this.height,
    this.fit = BoxFit.cover,
    this.matchTextDirection = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return ColoredBox(
        color: context.backgroundSecondaryColor,
        child: SizedBox(width: width, height: height),
      );
    }
    if (path.endsWith('svg')) {
      return VectorGraphic(
        loader: AssetBytesLoader(path),
        fit: fit,
        width: width,
        height: height,
        matchTextDirection: matchTextDirection,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }
    if (path.startsWith('http')) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // Use explicit constraints when available, fallback to provided dimensions
          final imageWidth = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : width;
          final imageHeight = constraints.hasBoundedHeight
              ? constraints.maxHeight
              : height;

          return CachedNetworkImage(
            fit: fit,
            color: color,
            width: imageWidth,
            imageUrl: path,
            height: imageHeight,
            matchTextDirection: matchTextDirection,
            placeholder: (context, url) =>
                _PlaceHolderImage(height: imageHeight, width: imageWidth, borderRadius: borderRadius),
            errorWidget: (context, url, error) =>
                _PlaceHolderImage(height: imageHeight, width: imageWidth, borderRadius: borderRadius),
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
    }
    return Image.asset(
      path,
      fit: fit,
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
    );
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
