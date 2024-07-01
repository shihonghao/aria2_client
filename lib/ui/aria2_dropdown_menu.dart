import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../aria2/model/aria2.dart';
import '../providers/aria2_model.dart';

class Aria2DropdownMenu extends StatefulWidget {
  const Aria2DropdownMenu({super.key});

  @override
  State<Aria2DropdownMenu> createState() => _AriaDropdownState();
}

class _AriaDropdownState extends State<Aria2DropdownMenu>
    with SingleTickerProviderStateMixin {
  bool isConnecting = false;

  @override
  void initState() {
    super.initState();
  }

  setConnecting(bool connecting) {
    setState(() {
      isConnecting = connecting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
            visible: isConnecting,
            child: Container(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.red, size: 50))),
        Visibility(
            visible: !isConnecting,
            child: Selector<Aria2Model, int>(
              builder: (BuildContext context, int value, Widget? child) {
                List<DropdownMenuEntry<String>> menuList = [];
                Aria2Model model = context.read<Aria2Model>();
                for (Aria2 aria2 in model.aria2s) {
                  menuList.add(DropdownMenuEntry(
                    value: aria2.config.name,
                    label: aria2.config.name,
                  ));
                }
                return DropdownMenu(
                  width: 200,
                  leadingIcon: const Icon(TDIcons.server),
                  dropdownMenuEntries: menuList,
                  label: const Text("Aria2服务"),
                  initialSelection: model.current?.config.name,
                  inputDecorationTheme:
                      const InputDecorationTheme(border: InputBorder.none),
                  controller: TextEditingController(),
                  onSelected: (selected) {
                    if (model.current?.config.name == selected) {
                      return;
                    }
                    setConnecting(true);
                    model.changeServer(selected!).then((value) {
                      setConnecting(false);
                    });
                  },
                );
              },
              selector: (context, model) => model.aria2s.length,
            )),
      ],
    );
  }
}
