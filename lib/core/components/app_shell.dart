import 'package:doculode/config/index.dart';
import 'package:doculode/core/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_logo.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.content});
final Widget content;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFE3F2FD), // A light blue color for the bottom
          ],
        ),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: .4,
                child: SvgPicture.asset(
                  'assets/images/school_icons_bg.svg',
                  fit: BoxFit.fitWidth,
                ),
              )),
          content,
          WindowsTitleBar(AbsorbPointer(
            absorbing: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:SizedBox()//  BreadcrumbsWidget(),
            ),
          )),
         
          Positioned(
            top: Insets.lg  ,
            left: Insets.lg,
            child: Container(
              padding: EdgeInsets.all(Insets.lg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: Corners.fullBorder,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: AppLogo(
                  variant: LogoVariant.horizontal,
                )),
          )
        
        ],
      ),
    );
  }
}
