import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/settings/data/datasource/remote/profile_datasource.dart';
import 'package:xchat/src/features/settings/domain/repository/profile_repository.dart';
import 'package:xchat/src/features/settings/domain/usecase/update_profile/update_profile_params.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:dio/dio.dart';

part 'profile_repository_impl.g.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _datasource;

  ProfileRepositoryImpl({required ProfileDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<User>> getProfile({CancelToken? cancelToken}) async {
    final response = await _datasource.getProfile(cancelToken: cancelToken);
    if (response.success && response.data != null) {
      return Result.success(response.data!.toModel());
    }
    return Result.failed(response.message, code: response.error?.code);
  }

  @override
  Future<Result<User>> updateProfile({
    required UpdateProfileParams params,
  }) async {
    final formData = FormData.fromMap({
      if (params.name != null) 'name': params.name,
      if (params.email != null) 'email': params.email,
      if (params.profileImage != null)
        'profile_image': MultipartFile.fromBytes(
          await params.profileImage!.readAsBytes(),
          filename: params.profileImage!.name,
        ),
    });

    final response = await _datasource.update(
      formData: formData,
      cancelToken: params.cancelToken,
    );
    if (response.success && response.data != null) {
      return Result.success(response.data!.toModel());
    }
    return Result.failed(response.message, code: response.error?.code);
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) =>
    ProfileRepositoryImpl(datasource: ref.read(profileDatasourceProvider));
