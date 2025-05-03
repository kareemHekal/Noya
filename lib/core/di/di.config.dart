// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../data/repo_impl/bundle_list_repo_impl.dart' as _i824;
import '../../data/repo_impl/categories_list_repo_impl.dart' as _i359;
import '../../data/repo_impl/get_proudct_by_id_repo_impl.dart' as _i397;
import '../../data/repo_impl/materials_list_repo_impl.dart' as _i477;
import '../../data/repo_impl/workers_list_repo_impl.dart' as _i170;
import '../../domain/repo/bundel_list_repo.dart' as _i610;
import '../../domain/repo/categories_list_repo.dart' as _i993;
import '../../domain/repo/materials_list_repo.dart' as _i400;
import '../../domain/repo/prodct_by_id_repo.dart' as _i728;
import '../../domain/repo/workers_list_repo.dart' as _i665;
import '../../domain/usecases/get_bundle_list_usecase.dart' as _i160;
import '../../domain/usecases/get_categories_list_usecase.dart' as _i393;
import '../../domain/usecases/get_materials_list_usecase.dart' as _i101;
import '../../domain/usecases/get_product_by_id_usecase.dart' as _i705;
import '../../domain/usecases/get_workers_list_usecase.dart' as _i286;
import '../../presentation/auth/view_model/cubit/auth_cubit.dart' as _i351;
import '../../presentation/check_out_page/view_model/check_out_cubit.dart'
    as _i654;
import '../../presentation/materials/view_model/materials_cubit.dart' as _i494;
import '../../presentation/package_details/view_model/pakage_details_cubit.dart'
    as _i843;
import '../../presentation/product_card/view_model/cubit/product_card_cubit.dart'
    as _i583;
import '../../presentation/tabs/coustom_tab/view_model/categories_cubit.dart'
    as _i922;
import '../../presentation/tabs/packages/view_model/cubit/bundle_cubit.dart'
    as _i890;
import '../../presentation/workers/view_model/workers_cubit.dart' as _i458;
import '../api/api_manager.dart' as _i1047;
import '../logger/logger_module.dart' as _i279;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final loggerModule = _$LoggerModule();
    gh.factory<_i351.AuthCubit>(() => _i351.AuthCubit());
    gh.factory<_i654.CheckOutCubit>(() => _i654.CheckOutCubit());
    gh.factory<_i843.PackageDetailsCubit>(() => _i843.PackageDetailsCubit());
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.factory<_i728.ProductByIdRepo>(
      () => _i397.GetProudctByIdRepoImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i400.MaterialsRepo>(
      () => _i477.CategoriesListRepoImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i610.BundleRepo>(
      () => _i824.BundleRepoImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i665.WorkersRepo>(
      () => _i170.WorkersListRepoImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i993.CategoriesRepo>(
      () => _i359.CategoriesListRepoImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i705.GetProductByIdUsecase>(
      () =>
          _i705.GetProductByIdUsecase(bundleRepo: gh<_i728.ProductByIdRepo>()),
    );
    gh.factory<_i583.ProductByIdCubit>(
      () => _i583.ProductByIdCubit(gh<_i705.GetProductByIdUsecase>()),
    );
    gh.factory<_i160.GetBundleListUseCase>(
      () => _i160.GetBundleListUseCase(bundleRepo: gh<_i610.BundleRepo>()),
    );
    gh.factory<_i101.GetMaterialsListUseCase>(
      () => _i101.GetMaterialsListUseCase(
        materialRepo: gh<_i400.MaterialsRepo>(),
      ),
    );
    gh.factory<_i494.MaterialsCubit>(
      () => _i494.MaterialsCubit(gh<_i101.GetMaterialsListUseCase>()),
    );
    gh.factory<_i286.GetWorkersListUsecase>(
      () => _i286.GetWorkersListUsecase(workerRepo: gh<_i665.WorkersRepo>()),
    );
    gh.factory<_i393.GetCategoriesListUseCase>(
      () => _i393.GetCategoriesListUseCase(
        categoryRepo: gh<_i993.CategoriesRepo>(),
      ),
    );
    gh.factory<_i890.BundleCubit>(
      () => _i890.BundleCubit(gh<_i160.GetBundleListUseCase>()),
    );
    gh.factory<_i458.WorkersCubit>(
      () => _i458.WorkersCubit(gh<_i286.GetWorkersListUsecase>()),
    );
    gh.factory<_i922.CategoriesCubit>(
      () => _i922.CategoriesCubit(gh<_i393.GetCategoriesListUseCase>()),
    );
    return this;
  }
}

class _$LoggerModule extends _i279.LoggerModule {}
