import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Widget loadingWidget;
  final Widget errorWidget;
  const ImageNetwork(
      {Key? key,
      required this.url,
      required this.width,
      required this.height,
      required this.loadingWidget,
      required this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(url);
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorListener: (value) {
        print(value);
      },
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) => loadingWidget,
      errorWidget: (context, url, error) => errorWidget,
      fadeOutDuration: const Duration(milliseconds: 400),
    );
  }
}
