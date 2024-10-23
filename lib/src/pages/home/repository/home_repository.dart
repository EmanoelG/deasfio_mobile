import '../../../const/endpoint.dart';
import '../../../models/item_model.dart';
import '../../../service/provider_manager.dart';
import '../result/home_result.dart';

class HomeRespository {

  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<ItemModel>> getAllProducts() async {
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.getAllProducts,
        metod: HttpMetod.get,
      );
      if (result['recipes'] != null) {
        List<ItemModel> data =
            (List<Map<String, dynamic>>.from(result['recipes']))
                .map(ItemModel.fromJson)
                .toList();
        // List<Map<String, dynamic>>.from(result['result'])
        return HomeResult.sucess(data);
      } else {
      
            return HomeResult<ItemModel>.error(
                'Ocorreu um erro inesperado ao recuperar categorias !');
      }
    } catch (e) {
      print(e);
      return HomeResult.error('Erro ao solicitar produtos ao servidor !');
    }
  }
}
