import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'app/splash/splash_screen.dart';
import 'components/unfocus.dart';
import 'config/routes/nav_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubrics Teacher Support',
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      navigatorKey: NavRouter.navigationKey,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        child = BotToastInit()(context, child);
        child = UnFocus(child: child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: SplashScreen(),
    );
  }
}
