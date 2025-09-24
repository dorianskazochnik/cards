import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cards/core/presentation/page/CustomPainters.dart';

class HoverButton extends StatefulWidget {
  final SvgPicture picture;
  final int k;
  final double width;
  HoverButton({required this.picture, this.width = 0, this.k = 0});

  @override
  HoverState createState() => HoverState();
}

class HoverState extends State<HoverButton> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        setState(() {
          hovered = false;
        });
      },
      onEnter: (_) {
        setState(() {
          hovered = true;
        });
      },
      onHover: (_) {
        setState(() {
          hovered = true;
        });
      },
      child: Container(
        height: 104,
        width: 48,
        clipBehavior: Clip.none,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (widget.k == 1 && hovered) CustomPaint(size: Size(widget.width, 104), painter: Gap1())
            else if (widget.k == 3 && hovered) CustomPaint(size: Size(widget.width, 104), painter: Gap3())
            else if (widget.k == 2 && hovered) CustomPaint(size: Size(widget.width, 104), painter: Gap2()),
            Positioned(
              bottom: hovered? 0 : -12,
              child: MaterialButton(
                onPressed: () {},
                color: fialka,
                hoverColor: malina,
                highlightColor: sakura,
                shape: CircleBorder(),
                child: widget.picture,
              ),
            ),
          ],
        ),
      ),
    );
  }
}