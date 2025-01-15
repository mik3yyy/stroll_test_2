import '../../../../core/network/network.dart';

abstract class HomeRemoteDataSource {
 
  // Define abstract methods here
}

class HomeRemoteDataSourceImpl
    extends HomeRemoteDataSource {
    
     final Network _network;
 
    HomeRemoteDataSourceImpl({required Network network})
      : _network = network;
      
  }
