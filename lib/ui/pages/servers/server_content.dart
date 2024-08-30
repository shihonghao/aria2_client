import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/component/observed_stateful_widget.dart';
import 'package:aria2_client/ui/pages/servers/item/server_item.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

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
  late final SwiperController _swiperController;
  late final GlobalKey<AnimatedListState> _listKey;
  late List<ServerModel> _models;
  late double _interval;

  @override
  void initState() {
    super.initState();
    if (widget.type == ViewType.list) {
      _interval = 550;
      _listKey = GlobalKey<AnimatedListState>();
      _scrollController = ScrollController();
    } else {
      _swiperController = SwiperController();
    }

    Application.instance.addListener(() {
      if (mounted && Application.instance.aria2s.length != _models.length) {
        updateServerModels(Application.instance.aria2s.values.toList());
      }
    });
    _models = widget.type == ViewType.list
        ? []
        : Application.instance.aria2s.values.toList();
  }

  void scrollToCurrent() {
    if (Application.instance.selectedServer.value == null) {
      return;
    }
    final selectedIndex =
        _models.indexOf(Application.instance.selectedServer.value!);
    if (selectedIndex != -1) {
      if (widget.type == ViewType.list) {
        _scrollController.animateTo(selectedIndex * _interval,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        _swiperController.move(selectedIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ObservedStatefulWidget(
        onPostFrame: (_) {
          updateServerModels(Application.instance.aria2s.values.toList());
        },
        child: widget.type == ViewType.list
            ? AnimatedList(
                initialItemCount: _models.length,
                scrollDirection: Axis.vertical,
                key: _listKey,
                controller: _scrollController,
                itemBuilder: buildListItem)
            : Swiper(
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeColor: Theme.of(context).indicatorColor)),
                itemCount: _models.length,
                itemBuilder: buildItem,
                autoplay: false,
                controller: _swiperController,
              ));
  }

  Widget buildListItem(context, index, animation) {
    return ObservedStatefulWidget(
        onPostFrame: (_) {
          _models[index].checkServerAvailable();
        },
        child: SlideTransition(
            position: animation
                .drive(CurveTween(curve: Curves.easeOutBack))
                .drive(Tween<Offset>(
                    begin: const Offset(1, 0), end: const Offset(0, 0))),
            child: buildItem(context, index)));
  }

  Widget buildItem(BuildContext context, int index) {
    return ServerItem(
      model: _models[index],
      type: widget.type,
      onTap: () => _handleItemTap(index),
      width: 550,
      height: 140,
    );
  }

  Future<void> _handleItemTap(int index) async {
    if (widget.type == ViewType.card) {
      return;
    }
    final viewPort = _scrollController.position.viewportDimension - 24;
    final scrolledOffset = _scrollController.offset;
    final topIndex = (scrolledOffset / _interval).floor() + 1;
    final topHiddenOffset = scrolledOffset - (topIndex - 1) * _interval;
    final bottomIndex = topIndex +
        ((viewPort - (_interval - topHiddenOffset)) / _interval).ceil();
    final bottomHiddenOffset = bottomIndex * _interval - viewPort;
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
  }

  void updateServerModels(List<ServerModel> newModels) {
    if (widget.type == ViewType.list) {
      Util.compareListAndFetch(_models, newModels,
          compare: (o1, o2) => o1.key == o2.key,
          onRemove: (list, removedItem) {
            final removedIndex = _models.indexOf(removedItem);
            _listKey.currentState!.removeItem(removedIndex,
                (context, animation) {
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
    } else {
      Util.compareListAndFetch(
        _models,
        newModels,
        compare: (o1, o2) => o1.key == o2.key,
      );
      setState(() {});
    }
    scrollToCurrent();
  }
}
