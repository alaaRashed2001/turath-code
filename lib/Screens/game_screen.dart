import 'dart:ui';

import 'package:echocode/Consts/app_color.dart';
import 'package:echocode/Data/dummy_media_data.dart';
import 'package:echocode/Helpers/url_launcher_helper.dart';
import 'package:echocode/Models/media_item.dart';
import 'package:echocode/Providers/lang_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LangProvider>(context).lang;
    final List<MediaItem> items = DummyMediaData.scratchItems;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [

                AppColor.secondaryColor,
                AppColor.primaryColor,
              ],
            ),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title:  Text(
              AppLocalizations.of(context)!.playHeritage,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final title = (lang == 'ar') ? item.titleAr : item.titleEn;
                final height = 160 + (index % 2) * 40.0;

                return GestureDetector(
                    onTap: () => UrlLauncherHelper.launchExternalUrl(item.url ?? ""),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.asset(
                                  item.image ?? "",
                                  fit: BoxFit.cover,
                                  height: height,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 1)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                )
                    .animate(delay: (100 * index).ms) // 👈 تأخير بسيط لكل عنصر
                    .fade(duration: 600.ms)
                    .slideY(begin: 0.3, duration: 600.ms)
                    .scale(duration: 600.ms, curve: Curves.easeOutBack);

              },
            ),
          ),
        ),
      ],
    );
  }
}


