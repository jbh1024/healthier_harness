import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/oauth_repository.dart';

class SecuritySettingsScreen extends ConsumerWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('보안 설정')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Google 연동
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Google 계정 연동',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.g_mobiledata, size: 32),
                  title: const Text('Google 계정 연동'),
                  subtitle: const Text('Google 계정으로 간편 로그인'),
                  trailing: OutlinedButton(
                    onPressed: () => _linkGoogle(context, ref),
                    child: const Text('연동'),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.link_off),
                  title: const Text('Google 연동 해제'),
                  trailing: TextButton(
                    onPressed: () => _unlinkGoogle(context, ref),
                    child: const Text('해제'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Passkey
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Passkey (생체 인증)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.fingerprint, size: 32),
                  title: const Text('Passkey 등록'),
                  subtitle: const Text('지문/Face ID로 로그인'),
                  trailing: OutlinedButton(
                    onPressed: () => _registerPasskey(context, ref),
                    child: const Text('등록'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Passkey 등록/인증은 WebAuthn API 연동 후 사용 가능합니다.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _linkGoogle(BuildContext context, WidgetRef ref) async {
    // TODO: 실제 Google Sign-In SDK 연동
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign-In SDK 연동이 필요합니다')),
    );
  }

  Future<void> _unlinkGoogle(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(oauthRepositoryProvider).unlinkGoogle();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google 연동이 해제되었습니다')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _registerPasskey(BuildContext context, WidgetRef ref) async {
    // TODO: 실제 WebAuthn API 연동
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('WebAuthn API 연동이 필요합니다')),
    );
  }
}
