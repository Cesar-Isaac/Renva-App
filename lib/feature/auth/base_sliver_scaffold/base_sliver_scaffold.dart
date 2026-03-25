import 'package:flutter/material.dart';
import '../../../core/style/repo.dart';
import '../../../core/widgets/svg_icon.dart';
import '../../../gen/assets.gen.dart';

class BaseSliverScaffold extends StatelessWidget {
  const BaseSliverScaffold({
    super.key,
    required this.child,
    this.leading,
    this.title,
  });

  final Widget child;
  final Widget? leading;
  final Widget? title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [StyleRepo.blue, StyleRepo.softBlue],
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              leading: leading,
              title: title,
              pinned: true,
              elevation: 2,
              collapsedHeight: 150,
              expandedHeight: 150,
              backgroundColor: StyleRepo.blue,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [StyleRepo.deepBlue, StyleRepo.softBlue],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: SvgIcon(
                        icon: Assets.icons.logoSVG,
                        color: StyleRepo.white,

                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: StyleRepo.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SvgIcon(
                    icon: Assets.icons.biglogo,
                    size: 400,
                    color: StyleRepo.blue,
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}


