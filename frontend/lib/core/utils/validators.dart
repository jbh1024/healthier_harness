class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    if (value.length < 8) {
      return '비밀번호는 8자 이상이어야 합니다';
    }
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    final hasSpecial = RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"|,.<>/?]').hasMatch(value);
    if (!hasLetter || !hasDigit || !hasSpecial) {
      return '영문, 숫자, 특수문자를 모두 포함해야 합니다';
    }
    return null;
  }

  static String? required(String? value, [String fieldName = '']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName을(를) 입력해주세요'.trim();
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이름을 입력해주세요';
    }
    if (value.length > 50) {
      return '이름은 50자 이하여야 합니다';
    }
    return null;
  }
}
