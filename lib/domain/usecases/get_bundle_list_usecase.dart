// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:noya_app/domain/repo/bundel_list_repo.dart';

@injectable
class GetBundleListUseCase {
  final BundleRepo bundleRepo;

  @factoryMethod
  GetBundleListUseCase({required this.bundleRepo});

  Future<ApiResult<List<BundleResponse>>> invoke() async {
    final result = await bundleRepo.getList();
    return result;
  }
}
