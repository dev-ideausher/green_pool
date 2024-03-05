
// import 'package:get/get.dart';

// import 'storage.dart';

// class ThemeService extends GetxService {
// // Get.find<ThemeService>().setTheme(ThemeMode.light);
// // Get.find<ThemeService>().setTheme(ThemeMode.dark);
// // Get.find<ThemeService>().setTheme(ThemeMode.system);

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     setTheme(theme);
//     print(Get.find<GetStorageService>().themeMode);
//     print(theme);
//   }

//   ThemeMode get theme => Get.find<GetStorageService>().themeMode == 1 ? ThemeMode.dark : Get.find<GetStorageService>().themeMode == 0 ? ThemeMode.light : ThemeMode.system;

//   // SchedulerBinding.instance!.window
//   //             .platformBrightness == // if system mode is set
//   //         Brightness.dark
//   //     ? ThemeMode.dark
//   //     : ThemeMode.light;

//   /// Switch theme and save to local storage
//   void setTheme(ThemeMode thememode) {
//     Get.changeThemeMode(thememode);
//     Get.find<GetStorageService>().themeMode = thememode == ThemeMode.light
//         ? 0
//         : thememode == ThemeMode.dark
//         ? 1
//         : 2;
//   }
// }