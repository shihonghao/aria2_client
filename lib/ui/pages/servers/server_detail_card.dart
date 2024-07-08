import 'dart:ui';

import 'package:aria2_client/util/card_util.dart';
import 'package:flutter/material.dart';

class ServerDetailCard extends StatefulWidget {
  Widget hero;

  ServerDetailCard({super.key, required this.hero});

  @override
  State<StatefulWidget> createState() {
    return _ServerDetailCardState();
  }
}

class _ServerDetailCardState extends State<ServerDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromRGBO(255, 255, 255, 0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox.expand(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: 540,
                    height: 150,
                    child: widget.hero,
                  ),
                  Positioned(
                    top: 200,
                    child: SizedBox(
                      width: 540,
                      height: 150,
                      child: CardUtil.buildFilterCard(const Text("aaa")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
