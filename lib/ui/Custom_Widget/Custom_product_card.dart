import 'package:e_commarce_kk/Controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/wishlist_model.dart';

class CustomProductCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final double price;
  final double discount;
  final VoidCallback onTap;

  const CustomProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.discount,
    required this.onTap,
  });

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();


}
   final wishlistController = Get.find<WishlistController>();

class _CustomProductCardState extends State<CustomProductCard> {

 // final WishlistController wishlistController = Get.find<WishlistController()>;

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: Get.width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: Get.width*0.45,
              height: 180,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: Offset(0, 6),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: widget.image.isEmpty
                      ? const AssetImage("lib/assets/images/Man.png")
                      : NetworkImage(widget.image) as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {

                        setState(() {
                          isFavorite = !isFavorite;
                        });

                        final item = WishlistModel(
                          id: widget.title, // temporary unique id
                          name: widget.title,
                          price: widget.price,
                          discount: widget.discount,
                          image: widget.image,
                        );

                        if (isFavorite) {
                          wishlistController.addToWishlist(item);
                        } else {
                          wishlistController.removeFromWishlist(item.id);
                        }
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),

            Text(widget.subtitle,
                style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 2),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// FINAL PRICE
                Text(
                  "₹${(widget.price - widget.discount).toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(width: 8),

                /// OLD PRICE
                if (widget.discount > 0)
                  Text(
                    "₹${widget.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                const SizedBox(width: 6),

                /// DISCOUNT %
                if (widget.discount > 0)
                  Text(
                    "${((widget.discount / widget.price) * 100).toStringAsFixed(0)}% off",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
