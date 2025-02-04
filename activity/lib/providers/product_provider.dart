// ignore_for_file: unused_import

import 'package:activity/data.dart';
import 'package:activity/models/event_load_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:activity/models/product_model.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final Data _dataService = Data();
  List<EventLoadModel> _products = [];

  List<EventLoadModel> get products => _products;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _products = await _dataService.allProducts();
    notifyListeners();
  }

  EventLoadModel? findByProId(String productId) {
    if (products
        .where((element) => element.id.toString() == productId)
        .isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.id.toString() == productId);
  }

  List<EventLoadModel> findByDate({required String dateName}) {
    List<EventLoadModel> adList = products
        .where((element) => element.date.toLowerCase().contains(
              dateName.toLowerCase(),
            ))
        .toList();
    return adList;
  }

  List<EventLoadModel> searchQuery(
      {required String searchText, required List<EventLoadModel> passedList}) {
    List<EventLoadModel> searchList = passedList
        .where((element) => element.name.toLowerCase().contains(
              searchText.toLowerCase(),
            ))
        .toList();
    return searchList;
  }

  // List<EventLoadModel> products = [
  //   EventLoadModel(
  //     //1
  //     productId: 'voleybol 3',
  //     productTitle: "Voleybol Hadiii",
  //     productPrice: "500",
  //     productDate: "20.11.2023",
  //     productSaat: "13.25",
  //     productDescription:
  //         "Atletizmin heyecanla buluştuğu heyecan dolu bir voleybol turnuvasına hazır olun. Hızlı tempolu maçlar ve nefes kesen anlarla dolu bu etkinlik, unutulmaz bir deneyim vaat ediyor. Seyirciler, olağanüstü yetenekler ve muhteşem takım çalışmasıyla büyülenecekler. Kaçırmayın – bu turnuvada yerinizi alın ve heyecanın bir parçası olun!",
  //     productImage: AssetsManager.voleybol3,
  //     productQuantity: "10",
  //   ),
  //   EventLoadModel(
  //     //2
  //     productId: 'soylesi 2',
  //     productTitle: "Söyleşimize Hoşgeldiniz",
  //     productPrice: "654",
  //     productDate: "02.11.2028",
  //     productSaat: "13:25",
  //     productDescription:
  //         "Karşınızda, güçlü bir yazılım deneyimi sunan Samsung Galaxy S22 Ultra! Dinamik AMOLED 6.8 inç ekranıyla dikkat çekiyor. 108MP kamerasıyla her anı yakalayın. En son Exynos işlemcisinin gücünden ve devasa 5000mAh bataryasından faydalanın. Zarif Phantom Black tasarımı, mobil deneyiminize zarafet katıyor.",
  //     productImage: AssetsManager.soylesi3,
  //     productQuantity: "15",
  //   ),
  //   EventLoadModel(
  //     //3
  //     productId: 'basketbol 1',
  //     productTitle: "Basketbol Turnuvası 1",
  //     productPrice: "150",
  //     productDate: "20.11.2025",
  //     productSaat: "13:25",
  //     productDescription:
  //         "Elit sporcuların buluştuğu, heyecan dolu bir basketbol turnuvasına hazır olun. Hızlı tempolu oyunlar ve nefes kesen anlar ile dolu bu etkinlik, unutulmaz bir deneyim sunacak. Seyirciler, olağanüstü yetenekler ve muhteşem takım çalışması ile büyülenecekler. Kaçırmayın, bu turnuvada yerinizi alın ve heyecana ortak olun!",
  //     productImage: AssetsManager.basketbol2,
  //     productQuantity: "8",
  //   ),
  //   EventLoadModel(
  //     //4
  //     productId: 'futbol 1',
  //     productTitle: "Futbol Maçları 2",
  //     productPrice: "300",
  //     productDate: "22.05.2024",
  //     productSaat: "15:20",
  //     productDescription:
  //         "Futbol tutkunları, müthiş bir maç sizleri bekliyor. Üst düzey performans ve heyecan dolu anlar, bu karşılaşmada bir araya gelecek. Harika bir atmosferde, unutulmaz bir deneyim yaşayın. Büyük çekişmeye sahne olacak bu mücadelede, takımınızı destekleyerek heyecana ortak olun!",
  //     productImage: AssetsManager.futbol2,
  //     productQuantity: "20",
  //   ),
  //   EventLoadModel(
  //     //5
  //     productId: 'söyleşi 1',
  //     productTitle: "Söyleşi 2",
  //     productPrice: "0",
  //     productDate: "21.06.2024",
  //     productSaat: "13.25",
  //     productDescription:
  //         "Futbol tutkunları, müthiş bir maç sizleri bekliyor. Üst düzey performans ve heyecan dolu anlar, bu karşılaşmada bir araya gelecek. Harika bir atmosferde, unutulmaz bir deneyim yaşayın. Büyük çekişmeye sahne olacak bu mücadelede, takımınızı destekleyerek heyecana ortak olun!",
  //     productImage: "AssetsManager.soylesi2",
  //     productQuantity: "12",
  //   ),
  //   EventLoadModel(
  //     //7
  //     productId: 'voleybol 1',
  //     productTitle: "Voleybol Turnuvası",
  //     productPrice: "122",
  //     productDate: "20.11.2024",
  //     productSaat: "10:15",
  //     productDescription:
  //         "Transform your entertainment experience with the LG 4K Ultra HD Smart TV. Enjoy lifelike picture quality on the 65-inch display. Smart TV features allow you to access your favorite streaming services with ease. ThinQ AI technology enhances your viewing experience.",
  //     productImage: AssetsManager.voleybol2,
  //     productQuantity: "5",
  //   ),
  //   EventLoadModel(
  //     //8
  //     productId: 'gezi 3',
  //     productTitle: "Gezi Turu",
  //     productPrice: "1500",
  //     productDate: "20.07.2024",
  //     productSaat: "13.25",
  //     productDescription:
  //         "Yeni rotalar keşfetmek ve unutulmaz anılar biriktirmek için düzenlediğimiz gezi turuna katılın. Kalp atışlarınızı hızlandıracak doğal güzellikler ve tarihi mekanlar ile dolu bu tur, macera dolu bir deneyim sunuyor. Her adımda karşınıza çıkacak olan benzersiz manzaralar, sizlere gerçek zamanlı olarak tur rehberlerimiz tarafından anlatılacak. Keşfetmenin keyfini çıkarırken, rehberlerimiz sayesinde gittiğiniz her yer hakkında derinlemesine bilgi sahibi olacaksınız. Bu eşsiz gezi turunda yerinizi alın ve yolculuğun tadını çıkarın!",
  //     productImage: AssetsManager.gezi3,
  //     productQuantity: "18",
  //   ),
  //   EventLoadModel(
  //     //9
  //     productId: 'konser 2',
  //     productTitle: "Konser .!.!",
  //     productPrice: "300",
  //     productDate: "20.11.2024",
  //     productSaat: "19:45",
  //     productDescription:
  //         "Yaratıcılığınızı serbest bırakacağınız büyüleyici bir konser deneyimine hazır olun! Ünlü sanatçıların sahne alacağı bu özel etkinlikte, her notanın ve ritmin tadını çıkaracaksınız. Yüksek çözünürlüklü ses sistemleri ile müziğin en saf halini yaşayacak, ışık gösterileri ve sahne performansları ile unutulmaz anlara tanık olacaksınız. Kusursuz akustiği ve muhteşem atmosferi ile bu konser, müzik tutkunları için kaçırılmayacak bir fırsat. Sanatçıların en sevilen şarkılarını canlı dinlemek ve müziğin büyüsüne kapılmak için yerinizi ayırtın!",
  //     productImage: "AssetsManager.konser3",
  //     productQuantity: "7",
  //   ),
  //   EventLoadModel(
  //     //10
  //     productId: 'konser 1',
  //     productTitle: "Konser .!.!",
  //     productPrice: "300",
  //     productDate: "20.11.2024",
  //     productSaat: "19:45",
  //     productDescription:
  //         "Yaratıcılığınızı serbest bırakacağınız büyüleyici bir konser deneyimine hazır olun! Ünlü sanatçıların sahne alacağı bu özel etkinlikte, her notanın ve ritmin tadını çıkaracaksınız. Yüksek çözünürlüklü ses sistemleri ile müziğin en saf halini yaşayacak, ışık gösterileri ve sahne performansları ile unutulmaz anlara tanık olacaksınız. Kusursuz akustiği ve muhteşem atmosferi ile bu konser, müzik tutkunları için kaçırılmayacak bir fırsat. Sanatçıların en sevilen şarkılarını canlı dinlemek ve müziğin büyüsüne kapılmak için yerinizi ayırtın!",
  //     productImage: AssetsManager.konser,
  //     productQuantity: "7",
  //   ),
  // ];
}
