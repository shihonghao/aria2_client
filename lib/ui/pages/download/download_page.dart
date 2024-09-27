import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/ui/pages/download/my_swiper_pagination.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'task_list_view.dart';

List<String> strs = const ["下载中", "等待中", "已完成", "已停止", "错误"];

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
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Swiper.children(
        loop: false,
        pagination: SwiperCustomPagination(builder: (context, config) {
          return Align(
            alignment: Alignment.topCenter,
            child: MySwiperPagination(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Center(
                      child: Text(
                    strs[index],
                    style: TextStyle(
                        color: config.activeIndex == index
                            ? Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black
                            : null),
                  ));
                },
                activeColor: Theme.of(context).indicatorColor,
                color: Colors.white,
                itemSize: Size(60.w, 30.h),
                space: 5.w,
                controller: config.pageController!,
                initialIndex: 0),
          );
        }),
        children: [
          TaskListView(
            status: TaskStatus.active,
          ),
          TaskListView(
            status: TaskStatus.waiting,
          ),
          TaskListView(
            status: TaskStatus.paused,
          ),
          TaskListView(
            status: TaskStatus.complete,
          ),
          TaskListView(
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
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
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
