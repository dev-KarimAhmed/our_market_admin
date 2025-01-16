import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market_admin/core/components/cache_image.dart';
import 'package:our_market_admin/core/components/custom_circle_indicator.dart';
import 'package:our_market_admin/core/components/custom_elevated_button.dart';
import 'package:our_market_admin/core/components/custom_product_card.dart';
import 'package:our_market_admin/core/functions/build_custom_app_bar.dart';
import 'package:our_market_admin/features/products/cubit/cubit/products_cubit.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(),
      child: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          ProductsCubit cubit = context.read<ProductsCubit>();

          return Scaffold(
            appBar: buildCustomAppBar(context, "Products"),
            body: state is GetProductsLoading
                ? const CustomCircleProgIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                           CustomProductCard(
                            product: cubit.products[index],
                           ),
                      itemCount: cubit.products.length,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

// admin123@gmail.com
// aA12345