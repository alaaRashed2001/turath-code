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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
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


            // ScaleTransition(
            //   scale: Tween<double>(begin: 0.6, end: 1.0).animate(
            //     CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
            //   ),
            //   child: Image.asset(
            //     Assets.imagesLogo,
            //     width: 180.w,
            //     height: 180.h,
            //   ),
            // ),
            //
            SizedBox(height: 32.h),


            FadeTransition(
              opacity: _textController,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
                    .animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut)),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeHeritageCode,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "jua",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      AppLocalizations.of(context)!.heritageMeetsTechnology,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "jua",
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      AppLocalizations.of(context)!.ibrahimHussain,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "jua",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

