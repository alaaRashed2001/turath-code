import 'dart:ui';
import 'package:echocode/Data/dummy_media_data.dart';
import 'package:echocode/Helpers/url_launcher_helper.dart';
import 'package:echocode/Models/media_item.dart';
import 'package:echocode/Providers/lang_provider.dart';
import 'package:echocode/Widgets/ad_swiper.dart';
import 'package:echocode/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_HomeSection> sections = [
      _HomeSection(title: AppLocalizations.of(context)!.section1, image: Assets.imagesPalestine),
      _HomeSection(title: AppLocalizations.of(context)!.section2, image: Assets.imagesPalestineMap),
      _HomeSection(title: AppLocalizations.of(context)!.section3, image: Assets.imagesWoodenPalestinian),
      _HomeSection(title: AppLocalizations.of(context)!.section4, image: Assets.imagesPalestinePen),
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان الرئيسي
            Text(
              AppLocalizations.of(context)!.palestinianHeritageHub,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "jua",
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
              child: const AdSwiper(),
            ),

            SizedBox(height: 24.h),

            Text(
              AppLocalizations.of(context)!.welcomeHeritageCode,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "jua",
              ),
            ),

            // الشبكة
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      Assets.youtubeVideo2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      final section = sections[index];
                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 500 + index * 100),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.scale(
                              scale: value,
                              child: child,
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Widget page;
                            switch (index) {
                              case 0:
                                page = const PalestineInOurEyesScreen();
                                break;
                              case 1:
                                page = const VillageToCityScreen();
                                break;
                              case 2:
                                page = const OurHeritageScreen();
                                break;
                              case 3:
                                page = const PageFourScreen();
                                break;
                              default:
                                page = const Scaffold(
                                  body: Center(child: Text('صفحة غير معروفة')),
                                );
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => page),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(section.image),
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                    Colors.black45, BlendMode.darken),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              section.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeSection {
  final String title;
  final String image;
  const _HomeSection({required this.title, required this.image});
}



class PalestineInOurEyesScreen extends StatelessWidget {
  const PalestineInOurEyesScreen({super.key});

  IconData _getIconForType(MediaType type) {
    switch (type) {
      case MediaType.scratch:
        return Icons.videogame_asset; // رمز لعبة
      case MediaType.canva:
        return Icons.photo; // رمز صورة أو تصميم
      case MediaType.youtube:
        return Icons.play_circle_fill; // رمز فيديو
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaList = DummyMediaData.page1;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LangProvider>(context).lang;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.palestineInOurEyes),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: mediaList.length,
        separatorBuilder: (context, index) => const Divider(height: 20),
        itemBuilder: (context, index) {
          final item = mediaList[index];
          final title = (lang == 'ar') ? item.titleAr : item.titleEn;
          return InkWell(
            onTap: () => UrlLauncherHelper.launchExternalUrl(item.url),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isDark
                    ? []
                    : const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    _getIconForType(item.type),
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.1, duration: 400.ms); // أنيميشن لطيف
        },
      ),
      backgroundColor: isDark ? Colors.black : const Color(0xFFF7F7F7),
    );
  }
}

class VillageToCityScreen extends StatelessWidget {
  const VillageToCityScreen({super.key});

  IconData _getIconForType(MediaType type) {
    switch (type) {
      case MediaType.scratch:
        return Icons.videogame_asset_rounded;
      case MediaType.canva:
        return Icons.design_services;
      case MediaType.youtube:
        return Icons.ondemand_video;
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaList = DummyMediaData.page2;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LangProvider>(context).lang;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.villageToCity),
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                Assets.imagesLogo,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final item = mediaList[index];
                  final title = (lang == 'ar') ? item.titleAr : item.titleEn;
                  return GestureDetector(
                    onTap: () => UrlLauncherHelper.launchExternalUrl(item.url),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isDark
                            ? []
                            : const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    _getIconForType(item.type),
                                    color: Colors.orangeAccent,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .scale(delay: (index * 80).ms); // أنيميشن تدريجي لطيف
                },
                childCount: mediaList.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isDark ? Colors.black : const Color(0xFFF1F1F1),
    );
  }
}


class OurHeritageScreen extends StatelessWidget {
  const OurHeritageScreen({super.key});

  IconData _getIconForType(MediaType type) {
    switch (type) {
      case MediaType.scratch:
        return Icons.videogame_asset;
      case MediaType.canva:
        return Icons.photo_library;
      case MediaType.youtube:
        return Icons.ondemand_video;
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaList = DummyMediaData.page3;
    final featured = mediaList.take(2).toList();
    final rest = mediaList.skip(2).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LangProvider>(context).lang;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.ourHeritageTitle,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.ourHeritageGoal,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: featured.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = featured[index];
                final title = (lang == 'ar') ? item.titleAr : item.titleEn;
                return GestureDetector(
                  onTap: () => UrlLauncherHelper.launchExternalUrl(item.url),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[850] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark
                          ? []
                          : const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            item.image,
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(_getIconForType(item.type), color: Colors.redAccent),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: 0.1, duration: 300.ms),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: rest.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.53,
                ),
                itemBuilder: (context, index) {
                  final item = rest[index];
                  final title = (lang == 'ar') ? item.titleAr : item.titleEn;
                  return GestureDetector(
                    onTap: () => UrlLauncherHelper.launchExternalUrl(item.url),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: isDark
                            ? []
                            : const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                            child: Image.asset(
                              item.image,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    _getIconForType(item.type),
                                    size: 20,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .scale(delay: (index * 80).ms);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageFourScreen extends StatelessWidget {
  const PageFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Provider.of<LangProvider>(context).lang;
    final canvaItems =
    DummyMediaData.page4.where((e) => e.type == MediaType.canva).toList();
    final youtubeItems =
    DummyMediaData.page4.where((e) => e.type == MediaType.youtube).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pageFourTitle),
        backgroundColor: const Color(0xFF6B8BCA),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(
              AppLocalizations.of(context)!.poeticGames, Assets.imagesPalestine, isDark),
          ...canvaItems.map((item) => _buildCard(item, context, isDark)),

          const SizedBox(height: 24),
          _buildSectionTitle(
              AppLocalizations.of(context)!.poeticVideos, Assets.imagesPalestine, isDark),
          ...youtubeItems.map((item) => _buildCard(item, context, isDark)),
        ],
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
    );
  }

  Widget _buildSectionTitle(String title, String ornamentImage, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.brown.shade100 : Colors.brown.shade300,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            ornamentImage,
            width: 24,
            height: 24,
            color: Colors.brown.shade400,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6B8BCA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(MediaItem item, BuildContext context, bool isDark) {
    return InkWell(
      onTap: () async {
        try {
          await UrlLauncherHelper.launchExternalUrl(item.url);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.openLinkFailed(item.titleAr)
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? []
              : [
            BoxShadow(
              color: Colors.brown.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.asset(
                item.image,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                Localizations.localeOf(context).languageCode == 'ar' ? item.titleAr : item.titleEn,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.open_in_new, color: Colors.brown),
            const SizedBox(width: 12),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 400.ms)
          .slideX(begin: 0.1, duration: 300.ms),
    );
  }
}



