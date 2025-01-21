import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';

import 'app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth.dart';
import 'app/services/colors.dart';
import 'app/services/dependency_injection.dart';
import 'app/services/storage.dart';
import 'app_environment.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: "prod");
  }

  await initGetServices();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  return runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtil.kBackgroundColor,
      ),
      supportedLocales: const [
        Locale("en"),
      ],
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      translationsKeys: AppTranslation.translations,
      initialRoute: AppPages.INITIAL,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    ),
  ));
}

Future<void> initGetServices() async {
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  await Get.putAsync<AuthService>(() async => AuthService());
  Get.put(HomeController());
  await DependencyInjection.init();
  AppEnvironment.setupEnv(Environment.prod);
}
