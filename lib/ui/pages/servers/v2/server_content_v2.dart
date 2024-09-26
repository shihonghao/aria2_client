import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/component/observed_stateful_widget.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServerContent extends StatefulWidget {
  const ServerContent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServerContentState();
  }
}

class _ServerContentState extends State<ServerContent>
    with WidgetsBindingObserver {
  late final ScrollController _scrollController;
  late final SwiperController _swiperController;
  late final GlobalKey<AnimatedListState> _listKey;
  late List<ServerModel> _models;
  late double _interval;

  @override
  void initState() {
    super.initState();
    _interval = 105.h;
    _listKey = GlobalKey<AnimatedListState>();
    _scrollController = ScrollController();

    Application.instance.addListener(() {
      if (mounted && Application.instance.aria2s.length != _models.length) {
        updateServerModels(Application.instance.aria2s.values.toList());
      }
    });
    _models = [];
  }

  void scrollToCurrent() {
    if (Application.instance.selectedServer.value == null) {
      return;
    }
    final selectedIndex =
        _models.indexOf(Application.instance.selectedServer.value!);
    if (selectedIndex != -1) {
      _scrollController.animateTo(selectedIndex * _interval,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ObservedStatefulWidget(
        onPostFrame: (_) {
          updateServerModels(Application.instance.aria2s.values.toList());
        },
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 40.w),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(color: Colors.black.withOpacity(0.25))
          // ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: const Divider(),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: SizedBox(
              //         height: 130.h,
              //         child: const Card(
              //           margin: EdgeInsets.zero,
              //          shape: RoundedRectangleBorder(
              //            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              //          ),
              //          color: Colors.blue,
              //           child:  Text("服务器"),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Expanded(
                child: AnimatedList(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    initialItemCount: _models.length,
                    scrollDirection: Axis.vertical,
                    key: _listKey,
                    controller: _scrollController,
                    itemBuilder: buildListItem),
              ),
            ],
          ),
        ));
  }

  Widget buildListItem(context, index, animation) {
    return ObservedStatefulWidget(
        onPostFrame: (_) {
          // _models[index].checkServerAvailable();
        },
        child: SlideTransition(
            position: animation
                .drive(CurveTween(curve: Curves.easeOutBack))
                .drive(Tween<Offset>(
                    begin: const Offset(1, 0), end: const Offset(0, 0))),
            child: buildItem(context, index)));
  }

  Widget buildItem(BuildContext context, int index) {
    return SizedBox(
      height: 100.h,
      child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(

                  // decoration:  BoxDecoration(
                  //     // borderRadius: BorderRadius.circular(10),
                  //     // gradient: const LinearGradient(
                  //     //     colors: [
                  //     //       Color.fromRGBO(34, 102, 125, 1.00),
                  //     //       Color.fromRGBO(177, 179, 95, 0)
                  //     //     ],
                  //     //     begin: Alignment.centerLeft,
                  //     //     end: Alignment.centerRight),
                  //   // boxShadow: [
                  //   //   BoxShadow(offset: const Offset(0, 0),color: Colors.black.withOpacity(0.25))
                  //   // ]
                  // ),
                  child: const Center(
                    child: Text("aaaaa"),
                  ),
                ),
              ),
            ),
            const Divider(height: 1,)
          ],
        ),
    );
  }

  void updateServerModels(List<ServerModel> newModels) {
    Util.compareListAndFetch(_models, newModels,
        compare: (o1, o2) => o1.key == o2.key,
        onRemove: (list, removedItem) {
          final removedIndex = _models.indexOf(removedItem);
          _listKey.currentState!.removeItem(removedIndex, (context, animation) {
            final item = buildListItem(context, removedIndex, animation);
            list.remove(removedItem);
            return item;
          }, duration: Const.duration500ms);
        },
        onInsert: (list, item) {
          list.add(item);
          _listKey.currentState!
              .insertItem(_models.length - 1, duration: Const.duration500ms);
        });

    scrollToCurrent();
  }
}
