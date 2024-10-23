import 'package:get/get.dart';
import '../../../models/item_model.dart';
import '../repository/home_repository.dart';
import '../result/home_result.dart';

const int itemsPerPage = 10;
class HomeController extends GetxController {
  final homeRespository = HomeRespository();
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<ItemModel>  allProducts = [];
  var pageNow = 0;
  RxString searchTitle = ''.obs;

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

    update();
  }


  void filterByTitle() {
  
    getAllProducts();
  }

  Future<void> getAllProducts({bool canLoading = true}) async {
    if (canLoading == true) {
      setLoading(true, isProduct: true);
    }

  

    

    HomeResult<ItemModel> homeResult =
        await homeRespository.getAllProducts();

    setLoading(false, isProduct: true);

    homeResult.when(
      sucess: (data) async {
        allProducts.addAll(data);
      },
      error: (error) {
        // AuthController auth = AuthController();
      },
    );
      update();
  }

  @override
  void onInit() {
    super.onInit();

    debounce(searchTitle, (_) => filterByTitle(),
        time: const Duration(seconds: 1));
    getAllProducts();
  }
}
