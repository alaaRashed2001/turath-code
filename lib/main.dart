import 'package:echocode/Helpers/styles.dart';
import 'package:echocode/Providers/theme_provider.dart';
import 'package:echocode/Shared_Preferences/shared_prefrences.dart';
import 'package:echocode/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Providers/lang_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesController().initSharedPreferences();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LangProvider>(create: (_) => LangProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return MaterialApp(
                title: 'Turath code',
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(isDarkTheme: false, context: context),
                darkTheme: Styles.themeData(isDarkTheme: true, context: context),
                themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                ],
                locale: Locale(Provider.of<LangProvider>(context).lang),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}

// git init
// git add .
// git commit -m "Palestine: A Nation’s Tale"
// git branch -M main
// git remote add origin https://github.com/alaaRashed2001/turath-code.git
// git push -u origin main