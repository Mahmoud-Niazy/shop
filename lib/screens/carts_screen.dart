import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_final/constants/constants.dart';
import 'package:shop_final/data_models/carts_data_model.dart';
import 'package:shop_final/reusable_components/reusable_components.dart';
import 'package:shop_final/shop_cubit/shop_states.dart';

import '../shop_cubit/shop_cubit.dart';

class CartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        print(state);
        if (state is UploadOrderSuccessfullyState) {
          Fluttertoast.showToast(
            msg: 'Your order uploaded successfully',
            backgroundColor: Colors.green,
          ).then((value) {
            ShopCubit.get(context).DeleteCarts();
          });
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).cartsData != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CartItem(
                      ShopCubit.get(context)
                          .cartsData!
                          .data!
                          .cart_items[index]
                          .product,
                      context,
                    ),
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    itemCount: ShopCubit.get(context)
                        .cartsData!
                        .data!
                        .cart_items
                        .length,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Center(
                      child: Text(
                        '${enLan? "TotalPrice :"  : 'السعر الكلي '} ' + ' ${ShopCubit.get(context).cartsData!.data!.total}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BuildButton(
                    labelEn: 'Order',
                    labelAr: 'اطلب',
                    onPressed: () {
                      // if(ShopCubit.get(context).cartsData!.data!.cart_items.length >0)
                      // ShopCubit.get(context).Order();
                    },
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

CartItem(CartsDataProduct item, context) {
  return Container(
    height: 200,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            CachedNetworkImage(
              imageUrl: item.image,
              width: 200,
              height: 200,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error_outline_outlined),
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
              ),
            ),
            if (item.discount != 0)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "${item.price}",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (item.discount != 0)
                    Text(
                      '${item.oldPrice}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).AddOrRemoveInCart(pId: item.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
