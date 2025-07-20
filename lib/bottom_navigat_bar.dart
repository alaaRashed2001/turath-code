import 'dart:ui';
import 'package:echocode/Consts/app_color.dart';
import 'package:echocode/Providers/lang_provider.dart';
import 'package:echocode/Providers/theme_provider.dart';
import 'package:echocode/Screens/game_screen.dart';
import 'package:echocode/Screens/home_screen.dart';
import 'package:echocode/Screens/settings_screen.dart';
import 'package:echocode/Screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BottomNavigateBar extends StatefulWidget {
  const BottomNavigateBar({super.key});

  @override
  State<BottomNavigateBar> createState() => _BottomNavigateBarState();
}

class _BottomNavigateBarState extends State<BottomNavigateBar> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LangProvider>(
      builder: (context, theme, lang, child) {
        final isDark = theme.isDarkTheme;

        return Scaffold(

          extendBody: true,
          bottomNavigationBar: Stack(
            children: [
              if (isDark)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      height: 76,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),


              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDark ? Colors.transparent : Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: currentPage,
                    onTap: (index) {
                      setState(() {
                        currentPage = index;
                      });
                      _pageController.jumpToPage(index);
                    },
                    selectedItemColor: AppColor.primaryColor,
                    unselectedItemColor: AppColor.secondaryColor,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.museum,
                          color: currentPage == 0
                              ? AppColor.primaryColor
                              : AppColor.secondaryColor,
                        ),
                        label: AppLocalizations.of(context)!.turath,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.sports_esports,
                          color: currentPage == 1
                              ? AppColor.primaryColor
                              : AppColor.secondaryColor,
                        ),
                        label: AppLocalizations.of(context)!.games,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.rate_review,
                          color: currentPage == 2
                              ? AppColor.primaryColor
                              : AppColor.secondaryColor,
                        ),
                        label: AppLocalizations.of(context)!.rateUs,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.account_circle,
                          color: currentPage == 2
                              ? AppColor.primaryColor
                              : AppColor.secondaryColor,
                        ),
                        label: AppLocalizations.of(context)!.profile,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),


          body: PageView(
            physics: const NeverScrollableScrollPhysics(),

            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            controller: _pageController,
            children: const [
              HomeScreen(),
              GameScreen(),
              SurveyScreen(),
              SettingsScreen(),
            ],
          ),
        );
      },
    );
  }
}
