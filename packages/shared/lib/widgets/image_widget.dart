import 'package:shared/imports.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.imageId,
    this.height = 96,
    this.width = 96,
    this.borderRadius = 8,
    this.onTap,
  }) : super(key: key);

  final String? imageId;
  final double height;
  final double width;
  final double borderRadius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: imageId != null && imageId!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageId!,
                  errorListener: (errors) {
                    debugPrint(errors.toString());
                  },
                  imageBuilder: (
                    context,
                    imageProvider,
                  ) =>
                      Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (
                    context,
                    url,
                    downloadProgress,
                  ) =>
                      const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: CircularProgressIndicatorWidget(),
                  ),
                  errorWidget: (
                    context,
                    url,
                    error,
                  ) =>
                      const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: CircularProgressIndicatorWidget(),
                  ),
                )
              : const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CircularProgressIndicatorWidget(),
                ),
        ),
      ),
    );
  }

  static ImageWidget of(BuildContext context) => ImageWidget.of(context);

  /// Universal CircularProgressIndicator
  Widget _loadingWidget({
    required Color color,
    required double avatarDiameter,
  }) {
    return SizedBox(
      width: avatarDiameter,
      height: avatarDiameter,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: color,
      ),
    );
  }
}
