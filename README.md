# Flutter Animation Demo

이 프로젝트는 Flutter의 다양한 애니메이션 기법을 보여주는 데모 앱입니다.

## 애니메이션 기법

### 1. Implicit Animation (암시적 애니메이션)
- **개념**: 상태 변경 시 자동으로 애니메이션이 적용되는 간단한 애니메이션
- **주요 위젯**:
  - `AnimatedContainer`: 크기, 색상, 여백 등의 변화
  - `AnimatedOpacity`: 투명도 변화
  - `AnimatedRotation`: 회전 효과
  - `AnimatedScale`: 크기 조절
- **사용 방법**:
  ```dart
  AnimatedContainer(
    duration: const Duration(seconds: 1),
    width: _width,
    height: _height,
    color: _color,
  )
  ```

### 2. Staggered Animation (순차적 애니메이션)
- **개념**: 여러 요소가 순차적으로 애니메이션되는 효과
- **주요 클래스**:
  - `AnimationController`: 애니메이션의 진행 제어
  - `Interval`: 각 애니메이션의 시작/종료 시점 지정
  - `CurvedAnimation`: 애니메이션 커브 적용
- **사용 방법**:
  ```dart
  _fadeAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    ),
  );
  ```

### 3. Explicit Animation (명시적 애니메이션)
- **개념**: 개발자가 직접 애니메이션의 시작, 종료, 진행 상태를 제어
- **주요 클래스**:
  - `AnimationController`: 애니메이션의 진행 제어
  - `Tween`: 값의 범위 정의
  - `AnimatedBuilder`: 애니메이션 값에 따른 위젯 재구성
- **사용 방법**:
  ```dart
  AnimatedBuilder(
    animation: _controller,
    builder: (context, child) {
      return Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      );
    },
  );
  ```

### 4. Gesture Animation (제스처 애니메이션)
- **개념**: 사용자의 터치, 드래그 등 제스처에 반응하는 애니메이션
- **주요 위젯**:
  - `LongPressDraggable`: 길게 누르면 드래그 가능한 위젯
  - `DragTarget`: 드래그된 아이템을 받을 수 있는 영역
- **사용 방법**:
  ```dart
  LongPressDraggable<String>(
    data: item,
    feedback: Material(...),
    child: Container(...),
  )
  ```

### 5. Flutter Animate
- **개념**: 간단한 선언적 문법으로 복잡한 애니메이션 구현
- **주요 기능**:
  - 체이닝 방식의 애니메이션 정의
  - 다양한 애니메이션 효과 제공
- **사용 방법**:
  ```dart
  child.animate()
    .fadeIn(duration: 600.ms)
    .scale(delay: 200.ms, duration: 600.ms)
    .slideX(begin: 0.2, end: 0);
  ```

### 6. Rive
- **개념**: 인터랙티브한 벡터 애니메이션 구현
- **주요 기능**:
  - 상태 머신을 통한 애니메이션 제어
  - 사용자 입력에 따른 상태 전환
- **사용 방법**:
  ```dart
  RiveAnimation.asset(
    'assets/animation.riv',
    controllers: [_controller],
  );
  ```

### 7. Lottie
- **개념**: Adobe After Effects로 제작된 애니메이션을 Flutter에서 재생
- **주요 기능**:
  - 복잡한 애니메이션 효과 구현
  - 애니메이션 재생 제어
- **사용 방법**:
  ```dart
  Lottie.asset(
    'assets/animation.json',
    controller: _controller,
  );
  ```

## 프로젝트 실행 방법

1. 의존성 설치:
   ```bash
   flutter pub get
   ```

2. 앱 실행:
   ```bash
   flutter run
   ```

## 주의사항

- Rive와 Lottie 애니메이션을 사용하기 위해서는 각각의 애니메이션 파일이 필요합니다.
- 애니메이션 파일은 `assets` 폴더에 위치해야 합니다.
- 각 애니메이션의 성능을 고려하여 적절한 사용이 필요합니다.
