// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Servers`
  String get appNavigation1 {
    return Intl.message(
      'Servers',
      name: 'appNavigation1',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get appNavigation2 {
    return Intl.message(
      'Downloads',
      name: 'appNavigation2',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get appNavigation3 {
    return Intl.message(
      'Settings',
      name: 'appNavigation3',
      desc: '',
      args: [],
    );
  }

  /// `Servers`
  String get serverPageTitle {
    return Intl.message(
      'Servers',
      name: 'serverPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingPageTitle {
    return Intl.message(
      'Settings',
      name: 'settingPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languageSettingLabel {
    return Intl.message(
      'Language',
      name: 'languageSettingLabel',
      desc: '',
      args: [],
    );
  }

  /// `中文`
  String get languageSettingOption1 {
    return Intl.message(
      '中文',
      name: 'languageSettingOption1',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languageSettingOption2 {
    return Intl.message(
      'English',
      name: 'languageSettingOption2',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get themeSettingLabel {
    return Intl.message(
      'Theme',
      name: 'themeSettingLabel',
      desc: '',
      args: [],
    );
  }

  /// `light`
  String get themeSettingOption1 {
    return Intl.message(
      'light',
      name: 'themeSettingOption1',
      desc: '',
      args: [],
    );
  }

  /// `dark`
  String get themeSettingOption2 {
    return Intl.message(
      'dark',
      name: 'themeSettingOption2',
      desc: '',
      args: [],
    );
  }

  /// `Updating Global Stat Interval`
  String get globalRefreshIntervalLabel {
    return Intl.message(
      'Updating Global Stat Interval',
      name: 'globalRefreshIntervalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Updating Task Information Interval`
  String get taskRefreshIntervalLabel {
    return Intl.message(
      'Updating Task Information Interval',
      name: 'taskRefreshIntervalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enable setting confirm`
  String get enableSettingChangeTipLabel {
    return Intl.message(
      'Enable setting confirm',
      name: 'enableSettingChangeTipLabel',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get second {
    return Intl.message(
      's',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get minute {
    return Intl.message(
      'min',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
