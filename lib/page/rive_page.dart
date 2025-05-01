import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Rive 애니메이션을 보여주는 페이지
/// - Rive 파일을 사용한 인터랙티브 애니메이션 구현
class RivePage extends StatefulWidget {
  const RivePage({super.key});

  @override
  State<RivePage> createState() => _RivePageState();
}

class _RivePageState extends State<RivePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive 애니메이션 예제'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rive 애니메이션 위젯
            SizedBox(
              width: 300,
              height: 300,
              child: RiveAnimation.asset(
                'assets/rive/cart.riv',  // Rive 파일 경로
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
} 