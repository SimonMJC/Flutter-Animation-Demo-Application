import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Lottie 애니메이션을 보여주는 페이지
/// - Lottie 파일을 사용한 복잡한 애니메이션 구현
/// - AnimationController를 통한 애니메이션 제어
/// - 애니메이션 상태 관리 및 반복 재생
class LottiePage extends StatefulWidget {
  const LottiePage({super.key});

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> with TickerProviderStateMixin {
  // 애니메이션 컨트롤러 - Lottie 애니메이션의 재생을 제어
  late final AnimationController _controller;
  // 애니메이션 재생 상태 추적
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 초기화 (1초 동안 실행)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();  // 애니메이션 컨트롤러 해제
    super.dispose();
  }

  /// 애니메이션 시작/중지 토글
  void _toggleAnimation() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.forward();   // 애니메이션 시작
      } else {
        _controller.stop();      // 애니메이션 중지
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie 애니메이션 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie 애니메이션 위젯
            Lottie.asset(
              'assets/lottie.json',  // Lottie JSON 파일 경로
              controller: _controller,  // 애니메이션 컨트롤러 연결
              onLoaded: (composition) {
                // Lottie 파일이 로드되면 실행되는 콜백
                _controller
                  ..duration = composition.duration  // 애니메이션 지속 시간 설정
                  ..addStatusListener((status) {
                    // 애니메이션 상태 변경 리스너
                    if (status == AnimationStatus.completed) {
                      _controller.reset();  // 애니메이션 완료 시 초기화
                      if (_isPlaying) {
                        _controller.forward();  // 재생 중이면 다시 시작
                      }
                    }
                  });
              },
            ),
            const SizedBox(height: 20),
            // 애니메이션 제어 버튼
            ElevatedButton(
              onPressed: _toggleAnimation,
              child: Text(_isPlaying ? '애니메이션 중지' : '애니메이션 시작'),
            ),
          ],
        ),
      ),
    );
  }
} 