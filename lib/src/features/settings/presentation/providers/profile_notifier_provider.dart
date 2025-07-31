import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/settings/domain/usecase/update_profile/update_profile_params.dart';
import 'package:xchat/src/features/settings/domain/usecase/update_profile/update_profile_usecase.dart';

part 'profile_notifier_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  FutureOr<void> build() {
    // Tidak ada state awal yang perlu dibangun
  }

  Future<bool> updateProfile(UpdateProfileParams params) async {
    state = const AsyncLoading();
    final usecase = ref.read(updateProfileProvider);
    final result = await usecase(params);

    switch (result) {
      case Success(value: final user):
        ref.read(authUserProvider.notifier).setUser(user);
        state = const AsyncData(null);
        return true;
      case Failed(message: final message):
        state = AsyncError(message, StackTrace.current);
        return false;
    }
  }
}
