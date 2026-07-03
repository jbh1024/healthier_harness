import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/notification/domain/models/notification_model.dart';

void main() {
  group('AppNotification', () {
    test('참조 정보를 포함한 JSON을 파싱한다', () {
      final notification = AppNotification.fromJson({
        'id': 1,
        'type': 'ENROLLMENT',
        'title': '수강 승인',
        'message': '요가 클래스 수강이 승인되었습니다',
        'isRead': false,
        'referenceType': 'COURSE',
        'referenceId': 10,
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(notification.type, 'ENROLLMENT');
      expect(notification.referenceId, 10);
      expect(notification.isRead, isFalse);
    });

    test('참조 정보가 없어도 파싱한다', () {
      final notification = AppNotification.fromJson({
        'id': 1,
        'type': 'NOTICE',
        'title': '공지',
        'message': '내용',
        'isRead': true,
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(notification.referenceType, isNull);
      expect(notification.referenceId, isNull);
    });
  });

  group('NotificationSettings', () {
    test('JSON을 파싱한다', () {
      final settings = NotificationSettings.fromJson({
        'enrollmentNotify': true,
        'noticeNotify': false,
        'commentNotify': true,
      });

      expect(settings.enrollmentNotify, isTrue);
      expect(settings.noticeNotify, isFalse);
      expect(settings.commentNotify, isTrue);
    });
  });
}
