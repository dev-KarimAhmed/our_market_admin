import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market_admin/core/components/cache_image.dart';
import 'package:our_market_admin/core/components/custom_circle_indicator.dart';
import 'package:our_market_admin/core/components/custom_elevated_button.dart';
import 'package:our_market_admin/core/components/custom_text_field.dart';
import 'package:our_market_admin/core/functions/build_custom_app_bar.dart';
import 'package:our_market_admin/core/functions/navigate_without_back.dart';
import 'package:our_market_admin/core/functions/pick_image.dart';
import 'package:our_market_admin/core/functions/show_msg.dart';
import 'package:our_market_admin/features/home/views/home_view.dart';
import 'package:our_market_admin/features/products/cubit/cubit/products_cubit.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}


class _AddProductViewState extends State<AddProductView> {
  String selectedValue = "Collections";
  String discount = "10";
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _newPriceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
       Uint8List? _selectedImage;
  String _imageName = "imageName";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            showMsg(context, "Product added successfully");
            navigateWithoutBack(context, const HomeView());
          }
        },
        builder: (context, state) {
          ProductsCubit cubit = context.read<ProductsCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(context, "Add Product"),
            body: state is AddProductLoading ? const CustomCircleProgIndicator() : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownMenu(
                        onSelected: (String? value) {
                          setState(() {
                            selectedValue = value ?? "Collections";
                          });
                        },
                        initialSelection: selectedValue,
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: "Sports", label: "Sports"),
                          DropdownMenuEntry(
                              value: "Electronics", label: "Electronics"),
                          DropdownMenuEntry(
                              value: "Collections", label: "Collections"),
                          DropdownMenuEntry(value: "Books", label: "Books"),
                          DropdownMenuEntry(value: "Bikes", label: "Bikes"),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Sale",
                          ),
                          Text(
                            "$discount %",
                          ),
                        ],
                      ),
                      Column(
                        children: [
                        _selectedImage != null
                ? Image.memory(
                    _selectedImage!,
                    height: 200,
                    width: 300,
                  )
                :  const CaheImage(
                            url:
                                "https://img.freepik.com/free-photo/sale-with-special-discount-vr-glasses_23-2150040380.jpg?t=st=1736199951~exp=1736203551~hmac=4002ca903018a0edb3f886536eb961659f89a39eb31ee90a093c352ac11e5912&w=826",
                            height: 200,
                            width: 300,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomElevatedButton(
                                child: const Icon(Icons.image),
                                onPressed: () async {
                                  await pickImage().then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _imageName = value.files.first.name;
                                        Uint8List? bytes =
                                            value.files.first.bytes;
                                        _selectedImage = bytes;
                                      });
                                    }
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomElevatedButton(
                                child: const Icon(
                                  Icons.upload_file_rounded,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomField(
                    labelText: "Product Name",
                    controller: _productNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomField(
                    labelText: "New Price",
                    controller: _newPriceController,
                  ), // 70
                  const SizedBox(
                    height: 10,
                  ),
                  CustomField(
                    labelText: "Old Price",
                    controller: _oldPriceController,
                  ), // 249
                  const SizedBox(
                    height: 10,
                  ),

                  CustomField(
                    labelText: "Product Description",
                    controller: _productDescriptionController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Add"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _newPriceController.dispose();
    _oldPriceController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }
}
