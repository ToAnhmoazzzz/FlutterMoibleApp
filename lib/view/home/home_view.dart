import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries/model/offer_product_model.dart';
import 'package:online_groceries/view/home/product_details_view.dart';
import 'package:video_player/video_player.dart';

import '../../common/color_extension.dart';
import '../../common_widget/category_cell.dart';
import '../../common_widget/product_cell.dart';
import '../../common_widget/section_view.dart';
import '../../view_model/cart_view_model.dart';
import '../../view_model/home_view_model.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtSearch = TextEditingController();

  final homeVM = Get.put(HomeViewModel());
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      "assets/img/giphy.gif",
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    Get.delete<HomeViewModel>();
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/iconff.png",
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "TP.HCM, Việt Nam",
                    style: TextStyle(
                        color: TColor.darkGray,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F3F2),
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Image.asset(
                          "assets/img/search.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Tìm kiếm",
                      hintStyle: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
                    Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(115, 242, 243, 242),
                        borderRadius: BorderRadius.circular(50)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/img/baner.png",
                      
                    )),
              ),
              SectionView(
                title: "Ưu đãi",
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {},
              ),
              SizedBox(
                height: 230,
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: homeVM.offerArr.length,
                      itemBuilder: (context, index) {
                        var pObj = homeVM.offerArr[index] ;

                        return ProductCell(
                          pObj: pObj,
                          onPressed: () async {
                            await Get.to(() => ProductDetails(
                                  pObj: pObj,
                                ));

                            homeVM.serviceCallHome();
                          },
                          onCart: () {
                            CartViewModel.serviceCallAddToCart( pObj.prodId ?? 0  , 1, () {

                             });
                          },
                        );
                      }),
                ),
              ),
               const SizedBox(
                height: 30,
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: double.maxFinite,
                    height: 200,
                    decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/img/baba.png",
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              SectionView(
                title: "Sản phẩm bán chạy",
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {},
              ),
              SizedBox(
                height: 230,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: homeVM.bestSellingArr.length,
                    itemBuilder: (context, index) {
                      var pObj = homeVM.bestSellingArr[index];

                      return ProductCell(
                        pObj: pObj,
                        onPressed: () async {
                          await  Get.to(() => ProductDetails(
                                  pObj: pObj,
                                ));

                          homeVM.serviceCallHome();
                        },
                        onCart: () {
                          CartViewModel.serviceCallAddToCart(
                                pObj.prodId ?? 0, 1, () {});
                        },
                      );
                    }),),
              ),
               const SizedBox(
                height: 30,
              ),
              Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      color: Color.fromARGB(115, 242, 243, 242),
      borderRadius: BorderRadius.circular(50),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(
        "assets/img/giphy.gif",
        fit: BoxFit.cover, // Để hình ảnh tràn viền
      ),
    ),
  ),
),

              SectionView(
                title: "Sản phẩm",
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {},
              ),
              SizedBox(
                height: 100,
                child: Obx(
                  () =>  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: homeVM.groceriesArr.length,
                    itemBuilder: (context, index) {
                      var pObj = homeVM.groceriesArr[index];

                      return CategoryCell(
                        pObj: pObj,
                        onPressed: () {},
                      );
                    }),),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 230,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: homeVM.listArr.length,
                    itemBuilder: (context, index) {
                      var pObj = homeVM.listArr[index] ;

                      return ProductCell(
                        pObj: pObj,
                        onPressed: () async {
                            await Get.to(() => ProductDetails(
                                  pObj: pObj,
                                ));

                            homeVM.serviceCallHome();
                          },
                        onCart: () {
                          CartViewModel.serviceCallAddToCart(
                                pObj.prodId ?? 0, 1, () {});
                        },
                      );
                    }),),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
