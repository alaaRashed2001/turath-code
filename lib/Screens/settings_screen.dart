import 'package:echocode/Consts/app_color.dart';
import 'package:echocode/Providers/lang_provider.dart';
import 'package:echocode/Providers/theme_provider.dart';
import 'package:echocode/Widgets/glass_card.dart';
import 'package:echocode/Widgets/setting_switch_tile.dart';
import 'package:echocode/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final double coverHeight = 188;
  final double profileHeight = 124;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LangProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          SizedBox(height: 8.h,),
          buildContent(themeProvider, langProvider),
        ],
      ),
    );
  }

  Widget buildTop() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, AppColor.primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Text(
            AppLocalizations.of(context)!.project_name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(color: Colors.black45, blurRadius: 4),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            AppLocalizations.of(context)!.palestineNationTale,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }


  Widget buildContent(ThemeProvider themeProvider, LangProvider langProvider) {
    final isDark = themeProvider.isDarkTheme;
    final isArabic = langProvider.lang == 'ar';

    final names = langProvider.lang == 'ar'
        ? [
      'إبراهيم حسين',
      'محمد ماهر',
    ]
        : [
      'Ibrahim Hussein',
      'Mohammad Maher',
    ];


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.team_members,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...names.map((name) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $name',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: ListTile(
              title: Text(
                AppLocalizations.of(context)!.location_yasuf,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.location_on, color: Colors.brown),
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: ListTile(
              title: Text(
                AppLocalizations.of(context)!.project_name,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.flag, color: Colors.redAccent),
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingSwitchTile(
                  title: AppLocalizations.of(context)!.toggle_theme,
                  value: isDark,
                  onChanged: (_) => themeProvider.toggleTheme(),
                ),
                SettingSwitchTile(
                  title: AppLocalizations.of(context)!.toggle_language,
                  value: isArabic,
                  onChanged: (_) => langProvider.changeLanguage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
