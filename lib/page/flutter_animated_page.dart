import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


// docs: https://pub.dev/packages/flutter_animate
class FlutterAnimatedPage extends StatefulWidget {
  const FlutterAnimatedPage({super.key});

  @override
  State<FlutterAnimatedPage> createState() => _FlutterAnimatedPageState();
}

class _FlutterAnimatedPageState extends State<FlutterAnimatedPage> {
  int? _selectedDemoIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Flutter Animate 예제'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더 이미지에 페이드인과 스케일 애니메이션을 적용합니다.
            // 이미지는 페이지 진입 시 자연스럽게 나타나고 약간 확대되는 효과를 줍니다.
            Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://mblogthumb-phinf.pstatic.net/MjAyMjA0MjJfMzMg/MDAxNjUwNjM5NDI4MDMw.KBaxEwr3u-7cIzhmGLEUS9hc1HIxm2bRN8wZG3PNmccg.tcgRsp7uf2QMCZU213N-As2TKVo1V02oCY9lC3FZNEUg.GIF.megbaby_/1650452252739.GIF?type=w800',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
                .animate() // flutter_animate의 animate()로 애니메이션 체이닝 시작
                .fadeIn(duration: 600.ms) // 0.6초 동안 서서히 나타남
                .scale(delay: 200.ms, duration: 600.ms), // 0.2초 후 0.6초간 확대

            // 제목 섹션에 페이드인과 슬라이드 애니메이션을 적용합니다.
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 큰 제목에 페이드인 + 오른쪽에서 왼쪽으로 슬라이드
                  Text(
                    'Flutter Animate를 활용한\n고급 애니메이션 효과',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideX(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                  // 날짜/소요시간에도 페이드인 + 슬라이드
                  Text(
                    '2025년 5월 1일',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideX(begin: 0.1, end: 0),
                ],
              ),
            ),

            // 본문 섹션: 각 항목별로 애니메이션 예제와 설명을 제공합니다.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context,
                    '1. 페이드 인 효과',
                    '페이드 인 효과는 UI 요소가 부드럽게 나타나는 효과입니다. 사용자 경험을 향상시키는 기본적인 애니메이션 중 하나입니다.',
                    Colors.blue,
                    _buildFadeInDemo(),
                    0,
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    context,
                    '2. 스케일 & 회전 효과',
                    '스케일과 회전 효과를 조합하면 더욱 동적인 UI를 만들 수 있습니다. 특히 카드나 이미지에 적용하면 효과적입니다.',
                    Colors.green,
                    _buildScaleRotateDemo(),
                    1,
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    context,
                    '3. 색상 변화 효과',
                    '색상 변화는 사용자의 주의를 끌거나 상태 변화를 나타내는데 유용합니다. 부드러운 색상 전환은 시각적 만족도를 높입니다.',
                    Colors.orange,
                    _buildColorChangeDemo(),
                    2,
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    context,
                    '4. 효과 조합',
                    '여러 애니메이션 효과를 조합하면 더욱 풍부한 사용자 경험을 제공할 수 있습니다. 타이밍과 딜레이를 조절하여 자연스러운 흐름을 만들어보세요.',
                    Colors.red,
                    _buildCombinedEffectDemo(),
                    3,
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    context,
                    '5. GLSL Shader 효과',
                    'GLSL Shader를 활용하면 고급 시각 효과를 구현할 수 있습니다. 빛나는 효과나 블러 효과는 UI에 세련된 느낌을 더해줍니다.',
                    Colors.teal,
                    _buildShaderEffectDemo(),
                    4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 각 애니메이션 섹션을 구성하는 위젯입니다.
  // 제목을 클릭하면 해당 애니메이션이 실행됩니다.
  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    Color color,
    Widget demo,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목(버튼 역할) - 클릭 시 해당 애니메이션 실행
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDemoIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
            .animate() // 제목 등장 애니메이션(페이드인+슬라이드)
            .fadeIn(duration: 600.ms)
            .slideX(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        // 설명 텍스트에도 등장 애니메이션 적용
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: Colors.grey[800],
              ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideX(begin: 0.1, end: 0),
        const SizedBox(height: 16),
        demo, // 실제 애니메이션 데모 위젯
      ],
    );
  }

  // 1. 페이드 인 효과: 클릭 시 컨테이너가 서서히 나타남
  Widget _buildFadeInDemo() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          '페이드 인 효과',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    )
        .animate(
          target: _selectedDemoIndex == 0 ? 1 : 0, // 0번 제목 클릭 시만 실행
        )
        .fadeIn(duration: 1.seconds); // 1초간 서서히 나타남
  }

  // 2. 스케일 & 회전 효과: 클릭 시 컨테이너가 커지고 회전함
  Widget _buildScaleRotateDemo() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          '스케일 & 회전',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    )
        .animate(
          target: _selectedDemoIndex == 1 ? 1 : 0, // 1번 제목 클릭 시만 실행
        )
        .scale(duration: 1.seconds) // 1초간 커짐
        .rotate(duration: 1.seconds, begin: 0, end: 1); // 1초간 1회전
  }

  // 3. 색상 변화 효과: 클릭 시 컨테이너 배경색이 오렌지→퍼플로 변함
  Widget _buildColorChangeDemo() {
    final isSelected = _selectedDemoIndex == 2;
    return AnimatedContainer(
      duration: const Duration(seconds: 1), // 1초간 색상 변경
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.orange, // 클릭 시 색상 변경
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          '색상 변화',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  // 4. 효과 조합: 클릭 시 컨테이너 색상, 둥근 정도, 텍스트 스타일이 함께 변함
  Widget _buildCombinedEffectDemo() {
    final isSelected = _selectedDemoIndex == 3;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800), // 0.8초간 애니메이션
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.red, // 클릭 시 색상 변경
        borderRadius: BorderRadius.circular(isSelected ? 32 : 12), // 둥근 정도 변경
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 800), // 텍스트 스타일도 함께 변경
          style: TextStyle(
            fontSize: isSelected ? 22 : 16,
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          child: const Text('조합 효과'),
        ),
      ),
    );
  }

  // 5. GLSL Shader 효과: 클릭 시 컨테이너에 빛나는 효과와 블러 효과가 적용됨
  Widget _buildShaderEffectDemo() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'Shader 효과',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    )
        .animate(
          target: _selectedDemoIndex == 4 ? 1 : 0, // 4번 제목 클릭 시만 실행
        )
        .shimmer(
          duration: 2.seconds, // 2초간 빛나는 효과
          color: Colors.white.withOpacity(0.3),
        )
        .blur(
          begin: const Offset(0, 0),
          end: const Offset(2, 2),
          duration: 1.seconds, // 1초간 블러 효과
        );
  }
} 