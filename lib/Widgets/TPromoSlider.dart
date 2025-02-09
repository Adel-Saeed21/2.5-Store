// ignore_for_file: file_names

// ignore: unnecessary_import
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/Widgets/SmallContainer.dart';
import 'package:storeapp/Widgets/promoContainer.dart';
import 'package:storeapp/data/Images.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/helper/HomeCotroller.dart';

class TPromoSLider extends StatelessWidget {
  const TPromoSLider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Homecotroller());
    return Column(
      children: [
        CarouselSlider(
          items: const [
            PromoContainer(
              imageUrl: Imagee.promoImage1,
              borderRediuss: 20,
              isNetworkImage: false,
              background: Colors.white,
              applyImage: false,
              fit: BoxFit.cover,
            ),
            PromoContainer(
              imageUrl: Imagee.promoImage2,
              borderRediuss: 20,
              isNetworkImage: false,
              background: Colors.white,
              applyImage: false,
              fit: BoxFit.cover,
            ),
            PromoContainer(
              imageUrl: Imagee.promoImage3,
              borderRediuss: 20,
              isNetworkImage: false,
              background: Colors.white,
              applyImage: false,
              fit: BoxFit.cover,
            ),
          ],
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, reason) => controller.updatePageIndex(index),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                SmallContainerHome(
                  padding: 5,
                  // ignore: unrelated_type_equality_checks
                  color: controller.currentIndex == i
                      ? textIconColor
                      : Colors.grey,
                )
            ],
          ),
        ),
      ],
    );
  }
}





//