part of 'detail_page.dart';

class OptionItem extends StatefulWidget {
  final FormItem formItem;
  final ValueChanged<dynamic>? onChange;

  const OptionItem({
    super.key,
    required this.formItem,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _OptionItemState();
  }
}

class _OptionItemState extends State<OptionItem> {
  final tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.formItem.tooltip != null
                      ? Tooltip(
                          key: tooltipKey,
                          triggerMode: TooltipTriggerMode.manual,
                          message: widget.formItem.tooltip ?? "",
                          child: MyAnimatedIcon(
                            onTap: (controller) {
                              controller.forward();
                              tooltipKey.currentState!.ensureTooltipVisible();
                            },
                            icon: Icons.info_outline_rounded,
                            color: Theme.of(context).indicatorColor,
                            size: 20,
                            duration: Const.duration300ms,
                          ),
                        )
                      : const Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.transparent,
                        )),
                  widget.formItem.leadingBuilder == null
                      ? buildLeading()
                      : widget.formItem.leadingBuilder!(context),
                  Expanded(child: buildContent()),
                  widget.formItem.trailingBuilder == null
                      ? buildTrailing()
                      : widget.formItem.trailingBuilder!(context),
                  // Offstage(
                  //     offstage: widget.formItem.trailing == null,
                  //     child: widget.formItem.trailing),
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  //     child: buildOption()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  onConfirm(dynamic value) {
    widget.onChange?.call(value);
    Aria2RpcClient.instance
        .changeGlobalOption(widget.formItem.key, value.toString())
        .then((result) {
      if (result.success) {
        setState(() {
          if (widget.formItem.value is int) {
            widget.formItem.value = int.parse(value.toString());
          } else if (widget.formItem.value is double) {
            widget.formItem.value = double.parse(value.toString());
          } else {
            widget.formItem.value = value;
          }
        });
      } else {
        Util.showErrorToast("修改失败,检查网络或aria2服务");
      }
    });
  }

  void openEditDialog() {
    switch (widget.formItem.type) {
      case FormItemType.input:
        Util.showInputDialog(context,
            text: widget.formItem.value.toString(), onConfirm: onConfirm);
        break;
      case FormItemType.switch_:
        final newVal = !widget.formItem.value;
        if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm) == "1") {
          Util.showConfirmDialog(context,
              title: "修改 [ ${widget.formItem.label} ]",
              content: "是否修改  [ ${widget.formItem.label} ]  为  <$newVal>",
              onConfirm: () {
            onConfirm(newVal);
          });
        } else {
          onConfirm(newVal);
        }
        break;
      default:
    }
  }

  buildContent() {
    if (widget.formItem.type == FormItemType.select) {
      return Row(
        children: [
          Expanded(child: Container()),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                '请选择',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: widget.formItem.options!
                  .map((FormItemOption item) => DropdownMenuItem<String>(
                        alignment: AlignmentDirectional.center,
                        value: item.value,
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: widget.formItem.value,
              onChanged: (String? value) {
                if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm) ==
                    "1") {
                  Util.showConfirmDialog(context,
                      title: "修改 [ ${widget.formItem.label} ]",
                      content:
                          "是否修改  [ ${widget.formItem.label} ]  为  <$value>",
                      onConfirm: () {
                    onConfirm(value);
                  });
                } else {
                  onConfirm(value);
                }
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                width: 100,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ],
      );
    }
    final text = widget.formItem.type == FormItemType.switch_
        ? (widget.formItem.value ? "是" : "否")
        : widget.formItem.value.toString();
    return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (widget.formItem.readOnly) {
            return;
          }
          openEditDialog();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.centerRight,
          child: Text(text),
        ));
  }

  Widget buildTrailing() {
    return const SizedBox(
      width: 0,
    );
  }

  buildLeading() {
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          alignment: Alignment.centerRight,
          // width: constraints.maxWidth * 0.3,
          child: Text(widget.formItem.label!)),
    );
  }
}

buildUnitTrailing(BuildContext context, String unit) {
  return Container(
    constraints: const BoxConstraints(minWidth: 60),
    child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(child: Text(unit)),
        )),
  );
}
