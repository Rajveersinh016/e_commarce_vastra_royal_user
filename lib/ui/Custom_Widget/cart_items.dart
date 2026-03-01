import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [

          // ✅ PRODUCT IMAGE
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: image.isEmpty
                    ? const AssetImage(
                    "lib/assets/images/Man.png")
                    : NetworkImage(image)
                as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ✅ DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Icon(Icons.close,
                        color: Colors.grey),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.grey),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    // ✅ Quantity Controls
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6),
                      decoration: BoxDecoration(
                        color:
                        Colors.grey.shade200,
                        borderRadius:
                        BorderRadius.circular(
                            10),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onRemove,
                            child: const Icon(
                                Icons.remove,
                                size: 18),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            qty.toString(),
                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: onAdd,
                            child: const Icon(
                                Icons.add,
                                size: 18),
                          ),
                        ],
                      ),
                    ),

                    // ✅ Price
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}