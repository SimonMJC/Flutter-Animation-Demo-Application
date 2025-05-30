import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'page/implicit_animation_page.dart';
import 'page/staggered_animation_page.dart';
import 'page/flutter_animated_page.dart';
import 'page/rive_page.dart';
import 'page/lottie_page.dart';
import 'page/gesture_page.dart';
import 'page/explicit_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:ui';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Animation Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImplicitAnimationPage(),
                  ),
                );
              },
              child: const Text('Implicit Animation 예제 보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const StaggeredAnimationPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // 페이드 인/아웃 애니메이션
                      final fadeAnimation = TweenSequence<double>([
                        TweenSequenceItem(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          weight: 1,
                        ),
                      ]).animate(animation);

                      // 슬라이드 애니메이션
                      final slideAnimation = TweenSequence<Offset>([
                        TweenSequenceItem(
                          tween: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ),
                          weight: 1,
                        ),
                      ]).animate(animation);

                      // 스케일 애니메이션
                      final scaleAnimation = TweenSequence<double>([
                        TweenSequenceItem(
                          tween: Tween<double>(begin: 0.5, end: 1.0),
                          weight: 1,
                        ),
                      ]).animate(animation);

                      return FadeTransition(
                        opacity: fadeAnimation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: child,
                          ),
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 800),
                  ),
                );
              },
              child: const Text('Staggered Animation 예제 보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                throw Exception('Test Exception');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ExplicitPage(),
                //   ),
                // );
              },
              child: const Text('Test Exception'),
              //child: const Text('Explicit Animation 예제 보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GesturePage(),
                  ),
                );
              },
              child: const Text('Gesture Animation 예제 보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const FlutterAnimatedPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .scale(delay: 200.ms, duration: 600.ms)
                          .slideX(begin: 0.2, end: 0);
                    },
                    transitionDuration: const Duration(milliseconds: 800),
                  ),
                );
              },
              child: const Text('Flutter Animate 예제 보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RivePage(),
                  ),
                );
              },
              child: const Text('Rive 예제 보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LottiePage(),
                  ),
                );
              },
              child: const Text('Lottie 예제 보기'),
            ),
          ],
        ),
      ),
    );
  }
}
