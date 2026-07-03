import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/core/widgets/empty_state.dart';
import 'package:healthier/core/widgets/error_view.dart';
import 'package:healthier/core/widgets/loading_indicator.dart';

Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('EmptyState', () {
    testWidgets('메시지와 기본 아이콘을 표시한다', (tester) async {
      await tester.pumpWidget(wrap(const EmptyState(message: '수업이 없습니다')));

      expect(find.text('수업이 없습니다'), findsOneWidget);
      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('지정한 아이콘을 표시한다', (tester) async {
      await tester.pumpWidget(
        wrap(const EmptyState(message: '알림 없음', icon: Icons.notifications_none)),
      );

      expect(find.byIcon(Icons.notifications_none), findsOneWidget);
    });
  });

  group('ErrorView', () {
    testWidgets('오류 메시지를 표시한다', (tester) async {
      await tester.pumpWidget(wrap(const ErrorView(message: '오류가 발생했습니다')));

      expect(find.text('오류가 발생했습니다'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('onRetry가 없으면 다시 시도 버튼을 표시하지 않는다', (tester) async {
      await tester.pumpWidget(wrap(const ErrorView(message: '오류')));

      expect(find.text('다시 시도'), findsNothing);
    });

    testWidgets('다시 시도 버튼을 누르면 onRetry가 호출된다', (tester) async {
      var retried = false;
      await tester.pumpWidget(
        wrap(ErrorView(message: '오류', onRetry: () => retried = true)),
      );

      await tester.tap(find.text('다시 시도'));

      expect(retried, isTrue);
    });
  });

  group('LoadingIndicator', () {
    testWidgets('로딩 인디케이터를 표시한다', (tester) async {
      await tester.pumpWidget(wrap(const LoadingIndicator()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
