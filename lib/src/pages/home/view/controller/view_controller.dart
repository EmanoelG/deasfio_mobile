import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../data/datasources/item_local_data_source.dart';
import '../../../../../data/domain/usecases/save_item.dart';
import '../../../../../data/repositories/item_repository_impl.dart';
import '../../../../models/item_model.dart';

class ViewController extends GetxController {
  RxBool isAddToCart = false.obs;
  final SaveItem _saveItem =
      SaveItem(ItemRepositoryImpl(ItemLocalDataSource()));
  @override
  void onInit() {
    isAddToCart.value = false;
    super.onInit();
  }

  setIsAddToCart({required bool values}) {
    const Duration(seconds: 5);
    isAddToCart.value = values;
    update();
  }

  Future<void> addItem(ItemModel item, context) async {
    final success = await _saveItem.call(item);

    if (success) {
    
    } else {
      // Exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar item')),
      );
    }
  }
}
