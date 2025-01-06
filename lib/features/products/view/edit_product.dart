import 'package:flutter/material.dart';
import 'package:our_market_admin/core/components/cache_image.dart';
import 'package:our_market_admin/core/components/custom_elevated_button.dart';
import 'package:our_market_admin/core/components/custom_text_field.dart';
import 'package:our_market_admin/core/functions/build_custom_app_bar.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

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
                const Column(
                  // TODO : Category dropdown
                  children: [
                    Text(
                      "Sale",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "10 %",
                    ),
                  ],
                ),
                Column(
                  children: [
                    const CaheImage(
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
            const CustomField(labelText: "Product Name"),
            const SizedBox(
              height: 10,
            ),
            const CustomField(labelText: "New Price"), // 70
            const SizedBox(
              height: 10,
            ),
            const CustomField(labelText: "Old Price"), // 249
            const SizedBox(
              height: 10,
            ),

            const CustomField(labelText: "Product Description"),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(child: const Text("Update"), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
