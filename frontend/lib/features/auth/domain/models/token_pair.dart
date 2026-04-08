class TokenPair {
  final String accessToken;
  final String refreshToken;

  const TokenPair({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenPair.fromJson(Map<String, dynamic> json) => TokenPair(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );
}
