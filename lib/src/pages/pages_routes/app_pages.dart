import 'package:get/get.dart';
import 'package:wey_commerce_app/src/pages/favorites/favorites_page.dart';
import '../../../core/routes/routes_name.dart';
import '../home/view/home_tab.dart';

abstract class AppPages {
  static final page = <GetPage>[
    GetPage(
      name: '/favorites',
      page: () =>  FavoritesPage (),
    ),
  
    GetPage(
      name: '/hometab',
      page: () => const HomeTab(),
    ),
  ];
}
