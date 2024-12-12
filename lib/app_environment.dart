import 'dart:io';

enum Environment { dev, prod }

abstract class AppEnvironment {
  static late String baseApiUrl;
  static late String title;
  static late Environment _environment;
  static late String appId;
  static late String placeApiKey;
  static late String publishableKey;
  static late String cardEncryptionKey;

  Environment get environment => _environment;

  static setupEnv(Environment env) async {
    _environment = env;
    switch (env) {
      case Environment.dev:
        {
          baseApiUrl = "https://green-pool-backend.vercel.app/v1/";
          title = 'Flutter flavors dev';
          publishableKey = "";
          cardEncryptionKey = "";
          placeApiKey = Platform.isAndroid
              ? 'AIzaSyAs_QL4LPuvaU23w-t0wOUJyUziRmSIlkE'
              : 'AIzaSyBq5jpn2f8NAb4pb562ejP2YCg47uX1_nU';
          break;
        }
      case Environment.prod:
        {
          baseApiUrl = "https://api.carpooll.com/v1/";
          title = 'Flutter flavors prod';
          publishableKey = "";
          cardEncryptionKey = "";
          placeApiKey = Platform.isAndroid
              ? 'AIzaSyAs_QL4LPuvaU23w-t0wOUJyUziRmSIlkE'
              : 'AIzaSyBq5jpn2f8NAb4pb562ejP2YCg47uX1_nU';

          break;
        }
    }
  }
}
