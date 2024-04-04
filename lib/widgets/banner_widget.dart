import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_shop/controllers/banners_controllers.dart';
import 'package:seller_shop/utils/app_constant.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final BannersControllers _bannersControllers = Get.put(BannersControllers());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return CarouselSlider(
            items: _bannersControllers.bannerUrls
                .map(
                  (imageUrls) => ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls,
                      fit: BoxFit.cover,
                      width: Get.width - 10,
                      placeholder: (context, url) => const ColoredBox(
                        color: Colors.white,
                      ),
                      errorWidget: (context,url,error) => const Icon(Icons.error,color: AppConstant.appPrimaryColor,) ,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              aspectRatio: 2.5,
              viewportFraction: 1
            ));
      }),
    );
  }
}
