import '../datasources/home_hive_data_source.dart';
import '../datasources/home_remote_data_source.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeHiveDataSource hiveDataSource;
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.hiveDataSource,
    required this.remoteDataSource,
  });

  // Implement repository methods here, using hiveDataSource and remoteDataSource
}
