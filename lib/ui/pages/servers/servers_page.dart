import 'package:aria2_client/providers/aria2_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../aria2/model/aria2.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(40, 95, 245, 1.0),
            Colors.lightGreenAccent,
          ],
        ),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    "服务器",
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(height: 110, child: Icon(Icons.add))
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
                  return ServerCard(aria2: aria2s[index],index: index,);
                }),
          ),
        ],
      ),
    );
  }
}
