import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'language_change_provider.dart';

// Flutter code sample for [DropdownMenu]s. The first dropdown menu
// has the default outlined border and demos using the
// [DropdownMenuEntry] style parameter to customize its appearance.
// The second dropdown menu customizes the appearance of the dropdown
// menu's text field with its [InputDecorationTheme] parameter.

// DropdownMenuEntry labels and values for the first dropdown menu.
enum LanguageLabel {
  en('english', Colors.blue, 'en'),
  fr('francais', Colors.pink, 'fr'),
  es('espaniol', Colors.green, 'es'),
  ;

  const LanguageLabel(this.label, this.color, this.localeName);

  final String label;
  final Color color;
  final String localeName;

  @override
  String toString() => 'MyEnum(localeName: $localeName, name: $name)';
}

LanguageLabel? findInEnum(String targetLocaleName) {
  var ll =  LanguageLabel.values.where((e) => e.localeName == targetLocaleName);
  if (ll.isNotEmpty) {
    return ll.first;
  }
}

class DropdownLanguageMenu extends StatefulWidget {
  DropdownLanguageMenu({
    super.key,
    required this.callback,
    required this.initialLocaleName,
  });

  @override
  State<DropdownLanguageMenu> createState() => _DropdownLanguageMenuState();

  Function callback;
  String initialLocaleName;
}

class _DropdownLanguageMenuState extends State<DropdownLanguageMenu> {
  final TextEditingController langController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  LanguageLabel? selectedLanguage;
  String _localeName = 'en';


 void  setDropDownLocale(LanguageLabel label) {
    setState(() {
      _localeName = label.localeName;
    });
    widget.callback(_localeName);
  }

  @override
  Widget build(BuildContext context) {
    LanguageLabel initialSelection = findInEnum(widget.initialLocaleName)?? LanguageLabel.fr;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownMenu<LanguageLabel>(
                initialSelection: initialSelection,
                controller: langController,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Language'),
                onSelected: (LanguageLabel? lang) {
                  setState(() {
                    selectedLanguage = lang;
                  });
                  widget.callback(selectedLanguage!.localeName);
                },
                dropdownMenuEntries: LanguageLabel.values
                    .map<DropdownMenuEntry<LanguageLabel>>(
                        (LanguageLabel color) {
                  return DropdownMenuEntry<LanguageLabel>(
                    value: color,
                    label: color.label,
                    enabled: color.label != 'Grey',
                    style: MenuItemButton.styleFrom(
                      foregroundColor: color.color,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        if (selectedLanguage != null)
          Text('You selected a ${selectedLanguage?.label}')
       else const Text('Please select a language .')
      ],
    );
  }
}
