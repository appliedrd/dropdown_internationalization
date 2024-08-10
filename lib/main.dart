import 'package:flutter/material.dart';

// #docregion app-localizations-import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// #enddocregion app-localizations-import

// #docregion localization-delegates-import
import 'package:flutter_localizations/flutter_localizations.dart';
// #enddocregion localization-delegates-import


import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'dropdown_ex.dart';
import 'language_change_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp((
      ChangeNotifierProvider(
        // Initialize the model in the builder. That way, Provider
        // can own cart's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => LanguageChangeProvider(),
        child: MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteObserver<PageRoute> _routeObserver = RouteObserver();

  @override
  Widget build(BuildContext context) {
    // #docregion material-app
    return MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LanguageChangeProvider.SupportedLocales,

       locale: Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
     // locale: _locale,
      home: const MyHomePage(),
    );
    // #enddocregion material-app
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  dropdown_callback(String newLang) {
    debugPrint("newLang $newLang ");  // use await
   context.read<LanguageChangeProvider>().changeLocale(newLang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.hello('John')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                      Text(AppLocalizations.of(context)!.helloWorld),
                      Text(AppLocalizations.of(context)!.zipperhead),
                      // Returns 'Hello John'
                      Text(AppLocalizations.of(context)!.hello('John')),
                      // Returns 'no wombats'
                      Text(AppLocalizations.of(context)!.nWombats(0)),
                      // Returns '1 wombat'
                      Text(AppLocalizations.of(context)!.nWombats(1)),
                      // Returns '5 wombats'
                      Text(AppLocalizations.of(context)!.nWombats(5)),
                      CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        onDateChanged: (value) {},
                      ),
                       DropdownLanguageMenu(callback: dropdown_callback,),
          ],
        ),
      ),
    );
  }
}
