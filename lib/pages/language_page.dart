import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/blocs/app_language_bloc.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';
import '../widgets/custom_app_bar_view.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  LanguagePageState createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'en';

  final Map<String, String> languageMap = {
    'en': 'English',
    'my': 'Myanmar',
    'zh': 'Chinese',
  };

  final Map<String, String> languageFlagMap = {
    'en': kEnglishImg,
    'my': kMyanmarImg,
    'zh': kChinaImg,
  };

  /// Method to handle language selection and update UI
  void _setLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');

    /// Set default language based on the saved language code or set it to English by default.
    if (languageCode == null) {
      setState(() {
        _selectedLanguage = "en";
      });
    } else if (languageCode == "my") {
      setState(() {
        _selectedLanguage = "my";
      });
    } else if (languageCode == "zh") {
      setState(() {
        _selectedLanguage = "zh";
      });
    } else {
      setState(() {
        _selectedLanguage = "en";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBarView(
        title: AppLocalizations.of(context)!.language,
      ),
      body: Padding(
        padding: const EdgeInsets.all(kMarginMedium2),
        child: Column(
          children: [
            // English Language Container
            GestureDetector(
              onTap: () => _setLanguage('en'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'en' ? kPrimaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedLanguage == 'en' ? kPrimaryColor : Colors.black,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      kEnglishImg,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      languageMap['en']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _selectedLanguage == 'en' ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Myanmar Language Container
            GestureDetector(
              onTap: () => _setLanguage('my'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'my' ? kPrimaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedLanguage == 'my' ? kPrimaryColor : Colors.black,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      kMyanmarImg,
                      height: 30,
                      width: 30,
                    ),
                    
                    const SizedBox(width: 10),
                    Text(
                      languageMap['my']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _selectedLanguage == 'my' ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Chinese Language Container
            GestureDetector(
              onTap: () => _setLanguage('zh'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'zh' ? kPrimaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _selectedLanguage == 'zh' ? kPrimaryColor : Colors.black,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      kChinaImg,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      languageMap['zh']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _selectedLanguage == 'zh' ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kMarginLarge),
              child: CommonButtonView(
                label: AppLocalizations.of(context)!.confirm,
                labelColor: Colors.white,
                bgColor: kPrimaryColor,
                onTapButton: () {
                  var bloc = context.read<AppLanguageBloc>();
                  bloc.changeLanguage(_selectedLanguage);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
