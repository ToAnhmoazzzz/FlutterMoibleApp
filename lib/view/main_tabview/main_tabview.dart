import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_groceries/view/home/home_view.dart';

import '../../common/color_extension.dart';
import '../../view_model/favourite_view_model.dart';
import '../account/account_view.dart';
import '../explore/explore_view.dart';
import '../favourite/favourite_view.dart';
import '../my_cart/my_cart_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectedIndex = 0;
  final favVM = Get.put(FavoriteViewModel());

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    controller = TabController(length: 5, vsync: this);
    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });
      if (selectedIndex == 3) {
        favVM.serviceCalList();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: const [
          HomeView(),
          ExploreView(),
          MyCartView(),
          FavoritesView(),
          AccountView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            controller.animateTo(index);
          });
        },
        backgroundColor: Colors.white,
        elevation: 3,
        selectedItemColor: TColor.primary,
        unselectedItemColor: TColor.primaryText,
        items: [
          _buildNavBarItem(
            icon: 'assets/img/store_tab.png',
            label: 'Cửa hàng',
          ),
          _buildNavBarItem(
            icon: 'assets/img/explore_tab.png',
            label: 'Tìm kiếm',
          ),
          _buildNavBarItem(
            icon: 'assets/img/cart_tab.png',
            label: 'Giỏ hàng',
          ),
          _buildNavBarItem(
            icon: 'assets/img/fav_tab.png',
            label: 'Yêu thích',
          ),
          _buildNavBarItem(
            icon: 'assets/img/account_tab.png',
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({required String icon, required String label}) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(icon),
        color: TColor.primaryText,
      ),
      label: label,
      activeIcon: ImageIcon(
        AssetImage(icon),
        color: TColor.primary,
      ),
    );
  }
}
