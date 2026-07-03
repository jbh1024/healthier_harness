import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/board/domain/models/board_post.dart';

void main() {
  group('BoardPost', () {
    test('JSON을 파싱한다', () {
      final post = BoardPost.fromJson({
        'id': 1,
        'title': '첫 글',
        'authorName': '홍길동',
        'isPinned': true,
        'viewCount': 10,
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(post.title, '첫 글');
      expect(post.isPinned, isTrue);
      expect(post.viewCount, 10);
    });

    test('isPinned·viewCount가 없으면 기본값(false, 0)으로 파싱한다', () {
      final post = BoardPost.fromJson({
        'id': 1,
        'title': '첫 글',
        'authorName': '홍길동',
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(post.isPinned, isFalse);
      expect(post.viewCount, 0);
    });
  });

  group('BoardPostDetail', () {
    test('댓글 목록을 포함해 파싱한다', () {
      final detail = BoardPostDetail.fromJson({
        'id': 1,
        'title': '첫 글',
        'content': '본문',
        'authorName': '홍길동',
        'authorId': 7,
        'comments': [
          {
            'id': 100,
            'content': '댓글',
            'authorName': '김철수',
            'authorId': 8,
            'createdAt': '2026-07-03T01:00:00',
          },
          {
            'id': 101,
            'content': '대댓글',
            'authorName': '이영희',
            'authorId': 9,
            'parentId': 100,
            'createdAt': '2026-07-03T02:00:00',
          },
        ],
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(detail.comments, hasLength(2));
      expect(detail.comments[0].parentId, isNull);
      expect(detail.comments[1].parentId, 100);
    });

    test('comments가 없으면 빈 리스트로 파싱한다', () {
      final detail = BoardPostDetail.fromJson({
        'id': 1,
        'title': '첫 글',
        'content': '본문',
        'authorName': '홍길동',
        'authorId': 7,
        'createdAt': '2026-07-03T00:00:00',
      });

      expect(detail.comments, isEmpty);
    });
  });
}
