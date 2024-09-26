import 'package:aria2_client/const/Const.dart';
import 'package:flutter/material.dart';

class MySwiperPagination extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Color activeColor;
  final Color color;
  final Size itemSize;
  final double space;
  final PageController controller;
  final int initialIndex;

  const MySwiperPagination(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      required this.activeColor,
      required this.color,
      required this.itemSize,
      required this.space,
      required this.controller,
      required this.initialIndex});

  @override
  State<StatefulWidget> createState() {
    return _MySwiperPaginationState();
  }
}

class _MySwiperPaginationState extends State<MySwiperPagination> {
  double page = 0;
  late Offset centerOffset;
  late Offset lastOffset;
  late double totalMoveWidth;
  late Size canvasSize;
  late double startX;
  late double endX;

  @override
  void initState() {
    super.initState();
    centerOffset = Offset(widget.itemSize.width / 2 + widget.space / 2,
        widget.space / 2 + widget.itemSize.height / 2);
    lastOffset = Offset.zero;
    canvasSize = Size(
        widget.itemSize.width * widget.itemCount + 0.2 +
            widget.space * (widget.itemCount),
        widget.itemSize.height + widget.space);
    debugPrint(canvasSize.toString());
    startX = widget.space / 2 + widget.itemSize.width / 2;
    endX = canvasSize.width - widget.space / 2 - widget.itemSize.width / 2;
    totalMoveWidth = endX - startX;
    widget.controller.addListener(_onController);
  }

  _onController() {
    page = widget.controller.page ?? 0;
    var percent = page / widget.itemCount;
    lastOffset = centerOffset;
    centerOffset = Offset(
        (canvasSize.width) * percent +
            widget.itemSize.width / 2 +
            widget.space / 2,
        widget.space / 2 + widget.itemSize.height / 2);
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemWidgets = [];
    for (int index = 0; index < widget.itemCount; index++) {
      Widget item = widget.itemBuilder(context, index);
      itemWidgets.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.space / 2, horizontal: widget.space / 2),
        child: SizedBox(
            width: widget.itemSize.width,
            height: widget.itemSize.height,
            child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                onTap: () {
                  widget.controller.animateToPage(index,
                      duration: Const.duration500ms,
                      curve: Curves.easeInOut);
                },
                child: item)),
      ));
    }

    return Card(
        color: Theme.of(context).primaryColor,
        elevation: 3,
        child: CustomPaint(
          size: canvasSize,
          painter: _MySwiperPaginationPainter(centerOffset, widget.itemSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: itemWidgets,
          ),
        ));
  }
}

class _MySwiperPaginationPainter extends CustomPainter {
  late final Offset offset;
  late final Size itemSize;

  _MySwiperPaginationPainter(this.offset, this.itemSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.amber;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: offset, width: itemSize.width, height: itemSize.height),
            const Radius.circular(10)),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
