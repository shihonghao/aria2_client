import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/model/task.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'task_list_view.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DownloadPageState();
  }
}

class _DownloadPageState extends State<DownloadPage> {
  late Offset _offset;
  late int _currentIndex;

  @override
  void initState() {
    _offset = Offset.zero;
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     // floatingActionButton: ExpandableFab(
    //     //   distance: 112,
    //     //   children: [
    //     //     ActionButton(
    //     //       onPressed: () => showModal<void>(
    //     //         configuration: FadeScaleTransitionConfiguration(
    //     //             transitionDuration: Const.duration500ms,
    //     //             reverseTransitionDuration: Const.duration200ms),
    //     //         context: context,
    //     //         builder: (BuildContext context) {
    //     //           return const CreateTaskDialog();
    //     //         },
    //     //       ),
    //     //       icon: const Icon(Icons.add),
    //     //     ),
    //     //     ActionButton(
    //     //       onPressed: () =>
    //     //           Util.showTextAlert(context, "确定开始全部任务?", onConfirm: () {
    //     //         Aria2RpcClient.instance.unpauseAll();
    //     //       }),
    //     //       icon: const Icon(Icons.play_arrow),
    //     //     ),
    //     //     ActionButton(
    //     //       onPressed: () =>
    //     //           Util.showTextAlert(context, "确定开始暂停全部任务?", onConfirm: () {
    //     //         Aria2RpcClient.instance.pauseAll();
    //     //       }),
    //     //       icon: const Icon(Icons.stop),
    //     //     ),
    //     //     ActionButton(
    //     //       onPressed: () => Util.showTextAlert(context, "确定开始移除全部任务?"),
    //     //       icon: const Icon(Icons.remove),
    //     //     ),
    //     //   ],
    //     // ),
    //     // This trailing comma makes auto-formatting nicer for build methods.
    //     body: DefaultTabController(
    //         length: 5,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             Expanded(
    //               child: Scaffold(
    //                 appBar: TabBar(
    //                     overlayColor:
    //                         WidgetStateProperty.all<Color>(Colors.transparent),
    //                     splashFactory: NoSplash.splashFactory,
    //                     dividerHeight: 0,
    //                     // 多个标签时滚动加载
    //                     tabAlignment: TabAlignment.fill,
    //                     isScrollable: false,
    //                     // 标签指示器的颜色
    //                     // indicatorColor: Colors.blue,
    //                     // 标签的颜色
    //                     labelColor: Colors.blue,
    //                     // 未选中标签的颜色
    //                     unselectedLabelColor: Colors.white,
    //                     // 指示器的大小
    //                     indicatorSize: TabBarIndicatorSize.tab,
    //                     // 指示器的权重，即线条高度
    //                     indicatorWeight: 0,
    //                     indicatorPadding:
    //                         const EdgeInsets.fromLTRB(0, 10, 0, 10),
    //                     indicator: BoxDecoration(
    //                       color: Theme.of(context).splashColor,
    //                       borderRadius: BorderRadius.circular(5),
    //                     ),
    //                     onTap: (index) {},
    //                     tabs: [
    //                       Tab(text: S.of(context).downloading),
    //                       Tab(text: S.of(context).waiting),
    //                       Tab(text: S.of(context).paused),
    //                       Tab(text: S.of(context).completed),
    //                       Tab(text: S.of(context).error),
    //                       // Tab(text: "已删除"),
    //                     ]),
    //                 // 标签页所对应的页面
    //                 body: Scaffold(
    //                     // backgroundColor: Theme.of(context).primaryColor,
    //                     body: CloudEffect(
    //                       child: TabBarView(children: [
    //                         TaskListView(
    //                           key: UniqueKey(),
    //                           status: TaskStatus.active,
    //                         ),
    //                         TaskListView(
    //                           key: UniqueKey(),
    //                           status: TaskStatus.waiting,
    //                         ),
    //                         TaskListView(
    //                           key: UniqueKey(),
    //                           status: TaskStatus.paused,
    //                         ),
    //                         TaskListView(
    //                           key: UniqueKey(),
    //                           status: TaskStatus.complete,
    //                         ),
    //                         TaskListView(
    //                           key: UniqueKey(),
    //                           status: TaskStatus.error,
    //                         ),
    //                         // TaskPage(
    //                         //   status: TaskStatus.removed,
    //                         // ),
    //                       ]),
    //                     )),
    //               ),
    //             )
    //           ],
    //         )));
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Swiper.children(
        curve: Curves.easeIn,
        pagination: SwiperCustomPagination(builder: (context, config) {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 40.h,
              child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 3,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildTabItems(config))),
            ),
          );
        }),
        children: [
          TaskListView(
            key: UniqueKey(),
            status: TaskStatus.active,
          ),
          TaskListView(
            key: UniqueKey(),
            status: TaskStatus.waiting,
          ),
          TaskListView(
            key: UniqueKey(),
            status: TaskStatus.paused,
          ),
          TaskListView(
            key: UniqueKey(),
            status: TaskStatus.complete,
          ),
          TaskListView(
            key: UniqueKey(),
            status: TaskStatus.error,
          ),
        ],
      ),
    ));
  }

  List<Widget> buildTabItems(SwiperPluginConfig config) {
    List<Widget> tabItems = [];
    int index = 0;
    final strs = ["下载中", "等待中", "已完成", "已停止", "错误"];
    for (String item in strs) {
      final idx = index;
      tabItems.add(InkWell(
          onTap: () {
            config.controller.move(idx);
          },
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
              decoration: BoxDecoration(
                  color: config.activeIndex == idx
                      ? Colors.amber
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              duration: Const.duration300ms,
              child: Center(
                  child: Text(
                item,
                style: TextStyle(
                    color: idx == config.activeIndex ? Colors.black : null),
              )))));
      tabItems.add(const VerticalDivider(
        width: 0,
        color: Colors.transparent,
      ));
      index++;
    }

    tabItems.removeLast();
    return tabItems;
  }
}
