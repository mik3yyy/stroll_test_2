import 'package:get_it/get_it.dart';
import 'package:stroll_test/core/network/network.dart';
import 'package:stroll_test/core/network/url_config.dart';

import 'package:stroll_test/core/storage/hive/hive_service.dart';
import 'package:stroll_test/features/home/data/datasources/home_hive_data_source.dart';
import 'package:stroll_test/features/home/data/datasources/home_remote_data_source.dart';
import 'package:stroll_test/features/home/data/repositories/home_repository_impl.dart';
import 'package:stroll_test/features/home/domain/repositories/home_repository.dart';
import 'package:stroll_test/features/home/domain/usecases/get_home_data.dart';
import 'package:stroll_test/features/home/presentation/blocs/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Hive initialization
  final hiveService = HiveService();
  await hiveService.init();
  sl.registerLazySingleton(() => hiveService);

  // TODO: Add other services and dependencies here
  sl
    ..registerFactory(() => HomeBloc(getHomeData: sl()))
    ..registerLazySingleton(() => GetHomeData(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(remoteDataSource: sl(), hiveDataSource: sl()))
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<HomeHiveDataSource>(
      () => HomeHiveDataSourceImpl(),
    )
    ..registerLazySingleton(
        () => Network(baseUrl: UrlConfig.baseUrl, showLog: true));
}
