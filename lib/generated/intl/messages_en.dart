// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appNavigation1": MessageLookupByLibrary.simpleMessage("Servers"),
        "appNavigation2": MessageLookupByLibrary.simpleMessage("Downloads"),
        "appNavigation3": MessageLookupByLibrary.simpleMessage("Settings"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "confirm": MessageLookupByLibrary.simpleMessage("confirm"),
        "enableSettingChangeTipLabel":
            MessageLookupByLibrary.simpleMessage("Enable setting confirm"),
        "globalRefreshIntervalLabel": MessageLookupByLibrary.simpleMessage(
            "Updating Global Stat Interval"),
        "languageSettingLabel":
            MessageLookupByLibrary.simpleMessage("Language"),
        "languageSettingOption1": MessageLookupByLibrary.simpleMessage("中文"),
        "languageSettingOption2":
            MessageLookupByLibrary.simpleMessage("English"),
        "minute": MessageLookupByLibrary.simpleMessage("min"),
        "no": MessageLookupByLibrary.simpleMessage("no"),
        "second": MessageLookupByLibrary.simpleMessage("s"),
        "serverPageTitle": MessageLookupByLibrary.simpleMessage("Servers"),
        "settingPageTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "taskRefreshIntervalLabel": MessageLookupByLibrary.simpleMessage(
            "Updating Task Information Interval"),
        "themeSettingLabel": MessageLookupByLibrary.simpleMessage("Theme"),
        "themeSettingOption1": MessageLookupByLibrary.simpleMessage("light"),
        "themeSettingOption2": MessageLookupByLibrary.simpleMessage("dark"),
        "yes": MessageLookupByLibrary.simpleMessage("yes")
      };
}
