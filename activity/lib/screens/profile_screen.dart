// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:activity/providers/theme_provider.dart';
import 'package:activity/screens/init_screen/wishlist.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:activity/services/myapp_functions.dart';
import 'package:activity/widgets/app_name_text.dart';
import 'package:activity/widgets/ayarlar/ayarlar_screen.dart';
import 'package:activity/widgets/order/order_screen.dart';
import 'package:activity/widgets/subtitle.dart';
import 'package:activity/widgets/title_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR ------------------->
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        title: const AppNameTextWidget(fontSize: 20),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kullanıcı Giriş Uyarısı
          const Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TitleTextWidget(label: "label"),
              )),
          Visibility(
              visible: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.background,
                              width: 3),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AssetsManager.profile3,
                            fit: BoxFit.fill,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TitleTextWidget(label: "Mehmet Emin CİHAN"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TitleTextWidget(label: "Information"),
                const SizedBox(
                  height: 10,
                ),
                CustomListTile(
                    imagePath: AssetsManager.card,
                    text: "Tüm Etkinliklerim",
                    function: () {
                      Navigator.pushNamed(context, OrderScreen.routName);
                    }),
                CustomListTile(
                    imagePath: AssetsManager.favori,
                    text: "Favori",
                    function: () {
                      Navigator.pushNamed(context, WishlistScreen.routName);
                    }),
                const Divider(
                  thickness: 1,
                ),
                CustomListTile(
                    imagePath: AssetsManager.ayarlar,
                    text: "Ayarlar",
                    function: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Ayarlar()));
                    }),
                const SizedBox(height: 10),
              ],
            ),
          ),

          Center(
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                onPressed: () async {
                  await MyAppFunctions.showErrorOrWaningDialog(
                      context: context,
                      subtitle: "are you sure ? ",
                      fct: () {},
                      isError: false);
                },
                icon: const Icon(Icons.login),
                label: const Text("Logout")),
          )
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubTitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(CupertinoIcons.chevron_right),
    );
  }
}
