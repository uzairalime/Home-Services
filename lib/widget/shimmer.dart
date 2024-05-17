import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        period: const Duration(seconds: 3),
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.grey.withOpacity(0.2),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(shapeBorder is RoundedRectangleBorder ? 6 : 50),

            color: Colors.grey[400],
            // shape: shapeBorder is RoundedRectangleBorder
            //     ? BoxShape.rectangle
            //     : BoxShape.circle,
          ),
        ),
      );
}

Widget buildShimmertile() => const ListTile(
      leading: ShimmerWidget.circular(
        width: 64,
        height: 64,
      ),
      title: ShimmerWidget.rectangular(height: 16),
      subtitle: ShimmerWidget.rectangular(height: 16),
    );
