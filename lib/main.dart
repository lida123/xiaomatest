import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaomatest/util/ColorsUtil.dart';
import 'package:xiaomatest/widgets/DismissKeyboard.dart';
import 'login/login_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        ScreenUtil.init(context, designSize: Size(375.0, 812));
        return FlutterEasyLoading(
          child: MediaQuery(
            //设置文字大小不随系统设置改变
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          ),
        );
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US'),
      ],
      theme: ThemeData(
          // primarySwatch: primaryColor,
          platform: TargetPlatform.iOS,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {TargetPlatform.iOS: CupertinoPageTransitionsBuilder()},
          ),
          textSelectionTheme: TextSelectionThemeData(
              selectionColor: primaryColor,
              selectionHandleColor: primaryColor,
              cursorColor: primaryColor),
          cupertinoOverrideTheme:
          NoDefaultCupertinoThemeData(primaryColor: primaryColor)),
      title: 'xiaoma测试',
      home: loginPage(),
    ));

  }

}