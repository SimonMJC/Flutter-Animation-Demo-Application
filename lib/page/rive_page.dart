import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Rive 애니메이션을 보여주는 페이지
/// - Rive 파일을 사용한 인터랙티브 애니메이션 구현
/// - 상태 머신을 통한 애니메이션 제어
/// - 사용자 입력에 따른 애니메이션 상태 전환
class RivePage extends StatefulWidget {
  const RivePage({super.key});

  @override
  State<RivePage> createState() => _RivePageState();
}

class _RivePageState extends State<RivePage> {
  // Rive 파일 컨트롤러
  late RiveAnimationController _controller;
  // 현재 애니메이션 상태
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // SimpleAnimation 컨트롤러 초기화
    _controller = SimpleAnimation('Animation 1');
  }

  @override
  void dispose() {
    _controller.dispose();  // 컨트롤러 해제
    super.dispose();
  }

  /// 애니메이션 시작/중지 토글
  void _toggleAnimation() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.isActive = true;  // 애니메이션 시작
      } else {
        _controller.isActive = false;  // 애니메이션 중지
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive 애니메이션 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rive 애니메이션 위젯
            SizedBox(
              width: 300,
              height: 300,
              child: RiveAnimation.asset(
                'assets/rive_animation.riv',  // Rive 파일 경로
                controllers: [_controller],  // 애니메이션 컨트롤러 연결
                onInit: (_) => setState(() {}),  // 초기화 완료 시 상태 업데이트
              ),
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