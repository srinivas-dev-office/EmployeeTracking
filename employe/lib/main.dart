// ignore_for_file: library_private_types_in_public_api
import 'package:employe/untils/exports.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await UserSimplePreferences.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Employee tracking',
            theme: ThemeData(
              textTheme:
                  GoogleFonts.manropeTextTheme().apply(bodyColor: kFontColor),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: kScaffoldBackground,
              useMaterial3: true,
            ),
            getPages: Routes.routes,
            initialRoute: KSplash,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            });
      },
    );
  }
}
