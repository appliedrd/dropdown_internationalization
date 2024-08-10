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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("es");
  final RouteObserver<PageRoute> _routeObserver = RouteObserver();

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }


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
            // Add the following code
            // Localizations.override(
            //   context: context,
            //   locale: const Locale('fr'),
            //   // Using a Builder to get the correct BuildContext.
            //   // Alternatively, you can create a new widget and Localizations.override
            //   // will pass the updated BuildContext to the new widget.
            //   child: Builder(
            //     builder: (context) {
            //       // A toy example for an internationalized Material widget.
            //       return Column(
            //         children: <Widget>[
            //           Text(AppLocalizations.of(context)!.helloWorld),
            //           Text(AppLocalizations.of(context)!.zipperhead),
            //           // Returns 'Hello John'
            //           Text(AppLocalizations.of(context)!.hello('John')),
            //           // Returns 'no wombats'
            //           Text(AppLocalizations.of(context)!.nWombats(0)),
            //           // Returns '1 wombat'
            //           Text(AppLocalizations.of(context)!.nWombats(1)),
            //           // Returns '5 wombats'
            //           Text(AppLocalizations.of(context)!.nWombats(5)),
            //           CalendarDatePicker(
            //           initialDate: DateTime.now(),
            //       firstDate: DateTime(1900),
            //       lastDate: DateTime(2100),
            //       onDateChanged: (value) {},
            //       ),
            //       ],
            //       );
            //     },
            //   ),
            // ),
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
                      // ElevatedButton(onPressed: (){
                      //   context.read<LanguageChangeProvider>().changeLocale("en");
                      // }, child: Text("english")),
                      // ElevatedButton(onPressed: (){
                      //   context.read<LanguageChangeProvider>().changeLocale("es");
                      // }, child: Text("spanish")),
                      // ElevatedButton(onPressed: (){
                      //   context.read<LanguageChangeProvider>().changeLocale("fr");
                      // }, child: Text("french")),
            DropdownLanguageMenu(callback: dropdown_callback,),
          ],
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // #docregion internationalized-title
  //     appBar: AppBar(
  //       // The [AppBar] title text should update its message
  //       // according to the system locale of the target platform.
  //       // Switching between English and Spanish locales should
  //       // cause this text to update.
  //       title: Text(AppLocalizations.of(context)!.helloWorld),
  //     ),
  //     // #enddocregion internationalized-title
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           // Add the following code
  //           Localizations.override(
  //             context: context,
  //             locale:  Locale('es'),
  //             // Using a Builder here to get the correct BuildContext.
  //             // Alternatively, you can create a new widget and Localizations.override
  //             // will pass the updated BuildContext to the new widget.
  //             child: Builder(
  //               builder: (context) {
  //                 // #docregion placeholder
  //                 // Examples of internationalized strings.
  //                 return Column(
  //                   children: <Widget>[
  //                     // Returns 'Hello John'
  //                     Text(AppLocalizations.of(context)!.hello('John')),
  //                     // Returns 'no wombats'
  //                     Text(AppLocalizations.of(context)!.nWombats(0)),
  //                     // Returns '1 wombat'
  //                     Text(AppLocalizations.of(context)!.nWombats(1)),
  //                     // Returns '5 wombats'
  //                     Text(AppLocalizations.of(context)!.nWombats(5)),
  //                     // Returns 'he'
  //                     Text(AppLocalizations.of(context)!.pronoun('male')),
  //                     // Returns 'she'
  //                     Text(AppLocalizations.of(context)!.pronoun('female')),
  //                     // Returns 'they'
  //                     Text(AppLocalizations.of(context)!.pronoun('other')),
  //                   ],
  //                 );
  //                 // #enddocregion placeholder
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

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
