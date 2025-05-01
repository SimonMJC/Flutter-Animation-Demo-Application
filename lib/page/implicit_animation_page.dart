import 'package:flutter/material.dart';

/// 암시적 애니메이션을 보여주는 페이지
/// - AnimatedContainer, AnimatedOpacity 등 기본 위젯을 사용한 애니메이션
/// - 상태 변경 시 자동으로 애니메이션 적용
/// - 간단한 UI 요소들의 부드러운 전환 효과
class ImplicitAnimationPage extends StatefulWidget {
  const ImplicitAnimationPage({super.key});

  @override
  State<ImplicitAnimationPage> createState() => _ImplicitAnimationPageState();
}

class _ImplicitAnimationPageState extends State<ImplicitAnimationPage> {
  // 애니메이션 상태를 제어하는 변수들
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  double _opacity = 1.0;
  double _rotation = 0.0;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('암시적 애니메이션 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 크기 변화 애니메이션
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _width,
              height: _height,
              color: _color,
              child: const Center(
                child: Text('크기와 색상 변화'),
              ),
            ),
            const SizedBox(height: 20),
            // 투명도 변화 애니메이션
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text('투명도 변화'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 회전 애니메이션
            AnimatedRotation(
              duration: const Duration(seconds: 1),
              turns: _rotation,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
                child: const Center(
                  child: Text('회전'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 크기 조절 애니메이션
            AnimatedScale(
              duration: const Duration(seconds: 1),
              scale: _scale,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.purple,
                child: const Center(
                  child: Text('크기 조절'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 애니메이션 제어 버튼들
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _width = _width == 100 ? 200 : 100;
                  _height = _height == 100 ? 200 : 100;
                  _color = _color == Colors.blue ? Colors.red : Colors.blue;
                });
              },
              child: const Text('크기/색상 변경'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                });
              },
              child: const Text('투명도 변경'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _rotation = _rotation == 0.0 ? 0.5 : 0.0;
                });
              },
              child: const Text('회전'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _scale = _scale == 1.0 ? 1.5 : 1.0;
                });
              },
              child: const Text('크기 조절'),
            ),
          ],
        ),
      ),
    );
  }
} 