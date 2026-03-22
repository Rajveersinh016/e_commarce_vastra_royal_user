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
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double finalPrice = widget.price - widget.discount;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE (Flexible)
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image(
                        fit: BoxFit.fill,
                        image: widget.image.isEmpty
                            ? const AssetImage("lib/assets/images/Man.png")
                            : NetworkImage(widget.image) as ImageProvider,
                      ),
                    ),
                  ),

                  /// FAVORITE
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });

                          final item = WishlistModel(
                            id: widget.title,
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
                          size: 18,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// DETAILS (Flexible safe area)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    widget.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        "₹${finalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 4),

                      if (widget.discount > 0)
                        Flexible(
                          child: Text(
                            "₹${widget.price.toStringAsFixed(0)}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),

                  if (widget.discount > 0)
                    Text(
                      "${((widget.discount / widget.price) * 100).toStringAsFixed(0)}% OFF",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
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