import 'package:e_commarce_kk/models/product_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  /// Firebase reference → products node only
  final DatabaseReference _db =
  FirebaseDatabase.instance.ref("products");

  /// all products from firebase
  //RxList<ProductModel> allProducts = <ProductModel>[].obs;

  /// filtered list (UI shows this)
  RxList<ProductModel> products = <ProductModel>[].obs;

  /// selected category
  RxString selectedCategory = "".obs;

  /// loading state
  RxBool isLoading = true.obs;
  RxBool isProductLoaded = false.obs;

  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> homeProducts = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();

    super.onInit();
  }

  /// FETCH PRODUCTS FROM FIREBASE
  Future<void> fetchProducts() async {
    isLoading.value = true;

    final snapshot = await _db.get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      allProducts.value = data.entries.map((e) {
        return ProductModel.fromJson(
          Map<String, dynamic>.from(e.value),
        );
      }).toList();
      // print("SNAPSHOT VALUE:");
      // print(snapshot.value);
      /// show only selected home products
      homeProducts.value = allProducts
          .where((p) => p.homepage == true && p.active == true)
          .toList();
    }
    isProductLoaded.value = true;
    print("SNAPSHOT VALUE:");
    print(snapshot.value);
    isLoading.value = false;

  }






  /// SEARCH
  void search(String value) {
    if (value.isEmpty) {
      filterCategory(selectedCategory.value);
      return;
    }

    products.value = allProducts
        .where((p) =>
        p.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  /// CATEGORY FILTER
  void filterCategory(String category) {
    filteredProducts.value =
        allProducts.where((p) => p.category == category).toList();
  }
}