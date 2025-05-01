import 'package:flutter/material.dart';

/// 명시적 애니메이션을 보여주는 페이지
/// - AnimationController를 사용한 직접적인 애니메이션 제어
/// - 여러 Tween을 사용한 복합 애니메이션
/// - 순차적 애니메이션 구현
class ExplicitPage extends StatefulWidget {
  const ExplicitPage({super.key});

  @override
  State<ExplicitPage> createState() => _ExplicitPageState();
}

class _ExplicitPageState extends State<ExplicitPage> with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러 - 애니메이션의 시작, 정지, 반복 등을 제어
  late AnimationController _controller;
  
  // 다양한 애니메이션 효과를 위한 Tween
  late Animation<double> _scaleAnimation;    // 크기 변화 애니메이션
  late Animation<Offset> _slideAnimation;    // 위치 이동 애니메이션
  late Animation<double> _fadeAnimation;     // 투명도 변화 애니메이션
  late Animation<Color?> _colorAnimation;    // 색상 변화 애니메이션
  
  bool _isPlaying = false;  // 애니메이션 재생 상태 추적
  
  // 순차적 애니메이션을 위한 데이터
  final List<String> _items = ['첫 번째 아이템', '두 번째 아이템', '세 번째 아이템', '네 번째 아이템'];
  final List<bool> _itemVisibility = [false, false, false, false];  // 각 아이템의 표시 상태

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 초기화 (500ms 동안 실행)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 크기 변화 애니메이션 (0.0 -> 1.0)
    // easeOutBack 커브를 사용하여 탄성 효과 추가
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // 위치 이동 애니메이션 (아래에서 위로)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),  // 시작 위치 (중앙에서 아래로 50%)
      end: Offset.zero,               // 끝 위치 (중앙)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // 투명도 변화 애니메이션 (0.0 -> 1.0)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // 색상 변화 애니메이션 (파란색 -> 빨간색)
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);

    // 애니메이션 상태 변경 리스너
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
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
        _controller.reverse();   // 애니메이션 역방향 실행
      }
    });
  }

  /// 순차적 애니메이션 실행
  /// 각 아이템이 200ms 간격으로 순차적으로 나타남
  void _animateItems() {
    for (int i = 0; i < _items.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        setState(() {
          _itemVisibility[i] = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animation 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기본 애니메이션 예제
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // 여러 애니메이션 효과를 조합하여 적용
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.translate(
                    offset: _slideAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _colorAnimation.value,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            '애니메이션 예제',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleAnimation,
              child: Text(_isPlaying ? '애니메이션 중지' : '애니메이션 시작'),
            ),
            const SizedBox(height: 40),
            // 순차적 애니메이션 예제
            ElevatedButton(
              onPressed: _animateItems,
              child: const Text('순차적 애니메이션 시작'),
            ),
            const SizedBox(height: 20),
            // 리스트 아이템들을 순차적으로 표시
            ...List.generate(_items.length, (index) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _itemVisibility[index] ? 1.0 : 0.0,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(_items[index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
} 