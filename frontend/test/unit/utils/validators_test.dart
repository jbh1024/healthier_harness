import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('null이면 입력 요청 메시지를 반환한다', () {
      expect(Validators.email(null), '이메일을 입력해주세요');
    });

    test('빈 문자열이면 입력 요청 메시지를 반환한다', () {
      expect(Validators.email(''), '이메일을 입력해주세요');
    });

    test('형식이 잘못되면 형식 오류 메시지를 반환한다', () {
      expect(Validators.email('invalid'), '올바른 이메일 형식이 아닙니다');
      expect(Validators.email('a@b'), '올바른 이메일 형식이 아닙니다');
      expect(Validators.email('a b@c.com'), '올바른 이메일 형식이 아닙니다');
    });

    test('올바른 형식이면 null을 반환한다', () {
      expect(Validators.email('user@example.com'), isNull);
      expect(Validators.email('a.b-c@sub.domain.co'), isNull);
    });
  });

  group('Validators.password', () {
    test('null 또는 빈 문자열이면 입력 요청 메시지를 반환한다', () {
      expect(Validators.password(null), '비밀번호를 입력해주세요');
      expect(Validators.password(''), '비밀번호를 입력해주세요');
    });

    test('8자 미만이면 길이 오류 메시지를 반환한다', () {
      expect(Validators.password('a1!'), '비밀번호는 8자 이상이어야 합니다');
    });

    test('영문·숫자·특수문자 중 하나라도 없으면 조합 오류 메시지를 반환한다', () {
      expect(Validators.password('abcdefgh'), '영문, 숫자, 특수문자를 모두 포함해야 합니다');
      expect(Validators.password('abcd1234'), '영문, 숫자, 특수문자를 모두 포함해야 합니다');
      expect(Validators.password('1234!@#\$'), '영문, 숫자, 특수문자를 모두 포함해야 합니다');
    });

    test('규칙을 모두 만족하면 null을 반환한다', () {
      expect(Validators.password('abcd123!'), isNull);
    });
  });

  group('Validators.required', () {
    test('null·빈 문자열·공백이면 입력 요청 메시지를 반환한다', () {
      expect(Validators.required(null, '이름'), '이름을(를) 입력해주세요');
      expect(Validators.required('', '이름'), '이름을(를) 입력해주세요');
      expect(Validators.required('   ', '이름'), '이름을(를) 입력해주세요');
    });

    test('값이 있으면 null을 반환한다', () {
      expect(Validators.required('값', '이름'), isNull);
    });
  });

  group('Validators.name', () {
    test('null 또는 공백이면 입력 요청 메시지를 반환한다', () {
      expect(Validators.name(null), '이름을 입력해주세요');
      expect(Validators.name('  '), '이름을 입력해주세요');
    });

    test('50자를 초과하면 길이 오류 메시지를 반환한다', () {
      expect(Validators.name('가' * 51), '이름은 50자 이하여야 합니다');
    });

    test('올바른 이름이면 null을 반환한다', () {
      expect(Validators.name('홍길동'), isNull);
      expect(Validators.name('가' * 50), isNull);
    });
  });
}
