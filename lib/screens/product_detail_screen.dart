import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop/models/color_from_name.dart';
import 'package:shop/widgets/product_details_text.dart';
import '../models/product.dart';
import '../controllers/home_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({super.key, required this.product});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final color = colorFromName(product.colour);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Obx(() {
                    final isFav = controller.isFavourite(product.id);
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.star : Icons.star_border,
                        color: isFav ? Colors.red[700] : Colors.grey,
                      ),
                      onPressed: () {
                        controller.toggleFavourite(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFav
                                  ? 'Removed from favourites'
                                  : 'Added to favourites',
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child:
                          product.category?.icon != null &&
                              product.category!.icon.isNotEmpty
                          ? Image.network(
                              product.category!.icon,
                              height: 100.h,
                              width: 100.w,
                            )
                          : Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50.sp,
                              ),
                            ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Size', style: TextStyle(fontSize: 14.sp)),
                              const Spacer(),
                              Expanded(
                                child: Text(
                                  product.size.isNotEmpty
                                      ? product.size
                                            .toLowerCase()
                                            .replaceAll(RegExp('size'), '')
                                            .trim()
                                      : '',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 38.w),
                        Expanded(
                          child: Row(
                            children: [
                              Text('Colour', style: TextStyle(fontSize: 14.sp)),
                              const Spacer(),
                              if (color != null)
                                SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  product.colour.isNotEmpty
                                      ? product.colour
                                      : '',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ProductDetailsText(details: product.details),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRICE',
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SF Pro Text',
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(146.w, 52.h),
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                      },
                      child: Text('ADD', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
