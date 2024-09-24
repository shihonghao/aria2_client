import 'package:animations/animations.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/component/animation/animated_backdrop_filter.dart';
import 'package:aria2_client/ui/component/animation/cloud_effect.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/animation/star_effect.dart';
import 'package:aria2_client/ui/pages/servers/detail/detail_page.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyActionBar extends StatefulWidget {
  final ActionBarController? actionBarController;
  final Widget expand;
  final Widget content;

  const MyActionBar(
      {super.key,
      this.actionBarController,
      required this.expand,
      required this.content});

  @override
  State<StatefulWidget> createState() {
    return _ServersBar();
  }
}

class _ServersBar extends State<MyActionBar> {
  late ActionBarController _actionBarController;
  StartEffectController? startEffectController;

  @override
  void initState() {
    _actionBarController = widget.actionBarController ?? ActionBarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 55.h, maxHeight: 500.h),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListenableBuilder(
            listenable: _actionBarController,
            builder: (BuildContext context, Widget? child) {
              Widget content = Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: widget.expand),
                  InkWell(
                      onTap: () {
                        _actionBarController.toggle();
                      },
                      child: child),
                ],
              );
              if (Theme.of(context).brightness == Brightness.dark) {
                startEffectController = StartEffectController();
                content = StarEffect(
                  startEffectController: startEffectController!,
                  child: content,
                );
              } else {
                content = CloudEffect(
                  child: content,
                );
              }
              return AnimatedBackdropFilter(
                sigmaX: _actionBarController.isExpend ? 10 : 0,
                sigmaY: _actionBarController.isExpend ? 10 : 0,
                curve: Curves.easeInOutQuart,
                duration: Const.duration500ms,
                child: AnimatedContainer(
                    height: _actionBarController.isExpend
                        ? constraints.maxHeight
                        : constraints.minHeight,
                    curve: Curves.easeInOutQuart,
                    duration: Const.duration500ms,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(0, -1),
                              spreadRadius: 1,
                              color: Colors.grey)
                        ]),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: content)),
              );
            },
            child: widget.content,
          );
        },
      ),
    );
  }
}

Future<bool> checkServerAvailable(ServerModel? model) async {
  if (model == null) {
    return false;
  }
  model.setTesting(true);
  await Future.delayed(const Duration(milliseconds: 500));
  var available = false;
  return await Aria2RpcClient.instance
      .connect(model.aria2.config)
      .then((result) {
    if (result.success) {
      return true;
    }
    throw Exception();
  }).catchError((error) {
    Util.showErrorToast(
        "Can not connect to Aria2 ${model.aria2.config.uri.toString()}");
    return false;
  }).then((isAvailable) {
    available = isAvailable;
    Application.instance.changeServer(model);
    return isAvailable;
  }).whenComplete(() {
    model.setTesting(false);
    model.setAvailable(available);
  });
}

class ActionBarController extends ChangeNotifier {
  bool _isExpend = false;

  bool get isExpend => _isExpend;

  ActionBarController();

  void expend() {
    _isExpend = true;
    notifyListeners();
  }

  void collapse() {
    _isExpend = false;
    notifyListeners();
  }

  void toggle() {
    _isExpend = !_isExpend;
    notifyListeners();
  }
}

class MyActionBarContent extends StatefulWidget {
  final VoidCallback? onSettingTap;
  final VoidCallback? onAddTap;

  const MyActionBarContent({
    super.key,
    this.onSettingTap,
    this.onAddTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _MyActionBarContent();
  }
}

class _MyActionBarContent extends State<MyActionBarContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                widget.onSettingTap?.call();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Icon(
                Icons.settings,
              )),
          Expanded(
              child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: Application.instance.candidateServer,
                      builder: (BuildContext context, ServerModel? value,
                          Widget? child) {
                        return FutureBuilder(
                            future: checkServerAvailable(value),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final selectedServer =
                                    Application.instance.selectedServer.value;
                                return Text(
                                  (selectedServer == null)
                                      ? "请选择服务器"
                                      : selectedServer.aria2.config.name
                                          .toString(),
                                );
                              } else {
                                return LoadingAnimationWidget.staggeredDotsWave(
                                  size: 40.w,
                                  color: const Color(0xFF1A1A3F),
                                );
                              }
                            });
                      }))),
          ElevatedButton(
              onPressed: () {
                widget.onAddTap?.call();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Icon(
                Icons.add,
              ))
        ],
      ),
    );
  }
}

class MyActionBarExpand extends StatefulWidget {
  const MyActionBarExpand({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyActionBarExpand();
  }
}

class _MyActionBarExpand extends State<MyActionBarExpand> {
  late List<ServerModel> _models;
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();

  @override
  void initState() {
    Application.instance.addListener(() {
      if (mounted && Application.instance.aria2s.length != _models.length) {
        updateServerModels(Application.instance.aria2s.values.toList());
      }
    });
    _models = Application.instance.aria2s.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: AnimatedGrid(
                key: _gridKey,
                initialItemCount: _models.length + 1,
                itemBuilder: buildGridItem,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 75.h,
                    crossAxisSpacing: 5.w,
                    mainAxisSpacing: 5.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateServerModels(List<ServerModel> newModels) {
    Util.compareListAndFetch(_models, newModels,
        compare: (o1, o2) => o1.key == o2.key,
        onRemove: (list, removedItem) {
          final removedIndex = _models.indexOf(removedItem);
          _gridKey.currentState!.removeItem(removedIndex, (context, animation) {
            final item =
                buildGridItem(context, removedIndex, animation, removedItem);
            list.remove(removedItem);
            return item;
          }, duration: Const.duration2s);
        },
        onInsert: (list, item) {
          list.add(item);
          _gridKey.currentState!
              .insertItem(_models.length - 2, duration: Const.duration500ms);
        });
  }

  Widget buildGridItem(
      BuildContext context, int index, Animation<double> animation,
      [ServerModel? serverModel]) {
    if (index == _models.length) {
      return Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        color: Theme.of(context).cardColor,
        child: InkWell(
            onTap: () {
              Scaffold.of(this.context).openEndDrawer();
            },
            child: const Center(
              child: Icon(Icons.add),
            )),
      );
    }
    VoidCallback openAction = () {};
    final model = serverModel ?? _models[index];
    return SlideTransition(
        position: animation.drive(CurveTween(curve: Curves.easeOutBack)).drive(
            Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))),
        child: OpenContainer(
            transitionDuration: Const.duration2s,
            closedColor: Theme.of(context).cardColor,
            closedElevation: 5,
            closedShape: Const.roundedRectangleBorder10,
            openShape: Const.roundedRectangleBorder10,
            openElevation: 0,
            openColor: Colors.transparent,
            middleColor: Colors.transparent,
            closedBuilder: (ctx, action) {
              openAction = action;
              final child = InkWell(
                  onDoubleTap: () {
                    if (!_models[index].isCurrent) {
                      Application.instance.changeCandidateServer(model);
                    }
                  },
                  onLongPress: () {
                    if (_models[index] ==
                        Application.instance.selectedServer.value) {
                      openAction.call();
                    }
                  },
                  child: Stack(children: [
                    ValueListenableBuilder(
                        valueListenable: Application.instance.selectedServer,
                        builder: (BuildContext context, ServerModel? value,
                            Widget? child) {
                          bool isSelected = (value != null && value == model);
                          return AnimatedContainer(
                            duration: Const.duration500ms,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isSelected
                                    ? Theme.of(context).highlightColor
                                    : null),
                          );
                        }),
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: Text(
                        model.aria2.config.name,
                      ),
                    ),
                    Positioned(
                        bottom: 10.h,
                        left: 10.w,
                        child: Text(model.aria2.config.uri().toString())),
                    Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: MyAnimatedIcon(
                          duration: Const.duration500ms,
                          onTap: (controller) {
                            Application.instance
                                .removeAria2(model.aria2.config);
                          },
                          size: 18.r,
                          icon: Icons.close,
                        ))
                  ]));

              return child;
            },
            openBuilder: (ctx, action) {
              return const DetailPage();
            }));
  }
}
