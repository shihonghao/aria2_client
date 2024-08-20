import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(BuildContext context, FormItem item);
typedef GroupBuilder = Widget Function(BuildContext context, FormGroup group);

class FormGroupStyle {
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final Color? textColor;
  final Color? leadingColor;
  final Color? trailingColor;
  final Color? iconColor;
  final Color? dividerColor;
  final Color? borderColor;
  final Color? shadowColor;
  final Color? elevationColor;
  final Color? elevationShadowColor;
  final Color? elevationColorDark;
  final Color? elevationShadowColorDark;
  final Color? elevationColorLight;
  final double? elevation;

  const FormGroupStyle({
    this.elevation,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.textColor,
    this.leadingColor,
    this.trailingColor,
    this.iconColor,
    this.dividerColor,
    this.borderColor,
    this.shadowColor,
    this.elevationColor,
    this.elevationShadowColor,
    this.elevationColorDark,
    this.elevationShadowColorDark,
    this.elevationColorLight,
  });
}

class FormGroup {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;
  final bool isEnableExpanded;
  final bool showDivider;
  final FormGroupStyle style;
  final List<FormItem> items;
  final ItemBuilder? itemBuilder;

  FormGroup({
    required this.title,
    required this.items,
    this.itemBuilder,
    this.leading,
    this.trailing,
    this.expanded = false,
    this.showDivider = true,
    this.isEnableExpanded = true,
    this.style = const FormGroupStyle(),
  });
}

class FormItem<T> {
  final String key;
  final String? label;
  final FormItemType type;
  final WidgetBuilder? leadingBuilder;
  final WidgetBuilder? contentBuilder;
  final WidgetBuilder? trailingBuilder;
  final Widget? option;
  T? value;
  final bool showDivider;
  final bool readOnly;
  final String? tooltip;
  final List<FormItemOption>? options;
  final Alignment alignment;
  final ItemBuilder? builder;
  final ValueChanged<T>? onChange;
  final Listenable? listenable;

  FormItem(
      {required this.key,
      required this.type,
      this.listenable,
      this.label,
      this.value,
      this.leadingBuilder,
      this.trailingBuilder,
      this.contentBuilder,
      this.option,
      this.readOnly = false,
      this.tooltip,
      this.builder,
      this.alignment = Alignment.centerRight,
      this.showDivider = true,
      this.onChange,
      this.options})
      : assert(
            (type == FormItemType.select &&
                    (options != null && options.isNotEmpty)) ||
                type != FormItemType.select,
            "Select option can not be empty!!");

  void callOnChange() {
    if ( value == null){
      return;
    }
    onChange?.call(value as T);
  }
}

class FormItemOption {
  final String label;
  final String value;

  FormItemOption({required this.label, required this.value});
}

enum FormItemType {
  input,
  select,
  switch_,
  checkbox,
  radio,
  textarea,
}

class MyForm extends StatefulWidget {
  final List<FormGroup> groups;

  const MyForm({super.key, required this.groups});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildForm(),
    );
  }

  List<Widget> buildForm() {
    final form = <Widget>[];
    for (var group in widget.groups) {
      form.add(ExpansionTileCard(
        backgroundColor: group.style.backgroundColor,
        collapsedBackgroundColor: group.style.collapsedBackgroundColor,
        elevation: group.style.elevation,
        textColor: group.style.textColor,
        leading: group.leading,
        trailing: group.trailing,
        title: Text(group.title),
        childrenPadding: EdgeInsets.zero,
        initiallyExpanded: group.expanded,
        isEnableExpanded: group.isEnableExpanded,
        children: _buildChildren(group),
      ));
      if (group.showDivider) {
        form.add(
          Const.divider10,
        );
      }
    }
    return form;
  }

  List<Widget> _buildChildren(FormGroup group) {
    final items = <Widget>[];
    for (var item in group.items) {
      items.add(item.builder == null
          ? (group.itemBuilder == null
              ? _DefaultFormItem(item: item)
              : group.itemBuilder!(context, item))
          : item.builder!(context, item));
      if (item.showDivider) {
        items.add(Const.divider10);
      }
    }
    return items;
  }
}

class _DefaultFormItem extends StatefulWidget {
  final FormItem item;

  const _DefaultFormItem({required this.item});

  @override
  State<StatefulWidget> createState() {
    return _DefaultFormItemState();
  }
}

class _DefaultFormItemState extends State<_DefaultFormItem> {
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
                  (widget.item.leadingBuilder == null
                          ? buildLeading
                          : widget.item.leadingBuilder!)
                      .call(context),
                  wrapperListenable(widget.item.contentBuilder == null
                      ? buildContent
                      : widget.item.contentBuilder!),
                  (widget.item.trailingBuilder == null
                          ? buildTrailing
                          : widget.item.trailingBuilder!)
                      .call(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  onConfirm(dynamic value) {
    if (widget.item.value is int) {
      widget.item.value = int.parse(value.toString());
    } else if (widget.item.value is double) {
      widget.item.value = double.parse(value.toString());
    } else {
      widget.item.value = value;
    }
    widget.item.onChange?.call(widget.item.value);
    IHive.settings.put(widget.item.key, widget.item.value).then((_) {
      setState(() {});
    });
  }

  void openEditDialog() {
    switch (widget.item.type) {
      case FormItemType.input:
        Util.showInputDialog(context,
            text: widget.item.value.toString(), onConfirm: onConfirm);
        break;
      case FormItemType.switch_:
        final newVal = !widget.item.value;
        if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm == "1")) {
          Util.showConfirmDialog(context,
              title: "修改 [ ${widget.item.label} ]",
              content: "是否修改  [ ${widget.item.label} ]  为  <$newVal>",
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

  Widget buildContent(BuildContext context) {
    if (widget.item.type == FormItemType.select) {
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
                items: widget.item.options!
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
                value: widget.item.value,
                onChanged: (String? value) {
                  if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm) ==
                      "1") {
                    Util.showConfirmDialog(context,
                        title: "修改 [ ${widget.item.label} ]",
                        content: "是否修改  [ ${widget.item.label} ]  为  <$value>",
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
    final text = widget.item.type == FormItemType.switch_
        ? (widget.item.value ? "是" : "否")
        : widget.item.value.toString();
    return Expanded(
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (widget.item.readOnly) {
              return;
            }
            openEditDialog();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: widget.item.alignment,
            child: Text(text),
          )),
    );
  }

  Widget buildTrailing(BuildContext context) {
    return const SizedBox(
      width: 0,
    );
  }

  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(widget.item.label ?? ""),
    );
  }

  Widget wrapperListenable(WidgetBuilder builder) {
    if (widget.item.listenable != null) {
      return ListenableBuilder(
        listenable: widget.item.listenable!,
        builder: (context, child) {
          return builder.call(context);
        },
      );
    } else {
      return builder.call(context);
    }
  }
}
