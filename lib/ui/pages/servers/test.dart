import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/ui/pages/servers/servers_page.dart';
import 'package:flutter/material.dart';

import '../../../event/event_bus_manager.dart';

class TestW extends StatefulWidget {
  String id;

  TestW({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWState();
  }
}

class TestWState extends State<TestW> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            EventBusManager.eventBus.fire(ServerPageEvent(
                key: widget.id, eventType: ServerPageEventType.START_MONITOR));
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blue.withOpacity(0),
              foregroundColor: Colors.greenAccent,
              elevation: 0,
              shape: const CircleBorder(),
              side: BorderSide.none),
          child: const Text("ceshi"),
        ),
      ),
    );
  }
}
