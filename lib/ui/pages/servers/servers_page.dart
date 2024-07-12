import 'package:aria2_client/event/base_event.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/providers/aria2_model.dart';
import 'package:aria2_client/ui/pages/add_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../aria2/model/aria2.dart';
import '../../component/pageRoute/my_transparent_page_route.dart';
import 'server_card.dart';

class ServersPage extends StatefulWidget {
  const ServersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServersPageState();
  }
}

class _ServersPageState extends State<ServersPage> {
  late List<Aria2> aria2s;

  @override
  Widget build(BuildContext context) {
    aria2s = Provider.of<Aria2Model>(context).aria2s;
    return Scaffold(
      floatingActionButton: MyServerRefreshButton(totalCount: aria2s.length),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(30, 41, 75, 0.5019607843137255),
              Color.fromRGBO(45, 42, 42, 1.0),
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 110,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "服务器",
                      style:
                          TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MyTransparentPageRoute(builder: (context) {
                            return AddPage();
                          }));
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0),
                            foregroundColor: Colors.greenAccent,
                            elevation: 0,
                            shape: const CircleBorder(),
                            side: BorderSide.none),
                        child: const Icon(
                          Icons.add_circle_outline_outlined,
                          size: 50,
                        ),
                      )),
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: aria2s.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return ServerCard(
                      aria2: aria2s[index],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyServerRefreshButton extends StatefulWidget {
  int totalCount;

  MyServerRefreshButton({super.key, required this.totalCount});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyServerRefreshButtonState();
  }
}

class _MyServerRefreshButtonState extends State<MyServerRefreshButton> {
  bool isTesting = false;
  int completeCount = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      // backgroundColor: Colors.white.withOpacity(0),
      tooltip: isTesting ? 'Refreshing' : 'Refresh',
      // used by assistive technologies
      onPressed: () {
        if (!isTesting) {
          isTesting = true;
          setState(() {});
          completeCount = 0;
          EventBusManager.eventBus.fire(ServerPageEvent(
              scope: EventScope.All,
              eventType: ServerPageEventType.CHECK_AVAILABLE,
              callBack: (value) {
                completeCount++;
                if (completeCount == widget.totalCount) {
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    isTesting = false;
                    setState(() {});
                  });
                }
              }));
        }
      },
      child: isTesting
          ? LoadingAnimationWidget.inkDrop(
              color: Colors.blue,
              size: 30,
            )
          : const Icon(Icons.refresh),
    );
  }
}

enum ServerPageEventType {
  START_MONITOR,
  CHECK_AVAILABLE,
  CHECK_AVAILABLE_AND_START_MONITOR,
  STOP_MONITOR;
}

class ServerPageEvent<T> extends BaseEvent {
  ServerPageEventType eventType;

  ServerPageEvent(
      {super.key,
      super.scope,
      super.value,
      super.callBack,
      required this.eventType});
}
