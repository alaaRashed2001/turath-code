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

  Stack buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          width: double.infinity,
          height: coverHeight,
          color: AppColor.primaryColor,
        ),
        Positioned(
          top: top,
          child: Container(
            width: 128.w,
            height: 120.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage(Assets.imagesIbrahim),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContent(ThemeProvider themeProvider, LangProvider langProvider) {
    final isDark = themeProvider.isDarkTheme;
    final isArabic = langProvider.lang == 'ar';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            child: Padding(
              padding:  EdgeInsetsDirectional.only(start: 24.w, top: 14.h, bottom: 14.h),
              child: Text(
                AppLocalizations.of(context)!.ibrahimHussain,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Padding(
              padding:  EdgeInsetsDirectional.only(start: 24.w, top: 14.h, bottom: 14.h),
              child: Text(
                AppLocalizations.of(context)!.grade,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Padding(
              padding:  EdgeInsetsDirectional.only(start: 24.w, top: 14.h, bottom: 14.h),
              child: Text(
                AppLocalizations.of(context)!.location_yasuf,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Padding(
              padding:  EdgeInsetsDirectional.only(start: 24.w, top: 14.h, bottom: 14.h),
              child: Text(
                AppLocalizations.of(context)!.project_name,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
