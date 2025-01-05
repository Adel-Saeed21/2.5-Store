import 'package:storeapp/helper/API.dart';

class AllGategories {
  Future<List<dynamic>> getAllcategories() async {
    List<dynamic> data =
        await Api().get(URl: 'https://fakestoreapi.com/products/categories', token: '');

    return data;
  }
}
