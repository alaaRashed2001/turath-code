import 'dart:ui';

import 'package:echocode/bottom_navigat_bar.dart';
import 'package:echocode/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    // Start animations with a delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _logoController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      _textController.forward();
    });


    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavigateBar()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // الخلفية - صورة كاملة الشاشة
          Image.asset(
            Assets.imagesLogo, // غيرها لصورتك
            fit: BoxFit.cover,
          ),

          // تأثير البلور فوق الصورة
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // قوة البلور
            child: Container(
              color: Colors.black.withOpacity(0.3), // تظليل خفيف (اختياري)
            ),
          ),

          // المحتوى فوق البلور
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Lottie.asset(
                    Assets.animationsHeritageLoader,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 32.h),

                FadeTransition(
                  opacity: _textController.drive(
                    CurveTween(curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
                        .animate(
                      CurvedAnimation(
                        parent: _textController,
                        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.welcomeHeritageCode,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "jua",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeTransition(
                  opacity: _textController.drive(
                    CurveTween(curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
                        .animate(
                      CurvedAnimation(
                        parent: _textController,
                        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.heritageMeetsTechnology,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "jua",
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}

