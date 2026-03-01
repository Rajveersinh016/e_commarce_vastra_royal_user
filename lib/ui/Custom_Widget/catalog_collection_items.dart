import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionItem extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;

  const CollectionItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  State<CollectionItem> createState() => _CollectionItemState();
}

class _CollectionItemState extends State<CollectionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.40,
      width: Get.width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(widget.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              Colors.black.withOpacity(0.75),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
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
