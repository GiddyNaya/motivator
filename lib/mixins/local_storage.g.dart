// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalStorage on LocalStorageBase, Store {
  final _$isFirstLaunchAtom = Atom(name: 'LocalStorageBase.isFirstLaunch');

  @override
  bool get isFirstLaunch {
    _$isFirstLaunchAtom.reportRead();
    return super.isFirstLaunch;
  }

  @override
  set isFirstLaunch(bool value) {
    _$isFirstLaunchAtom.reportWrite(value, super.isFirstLaunch, () {
      super.isFirstLaunch = value;
    });
  }

  final _$isDarkModeOnAtom = Atom(name: 'LocalStorageBase.isDarkModeOn');

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  @override
  String toString() {
    return '''
isFirstLaunch: ${isFirstLaunch},
isDarkModeOn: ${isDarkModeOn}
    ''';
  }
}
