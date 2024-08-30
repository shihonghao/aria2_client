import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class FormItem<T> extends ChangeNotifier {
  final String key;
  final String? label;
  final FormItemType type;
  final WidgetBuilder? leadingBuilder;
  final WidgetBuilder? contentBuilder;
  final WidgetBuilder? trailingBuilder;
  final Widget? option;
  T? _value;
  final bool showDivider;
  final bool readOnly;
  final String? tooltip;
  final List<FormItemOption>? options;
  final Alignment alignment;
  final ItemBuilder? builder;
  final ValueChanged<T>? onChange;
  final Listenable? listenable;

  set value(T? val) {
    _value = val;
    notifyListeners();
  }

  T? get value => _value;

  FormItem(
      {required this.key,
      required this.type,
      this.listenable,
      this.label,
      T? value,
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
      : _value = value,
        assert(
            (type == FormItemType.select &&
                    (options != null && options.isNotEmpty)) ||
                type != FormItemType.select,
            "Select option can not be empty!!");

  void callOnChange() {
    if (_value == null) {
      return;
    }
    onChange?.call(_value as T);
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
              ? DefaultFormItem(item: item)
              : group.itemBuilder!(context, item))
          : item.builder!(context, item));
      if (item.showDivider) {
        items.add(Const.divider10);
      }
    }
    return items;
  }
}

class DefaultFormItem extends StatefulWidget {
  final FormItem item;
  final void Function(FormItem item, dynamic value)? onConfirm;

  const DefaultFormItem({super.key, required this.item, this.onConfirm});

  @override
  State<StatefulWidget> createState() {
    return _DefaultFormItemState();
  }
}

class _DefaultFormItemState extends State<DefaultFormItem> {
  late void Function(FormItem item, dynamic value) _onConfirm;
  late FormItem _item;
  late GlobalKey<TooltipState> _tooltipKey;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    _onConfirm = widget.onConfirm ??
        (FormItem item, dynamic value) {
          if (_item.value is int) {
            _item.value = int.parse(value.toString());
          } else if (_item.value is double) {
            _item.value = double.parse(value.toString());
          } else {
            _item.value = value;
          }
          _item.onChange?.call(_item.value);
          IHive.settings.put(_item.key, _item.value).then((_) {
            setState(() {});
          });
        };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DefaultFormItem oldWidget) {
    _updateItem();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return IntrinsicHeight(
              child: ListenableBuilder(
                listenable: _item,
                builder: (BuildContext context, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (_item.leadingBuilder == null
                              ? buildLeading
                              : _item.leadingBuilder!)
                          .call(context),
                      (_item.contentBuilder == null
                              ? buildContent
                              : _item.contentBuilder!)
                          .call(context),
                      (_item.trailingBuilder == null
                              ? buildTrailing
                              : _item.trailingBuilder!)
                          .call(context),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void openEditDialog() {
    switch (_item.type) {
      case FormItemType.input:
        Util.showInputDialog(context, text: _item.value.toString(),
            onConfirm: (value) {
          _onConfirm(_item, value);
        });
        break;
      case FormItemType.switch_:
        final newVal = !_item.value;
        if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm) == "1") {
          Util.showConfirmDialog(context,
              title: "修改 [ ${_item.label} ]",
              content: "是否修改  [ ${_item.label} ]  为  <$newVal>", onConfirm: () {
            _onConfirm(_item, newVal);
          });
        } else {
          _onConfirm(_item, newVal);
        }
        break;
      default:
    }
  }

  Widget buildContent(BuildContext context) {
    if (_item.type == FormItemType.select) {
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
                items: _item.options == null
                    ? []
                    : _item.options!
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
                value: _item.value,
                onChanged: (String? value) {
                  if (IHive.settings.get(SettingsHiveKey.optionUpdateConfirm) ==
                      "1") {
                    Util.showConfirmDialog(context,
                        title: "修改 [ ${_item.label} ]",
                        content: "是否修改  [ ${_item.label} ]  为  <$value>",
                        onConfirm: () {
                      _onConfirm(_item, value);
                    });
                  } else {
                    _onConfirm(_item, value);
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
    final text = _item.type == FormItemType.switch_
        ? (_item.value ? "是" : "否")
        : _item.value.toString();
    return Expanded(
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (_item.readOnly) {
              return;
            }
            openEditDialog();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: _item.alignment,
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
    String? label = _item.label;
    String? tooltip = _item.tooltip;
    if (label == null) {
      label = Intl.message(
        '',
        name: _item.key.replaceAll("-", "_"),
        desc: '',
        args: [],
      );
      if (label.isNotEmpty && tooltip == null) {
        String val = Intl.message(
          '',
          name: "${_item.key.replaceAll("-", "_")}_tooltip",
          desc: '',
          args: [],
        );
        if (val.isNotEmpty) {
          tooltip = val;
          _tooltipKey = GlobalKey<TooltipState>();
        }
      } else if (tooltip != null) {
        _tooltipKey = GlobalKey<TooltipState>();
      }
    }
    return Row(
      children: [
        (tooltip != null
            ? Tooltip(
                key: _tooltipKey,
                triggerMode: TooltipTriggerMode.manual,
                message: tooltip,
                child: MyAnimatedIcon(
                  onTap: (controller) {
                    controller.forward();
                    _tooltipKey.currentState!.ensureTooltipVisible();
                  },
                  icon: Icons.info_outline_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: 20,
                  duration: Const.duration300ms,
                ),
              )
            : Offstage(
                offstage: _item.tooltip == null,
                child: const Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: Colors.transparent,
                ),
              )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(label)),
      ],
    );
  }

  void _updateItem() {
    if (_item.value != widget.item.value) {
      _item = widget.item;
    }
  }
}
