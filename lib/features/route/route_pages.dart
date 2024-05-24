import 'package:get/get.dart';
import 'package:restaurant_app/features/detail/bindings/detail_bindings.dart';
import 'package:restaurant_app/features/detail/screen/detail_screen.dart';
import 'package:restaurant_app/features/home/category/screen/cake_screen.dart';
import 'package:restaurant_app/features/home/category/screen/coffee_screen.dart';
import 'package:restaurant_app/features/home/category/screen/drink_screen.dart';
import 'package:restaurant_app/features/home/category/screen/juice_screen.dart';
import 'package:restaurant_app/features/main/bindings/main_binding.dart';
import 'package:restaurant_app/features/main/screen/main_screen.dart';
import 'package:restaurant_app/features/models/product_model.dart';
import 'package:restaurant_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:restaurant_app/features/order/screen/order_screen.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:restaurant_app/features/search/binding/search_binding.dart';
import 'package:restaurant_app/features/search/screen/search_screen.dart';
import 'package:restaurant_app/features/sign_in/screen/sign_in_screen.dart';
import 'package:restaurant_app/features/sign_up/screen/sign_up_screen.dart';
import 'package:restaurant_app/features/splash/binding/splash_binding.dart';
import 'package:restaurant_app/features/splash/splash_screen.dart';

class RoutePages {
  List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteName.onboardingScreen,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: RouteName.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: RouteName.signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: RouteName.mainScreen,
      page: () => MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RouteName.detailScreen,
      binding: DetailBinding(),
      page: () {
        return DetailScreen();
      },
    ),
    GetPage(
      name: RouteName.orderScreen,
      page: () {
        ProductModel productData = ProductModel(
            price: '0',
            productId: '',
            productImage: '',
            productName: '',
            productDescription: '',
            productType: ProductType.other);
        int totalPrice = 0;
        int totalItem = 1;
        if (Get.arguments != null && Get.arguments is Map) {
          final Map<String, dynamic> args = Get.arguments;
          if (args.containsKey('data')) {
            productData = ProductModel.fromJson(args['data']);
          }

          if (args.containsKey('totalPrice')) {
            totalPrice = args['totalPrice'];
          }
          if (args.containsKey('totalItem')) {
            totalItem = args['totalItem'];
          }
        }
        return OrderScreen(
          productModel: productData,
          totalItem: totalItem,
          totalPrice: totalPrice,
        );
      },
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteName.coffeeScreen,
      page: () => CoffeeScreen(),
    ),
    GetPage(
      name: RouteName.drinkScreen,
      page: () => DrinkScreen(),
    ),
    GetPage(
      name: RouteName.juiceScreen,
      page: () => JuiceScreen(),
    ),
    GetPage(
      name: RouteName.cakeScreen,
      page: () => CakeScreen(),
    ),
    GetPage(
      name: RouteName.searchScreen,
      page: () => SearchScreen(),
      binding: SearchBinding(),
    ),
  ];
}
