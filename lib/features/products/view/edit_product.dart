import 'package:flutter/material.dart';
import 'package:our_market_admin/core/components/cache_image.dart';
import 'package:our_market_admin/core/components/custom_elevated_button.dart';
import 'package:our_market_admin/core/components/custom_text_field.dart';
import 'package:our_market_admin/core/functions/build_custom_app_bar.dart';
import 'package:our_market_admin/core/shared_pref.dart';
import 'package:our_market_admin/features/products/models/product_model.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.product});
  final ProductModel product;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  String? selectedValue;
  String? sale;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _newPriceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

      @override
  void initState() {
    // selectedValue = widget.product.category;
    sale = widget.product.sale.toString();
    _productNameController.text = widget.product.productName ?? "";
    _newPriceController.text = widget.product.price.toString(); 
    _oldPriceController.text = widget.product.oldPrice.toString();
    _productDescriptionController.text = widget.product.description ?? "";

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildCustomAppBar(context, "Edit Product"),
      body: Padding(
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
                  initialSelection: widget.product.category, // "collections",
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "sports", label: "Sports"),
                    DropdownMenuEntry(
                        value: "electronics", label: "Electronics"),
                    DropdownMenuEntry(
                        value: "collections", label: "Collections"),
                    DropdownMenuEntry(value: "books", label: "Books"),
                    DropdownMenuEntry(value: "bikes", label: "Bikes"),
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
                      "$sale %",
                    ),
                  ],
                ),
                Column(
                  children: [
                     CaheImage(
                      url:
                        widget.product.imageUrl ??  "https://img.freepik.com/free-photo/sale-with-special-discount-vr-glasses_23-2150040380.jpg?t=st=1736199951~exp=1736203551~hmac=4002ca903018a0edb3f886536eb961659f89a39eb31ee90a093c352ac11e5912&w=826",
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
                          onPressed: () {},
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
                    child: Text("Update"),
                  ),
                  onPressed: () async {
                    String? token = await SharedPref.getToken();
                    print("Token:====> $token");
                  }),
            ),
          ],
        ),
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
