import 'dart:ui';
import 'package:echocode/Data/dummy_media_data.dart';
import 'package:echocode/Helpers/url_launcher_helper.dart';
import 'package:echocode/Models/media_item.dart';
import 'package:echocode/Widgets/ad_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<MediaItem> videoItems = DummyMediaData.videoItems;
    final List<MediaItem> canvaItems = DummyMediaData.canvaItems;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              AppLocalizations.of(context)!.palestinianHeritageHub,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "jua",
              ),
            ),
            Text(
              AppLocalizations.of(context)!.welcomeHeritageCode,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "jua",
              ),
            ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
                child: const AdSwiper(),
               ),

            /// Tales From Homeland
            SizedBox(height:12.h,),
            Text(
              AppLocalizations.of(context)!.talesFromHomeland,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,

              ),
            ),
            SizedBox(height: 8.h,),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: videoItems.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = videoItems[index];
                  return GestureDetector(
                    onTap: () => UrlLauncherHelper.launchExternalUrl(item.url ?? ""),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.image ?? "",
                            width: 200,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   item.title?? "",
                        //   style: const TextStyle(fontSize: 12),
                        // )
                      ],
                    ),
                  );
                },
              ),
            ),

            /// Canva Projects
            Text(
              AppLocalizations.of(context)!.slidesHeritage,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,

              ),
            ),
            SizedBox(height: 8.h,),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: canvaItems.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = canvaItems[index];
                  return GestureDetector(
                    onTap: () => UrlLauncherHelper.launchExternalUrl(item.url ?? ""),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.image ?? "",
                            width: 200,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   item.title?? "",
                        //   style: const TextStyle(fontSize: 12),
                        // )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}


