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
import '../../domain/repo/bundel_list_repo.dart' as _i610;
import '../../domain/usecases/get_bundle_list_usecase.dart' as _i160;
import '../../presentation/auth/view_model/cubit/auth_cubit.dart' as _i351;
import '../../presentation/tabs/packages/view_model/cubit/bundle_cubit.dart'
    as _i890;
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
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.factory<_i610.BundleRepo>(
      () => _i824.BundleRepoImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i160.GetBundleListUseCase>(
      () => _i160.GetBundleListUseCase(bundleRepo: gh<_i610.BundleRepo>()),
    );
    gh.factory<_i890.BundleCubit>(
      () => _i890.BundleCubit(gh<_i160.GetBundleListUseCase>()),
    );
    return this;
  }
}

class _$LoggerModule extends _i279.LoggerModule {}
