import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/notice/domain/models/notice.dart';

void main() {
  group('Notice', () {
    test('JSON을 파싱한다', () {
      final notice = Notice.fromJson({
        'id': 1,
        'title': '휴원 안내',
        'authorName': '관리자',
        'isImportant': true,
        'viewCount': 30,
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(notice.title, '휴원 안내');
      expect(notice.isImportant, isTrue);
    });

    test('isImportant·viewCount가 없으면 기본값(false, 0)으로 파싱한다', () {
      final notice = Notice.fromJson({
        'id': 1,
        'title': '휴원 안내',
        'authorName': '관리자',
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(notice.isImportant, isFalse);
      expect(notice.viewCount, 0);
    });
  });

  group('NoticeDetail', () {
    test('본문을 포함해 파싱한다', () {
      final detail = NoticeDetail.fromJson({
        'id': 1,
        'title': '휴원 안내',
        'content': '7월 4일 휴원합니다',
        'authorName': '관리자',
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(detail.content, '7월 4일 휴원합니다');
      expect(detail.isImportant, isFalse);
    });
  });
}
