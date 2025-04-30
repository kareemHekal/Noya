// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:noya_app/core/api/api_result.dart';
import 'package:noya_app/data/models/bundle_response.dart';
import 'package:noya_app/data/models/categories_response.dart';
import 'package:noya_app/domain/repo/bundel_list_repo.dart';
import 'package:noya_app/domain/repo/categories_list_repo.dart';

@injectable
class GetCategoriesListUseCase {
  final CategoriesRepo categoryRepo;

  @factoryMethod
  GetCategoriesListUseCase({required this.categoryRepo});

  Future<ApiResult<List<CategoriesResponse>>> invoke() async {
    final result = await categoryRepo.getList();
    return result;
  }
}
