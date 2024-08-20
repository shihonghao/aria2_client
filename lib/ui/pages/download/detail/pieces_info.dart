import 'package:aria2_client/ui/pages/download/detail/piece_bar.dart';
import 'package:flutter/material.dart';

class PiecesInfo extends StatefulWidget {
  final ValueNotifier<Piece> piece;
  final double? height;

  const PiecesInfo({
    super.key,
    required this.piece,
    this.height,
  });

  @override
  State<StatefulWidget> createState() {
    return _PiecesInfoState();
  }
}

class _PiecesInfoState extends State<PiecesInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).splashColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: widget.piece,
          builder: (context, value, child) {
            return SingleChildScrollView(
                child: PieceBar(
              bitfield: value.bitfield,
              numPieces: value.numPieces,
              type: PiecesInfoType.grid,
              activeColor: Colors.amberAccent,
              inactiveColor: Theme.of(context).splashColor,
            ));
          },
        ),
      ),
    );
  }
}

class Piece {
  final int numPieces;

  final String bitfield;

  Piece({required this.numPieces, required this.bitfield});
}
