import 'package:activity/models/event_load_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:activity/constans/app_constans.dart';
import 'package:activity/providers/theme_provider.dart';
// import 'package:activity/models/product_model.dart';
import 'package:activity/widgets/app_name_text.dart';
import 'package:activity/widgets/products/product_widget.dart';
import 'package:activity/widgets/title_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Dio dio = Dio();
  final String baseUrl = 'http://localhost:5068';
  late Future<List<EventLoadModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = allProducts();
    print(_productsFuture);
  }

  Future<List<EventLoadModel>> allProducts() async {
    try {
      Response response = await dio.get('$baseUrl/api/Etkinlik/GetAll');
      print(response.data.toString()); // API yanıtını konsola yazdırın
      List<dynamic> data = response.data as List<dynamic>;
      List<EventLoadModel> products = data.map((json) {
        final productJson = json as Map<String, dynamic>;
        print(productJson.toString()); // JSON'ı konsola yazdırın
        return EventLoadModel.fromJson(productJson);
      }).toList();
      return products;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Failed to load products",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        title: const AppNameTextWidget(fontSize: 20),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: size.height * 0.25,
                child: ClipRRect(
                  child: Swiper(
                    autoplay: true,
                    autoplayDelay: 3000,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstans.bannerImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: AppConstans.bannerImages.length,
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.red,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              const TitleTextWidget(label: "Tüm Etkinlikler"),
              const SizedBox(height: 15.0),
              SizedBox(
                height: size.height * 0.48,
                child: FutureBuilder<List<EventLoadModel>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No products found"));
                    } else {
                      List<EventLoadModel> products = snapshot.data!;
                      return DynamicHeightGridView(
                        mainAxisSpacing: 12,
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        itemCount: products.length,
                        builder: (context, index) {
                          final product = products[index];
                          return ProductWidget(
                            productId: product.id
                                .toString(), // `null` değilse kullanılacak
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
