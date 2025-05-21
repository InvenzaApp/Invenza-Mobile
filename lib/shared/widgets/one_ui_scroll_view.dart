import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OneUIScrollView extends StatelessWidget {
  const OneUIScrollView({
    required this.title,
    required this.subtitle,
    required this.slivers,
    this.actions = const [],
    this.linearProgressBar,
    this.toolbarHeight = kToolbarHeight,
    this.expandedHeight = 300,
    this.showBackButton = true,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<Widget> slivers;
  final List<Widget> actions;
  final Widget? linearProgressBar;
  final double expandedHeight;
  final double toolbarHeight;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _OneUIAppBar(
          background: context.container,
          collapsedHeight: toolbarHeight,
          expandedHeight: expandedHeight,
          title: title,
          subtitle: subtitle,
          actions: actions,
          linearProgressBar: linearProgressBar,
          showBackButton: showBackButton,
        ),
        ...slivers,
      ],
    );
  }
}

class _OneUIAppBar extends StatelessWidget {
  const _OneUIAppBar({
    required this.background,
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.title,
    required this.subtitle,
    required this.actions,
    required this.linearProgressBar,
    required this.showBackButton,
  });

  final Color background;
  final double collapsedHeight;
  final double expandedHeight;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final Widget? linearProgressBar;
  final bool showBackButton;

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio = (constraints.maxHeight - collapsedHeight) /
        (expandedHeight - collapsedHeight);

    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;

    return expandRatio;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: background,
      toolbarHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      elevation: 12,
      flexibleSpace: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final expandRatio = _calculateExpandRatio(constraints);
            final animation = AlwaysStoppedAnimation(expandRatio);

            return Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  child: _OneUIExtendedTitle(
                    title: title,
                    subtitle: subtitle,
                    animation: animation,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: _OneUICollapsedTitle(
                    title: title,
                    height: collapsedHeight,
                    animation: animation,
                    showBackButton: showBackButton,
                    actions: Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions,
                      ),
                    ),
                  ),
                ),
                if (linearProgressBar != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: linearProgressBar,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OneUIExtendedTitle extends StatelessWidget {
  const _OneUIExtendedTitle({
    required this.title,
    required this.subtitle,
    required this.animation,
  });

  final String title;
  final String subtitle;
  final AlwaysStoppedAnimation<double> animation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.3, 1, curve: Curves.easeIn),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: mediumHorizontalPadding,
              child: DefaultTextStyle(
                style: context.displaySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                child: Text(title),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: mediumHorizontalPadding,
              child: DefaultTextStyle(
                style: context.bodyLarge,
                textAlign: TextAlign.center,
                child: Text(subtitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OneUICollapsedTitle extends StatelessWidget {
  const _OneUICollapsedTitle({
    required this.title,
    required this.actions,
    required this.animation,
    required this.height,
    required this.showBackButton,
  });

  final String title;
  final Widget actions;
  final AlwaysStoppedAnimation<double> animation;
  final double height;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: height,
      child: Padding(
        padding: mediumHorizontalPadding,
        child: Row(
          children: [
            if(showBackButton)...[
              Skeleton.keep(
                child: InkWell(
                  onTap: () => context.maybePop(),
                  borderRadius: BorderRadius.circular(circleValue),
                  child: Ink(
                    padding: smallPadding,
                    child: const Icon(Icons.chevron_left),
                  ),
                ),
              ),
            ],
            Expanded(
              child: FadeTransition(
                opacity: Tween<double>(begin: 1, end: 0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0, 0.7, curve: Curves.easeOut),
                  ),
                ),
                child: Text(
                  title,
                  style: context.bodyLarge,
                ),
              ),
            ),
            const SizedBox(width: 8),
            actions,
          ],
        ),
      ),
    );
  }
}
