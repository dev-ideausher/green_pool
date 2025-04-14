import 'package:firebase_core/firebase_core.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app_environment.dart';

import 'app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/app_language.dart';
import 'app/services/auth.dart';
import 'app/services/colors.dart';
import 'app/services/dependency_injection.dart';
import 'app/services/push_notification_service.dart';
import 'app/services/storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options_dev.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptionsDev.currentPlatform, name: "dev");
  await initGetServices();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  PushNotificationService().setupInteractedMessage();

  return runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtil.kBackgroundColor,
      ),
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.full,
      supportedLocales: const [
        Locale("en", "US"),
        Locale("fr", "FR"),
        Locale("es", "ES")
      ],
      locale: Locale(Get.find<GetStorageService>().langCode,
          Get.find<GetStorageService>().langCodeV),
      fallbackLocale: AppLanguage.getLocale(),
      translationsKeys: AppTranslation.translations,
      initialRoute: AppPages.INITIAL,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
    ),
  ));
}

Future<void> initGetServices() async {
  AppEnvironment.setupEnv(Environment.dev);
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  await Get.putAsync<AuthService>(() async => AuthService());
  Get.put(HomeController());
  await DependencyInjection.init();
}
