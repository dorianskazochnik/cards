import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cards/core/presentation/page/CustomPainters.dart';
import 'package:cards/core/presentation/page/HoverButton.dart';

class Footer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 22,
            left: (appWidth - 5 * 16) / 2 - 24,
            child: HoverButton(
              picture: SvgPicture.asset('lib/utils/menu.svg', colorFilter: ColorFilter.mode(white, BlendMode.srcIn), width: 48, height: 48),
              width: appWidth,
              k: 2,
            ),
          ),
          Positioned(
            bottom: 22,
            left: (appWidth - 5 * 16) / 4 - 64,
            child: HoverButton(
              picture: SvgPicture.asset('lib/utils/arrow.svg', colorFilter: ColorFilter.mode(white, BlendMode.srcIn), width: 48, height: 48),
              width: appWidth,
              k: 1,
            ),
          ),
          Positioned(
            bottom: 22,
            left: (appWidth - 5 * 16) / 4 * 3 + 24,
            child: HoverButton(
              picture: SvgPicture.asset('lib/utils/cross.svg', colorFilter: ColorFilter.mode(white, BlendMode.srcIn), width: 48, height: 48),
              width: appWidth,
              k: 3,
            ),
          ),
        ]
    );
  }
}