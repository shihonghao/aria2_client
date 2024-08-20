import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/ui/component/animation/my_colorize_text.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:aria2_client/ui/pages/settings/settings_item.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        color: Theme.of(context).highlightColor,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 110,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        S.of(context).settingPageTitle,
                        style: const TextStyle(
                            fontSize: 70, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color: Theme.of(context).cardColor,
                  child: ListView(
                    children: [
                      SettingsItem(
                        formItem: FormItem<String>(
                          key: SettingsHiveKey.language,
                          value: IHive.settings.get(SettingsHiveKey.language,
                              defaultValue: "zh"),
                          label: S.of(context).languageSettingLabel,
                          type: FormItemType.select,
                          onChange: (value) {
                            if (value.contains("_")) {
                              S.load(Locale(
                                      value.split("_")[0], value.split("_")[1]))
                                  .then((_) {
                                setState(() {});
                              });
                            } else {
                              S.load(Locale(value)).then((_) {
                                setState(() {});
                              });
                            }
                          },
                          options: [
                            FormItemOption(label: '中文', value: 'zh'),
                            FormItemOption(label: 'English', value: 'en')
                          ],
                        ),
                      ),
                      Const.divider10,
                      SettingsItem(
                        formItem: FormItem<String>(
                          key: SettingsHiveKey.themeMode,
                          value: IHive.settings.get(SettingsHiveKey.themeMode,
                              defaultValue: "dark"),
                          label: S.of(context).themeSettingLabel,
                          type: FormItemType.select,
                          options: [
                            FormItemOption(
                                label: S.of(context).themeSettingOption1,
                                value: 'light'),
                            FormItemOption(
                                label: S.of(context).themeSettingOption2,
                                value: 'dark')
                          ],
                        ),
                      ),
                      Const.divider10,
                      SettingsItem(
                        formItem: FormItem<int>(
                            key: SettingsHiveKey.globalRefreshInterval,
                            value: IHive.settings.get(
                                SettingsHiveKey.globalRefreshInterval,
                                defaultValue: 1),
                            label: S.of(context).globalRefreshIntervalLabel,
                            type: FormItemType.input,
                            trailingBuilder: (context) => buildUnitTrailing(
                                context, S.of(context).second)),
                      ),
                      Const.divider10,
                      SettingsItem(
                        formItem: FormItem<int>(
                            key: SettingsHiveKey.taskRefreshInterval,
                            value: IHive.settings.get(
                                SettingsHiveKey.taskRefreshInterval,
                                defaultValue: 1),
                            label: S.of(context).taskRefreshIntervalLabel,
                            type: FormItemType.input,
                            trailingBuilder: (context) => buildUnitTrailing(
                                context, S.of(context).second)),
                      ),
                      Const.divider10,
                      SettingsItem(
                        formItem: FormItem<String>(
                          key: SettingsHiveKey.optionUpdateConfirm,
                          value: IHive.settings.get(
                              SettingsHiveKey.optionUpdateConfirm,
                              defaultValue: '1'),
                          label: S.of(context).enableSettingChangeTipLabel,
                          type: FormItemType.select,
                          options: [
                            FormItemOption(
                                label: S.of(context).yes, value: '1'),
                            FormItemOption(label: S.of(context).no, value: '0')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox.expand(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color: Theme.of(context).cardColor,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        pause: const Duration(milliseconds: 1),
                        repeatForever: true,
                        animatedTexts: [
                          MyColorizeAnimatedText("Aria2-Flutter-UI",
                              speed: Const.duration100ms,
                              textStyle: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                              colors: [
                                Colors.white38,
                                Colors.red,
                                Colors.yellow,
                                Colors.blue,
                              ])
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Version: 0.0.1",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const Text("Author: hhsmtx",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  )),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
