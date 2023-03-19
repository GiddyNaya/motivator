import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:motivator/utils/constants_util.dart' as app_constants;

part 'local_storage.g.dart';

class LocalStorage = LocalStorageBase with _$LocalStorage;

abstract class LocalStorageBase with Store {
  @observable
  bool isFirstLaunch = true;

  @observable
  bool isDarkModeOn = true;

  @action
  Future<void> setFirstLaunch(bool _isFirstLaunch) async {
    isFirstLaunch = _isFirstLaunch;
    await setValue(app_constants.PrefFirstLaunch, _isFirstLaunch, print: false);
  }

  @action
  Future<void> setDarkMode(bool _isDarkModeOn) async {
    isDarkModeOn = _isDarkModeOn;
    await setValue(app_constants.PrefDarkMode, _isDarkModeOn, print: false);
  }

  Future<void> clearAll() async {
    await setFirstLaunch(true);
  }

  Future<void> init() async {
    try {
      await setFirstLaunch(getBoolAsync(app_constants.PrefFirstLaunch));
      await setDarkMode(
          getBoolAsync(app_constants.PrefDarkMode, defaultValue: true));
    } catch (e) {
      print(e);
      await clearAll();
    }
  }
}
