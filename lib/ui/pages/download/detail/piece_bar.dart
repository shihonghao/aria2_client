import 'package:aria2_client/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

enum PiecesInfoType { bar, grid }

class PieceBar extends StatefulWidget {
  final String bitfield;
  final int numPieces;
  final Color? activeColor;
  final Color? inactiveColor;
  final PiecesInfoType type;

  const PieceBar(
      {super.key,
      required this.bitfield,
      required this.numPieces,
      this.activeColor,
      this.inactiveColor,
      this.type = PiecesInfoType.bar});

  @override
  State<StatefulWidget> createState() {
    return _PieceBarState();
  }
}

class _PieceBarState extends State<PieceBar> {
  @override
  Widget build(BuildContext context) {
    var len = (MediaQuery.of(context).size.width) / 30;
    var h = (widget.numPieces / 30).ceil() * len;
    return CustomPaint(
      painter: widget.type == PiecesInfoType.bar
          ? _PieceBarPainter(widget.bitfield, widget.numPieces,
              widget.activeColor, widget.inactiveColor)
          : _PieceGridPainter(widget.bitfield, widget.numPieces,
              widget.activeColor, widget.inactiveColor),
      child: widget.type == PiecesInfoType.bar
          ? null
          : RepaintBoundary(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: h,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: len,
                        height: len,
                        color: widget.activeColor ?? const Color(0xFF1665EE),
                      ),
                      Text(S.of(context).completed),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: len,
                        height: len,
                        color: widget.inactiveColor ?? const Color(0xFFF6ABAB),
                      ),
                      Text(S.of(context).unCompleted),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _PieceGridPainter extends CustomPainter {
  final String bitfield;
  final int numPieces;
  final Color? activeColor;
  final Color? inactiveColor;

  _PieceGridPainter(
      this.bitfield, this.numPieces, this.activeColor, this.inactiveColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    var rect = Offset.zero & size;
    // canvas.clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)));
    var len = size.width / 30;
    var piecesStatus = getPieceStatus(bitfield, numPieces);
    // var len = sqrt((size.width * size.height) / numPieces);
    var interval = len * 0.2;
    var posX = interval / 2;
    var posY = 30 + interval / 2;
    for (var i = 0; i < numPieces; i++) {
      var status = piecesStatus[i];
      if (status) {
        paint.color = activeColor ?? const Color(0xFF1665EE);
      } else {
        paint.color = inactiveColor ?? const Color(0xFFF6ABAB);
      }

      canvas.drawRect(Rect.fromLTWH(posX, posY, len * 0.8, len * 0.8), paint);
      posX += len;
      if (posX > size.width) {
        posX = interval / 2;
        posY += len;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _PieceBarPainter extends CustomPainter {
  final String bitfield;
  final int numPieces;
  final Color? activeColor;
  final Color? inactiveColor;

  _PieceBarPainter(
      this.bitfield, this.numPieces, this.activeColor, this.inactiveColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    var rect = Offset.zero & size;
    canvas.clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)));

    var combinedPieces = getCombinedPieces(bitfield, numPieces);
    if(combinedPieces.isEmpty){
      canvas.drawRect(rect,paint..color=inactiveColor ?? const Color(0xFFF6ABAB));
    }
    var posX = 0.0;
    for (var i = 0; i < combinedPieces.length; i++) {
      var piece = combinedPieces[i];

      var width = piece["count"] / numPieces * rect.width;
      if (piece["isCompleted"]) {
        paint.color = activeColor ?? const Color(0xFF1665EE);
      } else {
        paint.color = inactiveColor ?? const Color(0xFFF6ABAB);
      }

      canvas.drawRect(Rect.fromLTWH(posX, 0, width, size.height), paint);
      posX += width;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

List<Map<String, dynamic>> getCombinedPieces(String bitField, int pieceCount) {
  var pieces = getPieceStatus(bitField, pieceCount);
  var combinedPieces = <Map<String, dynamic>>[];

  for (var i = 0; i < pieces.length; i++) {
    var isCompleted = pieces[i];

    if (combinedPieces.isNotEmpty &&
        combinedPieces.last['isCompleted'] == isCompleted) {
      combinedPieces.last['count'] = (combinedPieces.last['count'] ?? 0) + 1;
    } else {
      combinedPieces.add({
        'isCompleted': isCompleted,
        'count': 1,
      });
    }
  }

  return combinedPieces;
}

List<bool> getPieceStatus(String? bitField, int pieceCount) {
  if (pieceCount == 0) {
    return [];
  }

  List<bool> pieces = List.filled(pieceCount, false);

  if (bitField == null) {
    return pieces;
  }

  int pieceIndex = 0;

  for (int i = 0; i < bitField.length; i++) {
    int bitSet = int.parse(bitField[i], radix: 16);

    for (int j = 1; j <= 4; j++) {
      int bit = 1 << (4 - j);
      bool isCompleted = (bitSet & bit) == bit;
      pieces[pieceIndex++] = isCompleted;

      if (pieceIndex >= pieceCount) {
        return pieces;
      }
    }
  }

  return pieces;
}
