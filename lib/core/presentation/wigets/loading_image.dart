import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.halfTriangleDot(
          color: CupertinoColors.white, size: 50),
    );
  }
}
