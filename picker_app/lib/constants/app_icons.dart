enum AppIcons {
  bgOrderHistoryEmpty,
  closeIcon,
  hamburger,
  circleClearText,
  close,
  dropDown,
  exit,
  lock,
  navBack,
  navRight,
  noteList,
  notification,
  orderCancelled,
  orderCompleted,
  orderMissed,
  printer,
  orderSection,
  pickerStatus,
  productSection,
  productivitySection,
  redArrow,
  warning,
  appLogo,
  inputSearch,
  inputClose,
  appbarBackIOS,
  appbarBackAndroid,
  eyeOn,
  eyeOff,
  orderHistory,
}

const _AppIconsAssets = {
  AppIcons.bgOrderHistoryEmpty: 'assets/icons/bg_order_history_empty.svg',
  AppIcons.closeIcon: 'assets/icons/close_icon.svg',
  AppIcons.hamburger: 'assets/icons/hamburger.svg',
  AppIcons.circleClearText: 'assets/icons/ic_circle_clear_text.svg',
  AppIcons.close: 'assets/icons/ic_close.svg',
  AppIcons.dropDown: 'assets/icons/ic_drop_down.svg',
  AppIcons.exit: 'assets/icons/ic_exit.svg',
  AppIcons.lock: 'assets/icons/ic_lock.svg',
  AppIcons.navBack: 'assets/icons/ic_nav_back.svg',
  AppIcons.navRight: 'assets/icons/ic_nav_right.svg',
  AppIcons.notification: 'assets/icons/ic_notification.svg',
  AppIcons.orderCancelled: 'assets/icons/ic_order_cancelled.svg',
  AppIcons.orderCompleted: 'assets/icons/ic_order_completed.svg',
  AppIcons.orderMissed: 'assets/icons/ic_order_missed.svg',
  AppIcons.printer: 'assets/icons/ic_printer.svg',
  AppIcons.orderSection: 'assets/icons/order_section.svg',
  AppIcons.pickerStatus: 'assets/icons/picker_status.svg',
  AppIcons.productSection: 'assets/icons/product_section.svg',
  AppIcons.productivitySection: 'assets/icons/productivity_section.svg',
  AppIcons.redArrow: 'assets/icons/red_arrow.svg',
  AppIcons.warning: 'assets/icons/warning.svg',
  AppIcons.appLogo: 'assets/icons/app_logo.svg',
  AppIcons.inputSearch: 'assets/icons/input_search.svg',
  AppIcons.inputClose: 'assets/icons/input_close.svg',
  AppIcons.appbarBackIOS: 'assets/icons/appbar_back_ios.svg',
  AppIcons.appbarBackAndroid: 'assets/icons/appbar_back_android.svg',
  AppIcons.eyeOn: 'assets/icons/eye_on.svg',
  AppIcons.eyeOff: 'assets/icons/eye_off.svg',
  AppIcons.orderHistory: 'assets/icons/order_history.svg',
};

const _DefaultIcon = 'assets/icons/warning.svg';

extension AppIconsExtension on AppIcons {
  String toAssetName() {
    final assets = _AppIconsAssets[this];
    if (assets != null) {
      return assets;
    }
    return _DefaultIcon;
  }
}
