import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  final FormItem formItem;
  final ValueChanged<dynamic>? onChange;

  const SettingsItem({
    super.key,
    required this.formItem,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _SettingsItemState();
  }
}

class _SettingsItemState extends State<SettingsItem> {
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
                  widget.formItem.leadingBuilder == null
                      ? buildLeading()
                      : widget.formItem.leadingBuilder!(context),
                  widget.formItem.contentBuilder == null
                      ? buildContent()
                      : widget.formItem.contentBuilder!(context),
                  widget.formItem.trailingBuilder == null
                      ? buildTrailing()
                      : widget.formItem.trailingBuilder!(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  onConfirm(dynamic value) {
    if (widget.formItem.value is int) {
      widget.formItem.value = int.parse(value.toString());
    } else if (widget.formItem.value is double) {
      widget.formItem.value = double.parse(value.toString());
    } else {
      widget.formItem.value = value;
    }
    widget.formItem.callOnChange();
    IHive.settings.put(widget.formItem.key, widget.formItem.value).then((_) {
      setState(() {});
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
        if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm == "1")) {
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
      return Expanded(
        child: Row(
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
        ),
      );
    }
    final text = widget.formItem.type == FormItemType.switch_
        ? (widget.formItem.value ? "是" : "否")
        : widget.formItem.value.toString();
    return Expanded(
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (widget.formItem.readOnly) {
              return;
            }
            openEditDialog();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: widget.formItem.alignment,
            child: Text(text),
          )),
    );
  }

  Widget buildTrailing() {
    return const SizedBox(
      width: 0,
    );
  }

  Widget buildLeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(widget.formItem.label!),
    );
  }
}

buildUnitTrailing(BuildContext context, String unit, {Color? color}) {
  return Container(
    constraints: const BoxConstraints(minWidth: 40),
    child: Card(
        color: color ?? Theme.of(context).splashColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(child: Text(unit)),
        )),
  );
}
