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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [

          /// IMAGE
          Container(
            width: 90,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// RIGHT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITLE + DELETE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.close, color: Colors.grey)
                  ],
                ),

                const SizedBox(height: 4),

                Text(subtitle,
                    style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 12),

                /// QTY + PRICE
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    /// QTY BOX
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [

                          /// MINUS
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: onRemove,
                          ),

                          Text(
                            "$qty",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),

                          /// PLUS
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: onAdd,
                          ),
                        ],
                      ),
                    ),

                    /// PRICE
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
