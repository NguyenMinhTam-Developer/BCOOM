import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/order_remote_data_source.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/get_order_detail_usecase.dart';
import '../../domain/usecases/get_order_list_usecase.dart';
import '../../domain/usecases/get_order_status_usecase.dart';
import '../controllers/order_controller.dart';
import '../controllers/order_detail_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize remote data source
    Get.lazyPut<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
      fenix: true,
    );

    // Initialize repository
    Get.lazyPut<OrderRepository>(
      () => OrderRepositoryImpl(
        Get.find<OrderRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Initialize use cases
    Get.lazyPut<GetOrderStatusUseCase>(
      () => GetOrderStatusUseCase(
        orderRepository: Get.find<OrderRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetOrderListUseCase>(
      () => GetOrderListUseCase(
        orderRepository: Get.find<OrderRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetOrderDetailUseCase>(
      () => GetOrderDetailUseCase(
        orderRepository: Get.find<OrderRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller
    Get.lazyPut<OrderController>(
      () => OrderController(
        getOrderStatusUseCase: Get.find<GetOrderStatusUseCase>(),
        getOrderListUseCase: Get.find<GetOrderListUseCase>(),
      ),
      fenix: true,
    );

    // Initialize order detail controller
    Get.lazyPut<OrderDetailController>(
      () => OrderDetailController(
        getOrderDetailUseCase: Get.find<GetOrderDetailUseCase>(),
      ),
      fenix: true,
    );
  }
}
