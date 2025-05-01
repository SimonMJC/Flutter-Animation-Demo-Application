import 'package:flutter/material.dart';

/// 제스처 기반 애니메이션을 보여주는 페이지
/// - 드래그 앤 드롭 기능 구현
/// - LongPressDraggable과 DragTarget을 사용한 상호작용
/// - 시각적 피드백을 통한 사용자 경험 향상
class GesturePage extends StatefulWidget {
  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  // 드래그 가능한 아이템 목록
  final List<String> _items = ['사과', '바나나', '오렌지', '포도'];
  // 쇼핑 카트에 추가된 아이템 목록
  final List<String> _cartItems = [];
  // 현재 드래그 중인지 여부를 추적
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('제스처 애니메이션'),
      ),
      body: Column(
        children: [
          // 쇼핑 카트 영역 (DragTarget)
          DragTarget<String>(
            // 드래그된 아이템이 드롭되었을 때 호출되는 콜백
            onAccept: (data) {
              setState(() {
                if (!_cartItems.contains(data)) {
                  _cartItems.add(data);
                }
              });
            },
            // 드래그 중인 아이템이 영역에 들어왔을 때의 시각적 피드백
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 100,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  // 드래그 중인 아이템이 영역에 들어왔을 때 배경색 변경
                  color: candidateData.isNotEmpty ? Colors.blue.withOpacity(0.1) : null,
                ),
                child: Center(
                  child: _cartItems.isEmpty
                      ? const Text('여기에 아이템을 드래그하세요')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _cartItems.map((item) {
                            return Chip(
                              label: Text(item),
                              // 칩의 삭제 버튼 클릭 시 아이템 제거
                              onDeleted: () {
                                setState(() {
                                  _cartItems.remove(item);
                                });
                              },
                            );
                          }).toList(),
                        ),
                ),
              );
            },
          ),
          // 아이템 목록
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                // 길게 누르면 드래그 가능한 위젯
                return LongPressDraggable<String>(
                  data: item,
                  // 드래그 중인 아이템의 시각적 표현
                  feedback: Material(
                    elevation: 4,
                    child: Container(
                      width: 100,
                      height: 50,
                      color: Colors.blue.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // 드래그 중일 때 원래 위치에 표시되는 위젯
                  childWhenDragging: Container(
                    width: 100,
                    height: 50,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  // 드래그 시작 시 상태 업데이트
                  onDragStarted: () {
                    setState(() {
                      _isDragging = true;
                    });
                  },
                  // 드래그 종료 시 상태 업데이트
                  onDragEnd: (_) {
                    setState(() {
                      _isDragging = false;
                    });
                  },
                  // 실제 표시되는 아이템 위젯
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isDragging ? Colors.grey.withOpacity(0.3) : Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 