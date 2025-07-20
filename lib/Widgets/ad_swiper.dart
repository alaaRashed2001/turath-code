import 'package:carousel_slider/carousel_slider.dart';
import 'package:echocode/Data/dummy_ads.dart';
import 'package:echocode/Models/ad_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class AdSwiper extends StatelessWidget {
  const AdSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: dummyAds.length,
      itemBuilder: (context, index, realIdx) {
        final ad = dummyAds[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            ad.path,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true, // ✅ التمرير التلقائي
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
    );
  }
}

// class AdSwiper extends StatefulWidget {
//   const AdSwiper({super.key});
//
//   @override
//   State<AdSwiper> createState() => _AdSwiperState();
// }
//
// class _AdSwiperState extends State<AdSwiper> {
//   final List<VideoPlayerController?> _controllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (var ad in dummyAds) {
//       if (ad.type == AdType.video) {
//         final controller = VideoPlayerController.asset(ad.path)
//           ..initialize().then((_) {
//             setState(() {});
//           });
//         controller.setLooping(true);
//         controller.play();
//         _controllers.add(controller);
//       } else {
//         _controllers.add(null);
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller?.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider.builder(
//       itemCount: dummyAds.length,
//       itemBuilder: (context, index, realIdx) {
//         final ad = dummyAds[index];
//         if (ad.type == AdType.image) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.asset(ad.path, fit: BoxFit.cover, width: double.infinity),
//           );
//         } else {
//           final controller = _controllers[index];
//           if (controller != null && controller.value.isInitialized) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: controller.value.aspectRatio,
//                     child: VideoPlayer(controller),
//                   ),
//                   Positioned(
//                     bottom: 12,
//                     right: 12,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             controller.value.isPlaying
//                                 ? Icons.pause_circle_filled
//                                 : Icons.play_circle_filled,
//                             size: 32,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               controller.value.isPlaying
//                                   ? controller.pause()
//                                   : controller.play();
//                             });
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             controller.value.volume > 0
//                                 ? Icons.volume_up
//                                 : Icons.volume_off,
//                             size: 28,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (controller.value.volume > 0) {
//                                 controller.setVolume(0);
//                               } else {
//                                 controller.setVolume(1);
//                               }
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         }
//       },
//       options: CarouselOptions(
//         height: 200,
//         autoPlay: false,
//         enlargeCenterPage: true,
//         viewportFraction: 0.85,
//       ),
//     );
//   }
// }
