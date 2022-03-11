import 'package:get/get.dart'; 
import 'getx_network_manager.dart';

class NetworkBinding extends Bindings{

  // dependence injection attach our class.
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
  }

}