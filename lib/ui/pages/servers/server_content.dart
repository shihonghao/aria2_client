import 'package:aria2_client/ui/component/observed_stateful_widget.dart';
import 'package:aria2_client/ui/pages/servers/item/server_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/aria2_model.dart';
import '../../../providers/server_model.dart';
import '../../../util/Util.dart';
import '../../component/card/stack_card_model.dart';

enum ViewType { card, list }

class ServerContent extends StatefulWidget {
  final ViewType type;

  const ServerContent({super.key, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _ServerContentState();
  }
}

class _ServerContentState extends State<ServerContent>
    with WidgetsBindingObserver {
  late final ScrollController _scrollController;
  late final GlobalKey<AnimatedListState> _listKey;
  late List<ServerModel> models;
  late double cardWidth;
  late double cardHeight;

  @override
  void initState() {
    super.initState();
    cardWidth = 550;
    cardHeight = 140;
    models = [];
    _listKey = GlobalKey<AnimatedListState>();
    _scrollController = ScrollController();
  }

  void scrollToCurrent() {
    final interval =
        widget.type == ViewType.list ? cardHeight : cardWidth;
    final currentIndex = context
        .read<Aria2Model>()
        .aria2s
        .values
        .toList()
        .indexWhere((ele) => ele.isCurrent);
    if (currentIndex != -1) {
      _scrollController.animateTo(currentIndex * interval,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<Aria2Model, List<ServerModel>>(
      builder: (_, serverModels, child) {
        return buildViewContent(serverModels);
      },
      shouldRebuild: (oldVal, newVal) {
        return oldVal.length != newVal.length;
      },
      selector: (context, model) => model.aria2s.values.toList(),
    );
  }

  Widget buildViewContent(List<ServerModel> serverModels) {
    return ObservedStatefulWidget(
      key: UniqueKey(),
      onPostFrame: (_) {
        if (models.isEmpty) {
          models.addAll(serverModels);
          _listKey.currentState!.insertAllItems(0, models.length,
              duration: const Duration(milliseconds: 500));
        } else {
          Pair<List<ServerModel>, List<ServerModel>> result =
              Util.compareList(models, serverModels);
          if (result.second.isNotEmpty) {
            for (var removeItem in result.second) {
              final removedIndex = models.indexOf(removeItem);
              _listKey.currentState!.removeItem(removedIndex,
                  (context, animation) {
                final item = buildItem(context, removedIndex, animation);
                models.remove(removeItem);
                return item;
              }, duration: const Duration(milliseconds: 500));
            }
          }
          if (result.first.isNotEmpty) {
            final addStartIndex = models.length;
            models.addAll(result.first);
            _listKey.currentState!.insertAllItems(
                addStartIndex, result.first.length,
                duration: const Duration(milliseconds: 500));
          }
        }
        scrollToCurrent();
      },
      child: AnimatedList(
          scrollDirection: widget.type == ViewType.list
              ? Axis.vertical
              : Axis.horizontal,
          key: _listKey,
          controller: _scrollController,
          itemBuilder: buildItem),
    );

    //buildGroupCard()
  }

  Widget buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return ObservedStatefulWidget(
      onPostFrame: (_) {
        models[index].checkServerAvailable();
      },
      child: SlideTransition(
          position: animation
              .drive(CurveTween(curve: Curves.easeOutBack))
              .drive(Tween<Offset>(
                  begin: const Offset(1, 0), end: const Offset(0, 0))),
          child: buildServerCard(index)),
    );
  }

  Widget buildServerCard(int index) {
    return ServerItem(
      width: cardWidth,
      height: cardHeight,
      model: models[index],
      type: widget.type,
      onTap: () async {
        final interval =
            widget.type == ViewType.list ? cardHeight : cardWidth;
        final viewPort = _scrollController.position.viewportDimension - 24;
        final scrolledOffset = _scrollController.offset;
        final topIndex = (scrolledOffset / interval).floor() + 1;
        final topHiddenOffset = scrolledOffset - (topIndex - 1) * interval;
        final bottomIndex = topIndex +
            ((viewPort - (interval - topHiddenOffset)) / interval).ceil();
        final bottomHiddenOffset = bottomIndex * interval - viewPort;
        final itemIndex = index + 1;

        double needScrolledOffset = 0;
        if (itemIndex == topIndex) {
          needScrolledOffset = scrolledOffset - topHiddenOffset;
        } else if (itemIndex == bottomIndex) {
          needScrolledOffset = bottomHiddenOffset;
        } else {
          return;
        }
        await _scrollController.animateTo(needScrolledOffset,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      },
    );
  }

  buildGroupCard() {
    // }
    // models = serverModels;
    // final currentIndex = models.indexWhere((ele) => ele.isCurrent);
    // if (currentIndex != -1) {
    //   final tailRange = models.getRange(0, currentIndex).toList();
    //   models.removeRange(0, currentIndex);
    //   models.addAll(tailRange);
    // }
    // models = models.reversed.toList();
    //
    // return StackCardGroup<MyDefaultItemModel>.builder(
    //   createModel: (index) => MyDefaultItemModel(),
    //   keepState: true,
    //   initialCardTransform: initTransform,
    //   initialCardBehavior: initCardBehavior,
    //   initialGroupBehavior: initGroupBehavior,
    //   // cardBuilder: (model, child) {
    //   //   return Card(
    //   //       elevation: 10,
    //   //       color: Theme.of(context).highlightColor,
    //   //       child: child);
    //   //   // AnimatedContainer(
    //   //   //   margin: const EdgeInsets.all(10),
    //   //   //   // decoration: BoxDecoration(
    //   //   //   //     // gradient: LinearGradient(colors: [
    //   //   //   //     //   Colors.purple.withOpacity(model.transform.colorOpacity.value),
    //   //   //   //     //   Colors.greenAccent
    //   //   //   //     //       .withOpacity(model.transform.colorOpacity.value),
    //   //   //   //     //   Colors.purple.withOpacity(model.transform.colorOpacity.value)
    //   //   //   //     // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
    //   //   //   //     // color: Theme.of(context).cardColor
    //   //   //   //     //     .withOpacity(model.transform.colorOpacity.value),
    //   //   //   //     borderRadius: BorderRadius.circular(30),
    //   //   //   //     boxShadow: const [
    //   //   //   //       BoxShadow(offset: Offset(3, 3), color: Colors.black26)
    //   //   //   //     ]),
    //   //   //   duration: model.duration,
    //   //   //   child: Card(
    //   //   //       elevation: 10,
    //   //   //       color: Theme.of(context).highlightColor,
    //   //   //       child: child));
    //   // },
    //   itemCount: models.length,
    //   itemBuilder: (index) {
    //     return ServerCard(model: models[index], type: widget.type);
    //   },
    // );
  }

  CardTransform initTransform(int index, int length) {
    final midNum = (length * 0.5).floor();

    return CardTransform(
        size: Size(MediaQuery.of(context).size.width * 0.9, 1000),
        cardSize: Size(MediaQuery.of(context).size.width * 0.9, 1000),
        offset: Offset(
            (midNum - index) *
                MediaQuery.of(context).size.width *
                0.15 /
                length,
            0),
        scale: 1.0 - (length - index) * 0.02,
        // sigmaY: 100,
        // sigmaX: 100,
        colorOpacity: 1);
  }

  initCardBehavior(
      MyDefaultItemModel model, CardGroup<MyDefaultItemModel> group) {
    final behavior = model.behavior;
    final eventBus = group.eventBus;
    behavior.dualForwardTransitionBuilder = (context, animation, child) {
      return SlideTransition(
        position: animation.drive(
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))),
        child: child,
      );
    };

    eventBus.addListener("onFirstTimeEnd", (group, model) {
      // model.updateUI((transform) {
      //   // transform.rotate.transform(1 / 16);
      // }).execute();
    });

    behavior.onHover = (hovered) {
      if (model.isHovered != hovered) {
        model.isHovered = hovered;
        eventBus.notify("hover", group, model);
      }
    };

    // behavior.onTap = () {
    //   if (model.doubleTapCount != 0) {
    //     return;
    //   }
    //   model.tapCount++;
    //   eventBus.notify("tap", group, model);
    //   if (model.tapCount == 2) {
    //     model.tapCount = 0;
    //   }
    // };

    behavior.onDoubleTap = () {
      if (model.tapCount != 1) {
        return;
      }
      model.doubleTapCount++;
      eventBus.notify("doubleTap", group, model);
      if (model.doubleTapCount == 2) {
        model.doubleTapCount = 0;
      }
    };

    eventBus.addListener("doubleTap", (group, tappedModel) {
      if (tappedModel.tapCount != 1) {
        return;
      }
      if (tappedModel.compareTo(model) == 0) {
        if (tappedModel.doubleTapCount == 1) {
          model.updateUI((transform) {
            transform.rotate.transform(0);
            // transform.colorOpacity.transform(0);
            model.transform.size.transform(const Size(1000, 1000));
            model.transform.cardSize.transform(const Size(1000, 1000));
            model.transform.sigmaX.transform(100);
            model.transform.sigmaY.transform(100);
            model.transform.offset.transform(Offset.zero);
            group.behavior.disable();
          }, const Duration(milliseconds: 300)).execute();
        } else {
          group.eventBus.notify("tap", group, model);
        }
      } else {
        if (tappedModel.doubleTapCount == 1) {
          if (model.compareTo(tappedModel) > 0) {
            model.updateUI((transform) {
              transform.opacity.transform(0);
            }).execute();
          }
          model.behavior.disable();
        } else {
          model.behavior.enable();
        }
      }
    });

    eventBus.addListener("tap", (group, tappedModel) {
      if (tappedModel.compareTo(model) == 0) {
        if (model.tapCount == 1) {
          model.updateUI((transform) {
            transform.reset();
            if (model.index != 0) {
              // transform.offset
              //     .transform(Offset(0, transform.offset.value.dy - 40));
            }

            transform.scale.transform(1.0);
          }).execute();

          // model.transform.scale.transform(1.5);
        } else {
          model.updateUI((transform) {
            model.transform.reset();
          }).then((_) {
            group.behavior.enable();
          }, autoRefresh: false).execute();
        }
      } else {
        if (tappedModel.tapCount == 1) {
          model.updateUI((transform) {
            transform.reset();
            if (model.tapCount != 0) {
              model.reset();
              model.tapCount = 0;
            }
            if (model.compareTo(tappedModel) > 0) {
              transform.offset.transform(Offset(
                  transform.offset.value.dx - 350, transform.offset.value.dy));
            }
          }).execute();
        } else {
          model.updateUI((transform) {
            model.transform.reset();
            model.behavior.enable();
          }).execute();
        }
      }
    });
  }

  void initGroupBehavior(
      CardGroup<MyDefaultItemModel> group, List<Widget> children) {
    final behavior = group.behavior;

    behavior.onHorizontalDragEnd = (details) {
      final last = group.modelMap.values.last;
      final midNum = (group.modelMap.length / 2).ceil();
      final interval = MediaQuery.of(context).size.width *
          0.15 /
          (group.modelMap.length - 1);

      last.updateUI((transform) {
        transform.offset.transform(Offset(
            MediaQuery.of(context).size.width * 0.01,
            transform.offset.value.dy));
        // transform.opacity.transform(0.5);
        transform.angle.transform(1 / 4);
      }).execute();

      group.modelMap.forEach((key, value) {
        if (last != value) {
          value.updateUI((transform) {
            transform.scale.transform(
                1.0 - (group.modelMap.length - value.index - 1) * 0.02);
            transform.offset
                .transform(Offset((midNum - value.index - 1) * interval, 0));
          }).execute();
        }
      });
      final removed = children.removeLast();
      Future.delayed(const Duration(milliseconds: 500), () {
        // last.transform.angle.transform(-1 / 32);
        children.insert(0, removed);
        group.refreshUI();
        Future.delayed(const Duration(milliseconds: 100), () {
          last.updateUI((transform) {
            last.transform.offset.transform(Offset((midNum) * interval, 0));
            last.transform.angle.reset();
            last.transform.scale.transform(1.0 - group.modelMap.length * 0.02);
            transform.opacity.transform(1.0);
          }).execute();
        });
      });
    };
  }
}
