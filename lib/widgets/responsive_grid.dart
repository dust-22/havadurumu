import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final int mobileCount;
  final int tabletCount;
  final int desktopCount;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;

  const ResponsiveGrid({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mobileCount = 2,
    this.tabletCount = 4,
    this.desktopCount = 6,
    this.spacing = 16,
  }) : super(key: key);

  int _getCrossAxisCount(double width) {
    if (width > 1000) return desktopCount;
    if (width > 600) return tabletCount;
    return mobileCount;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        int crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        return GridView.builder(
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}