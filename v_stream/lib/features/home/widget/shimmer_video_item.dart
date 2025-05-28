import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVideoItem extends StatelessWidget {
  const ShimmerVideoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
              ),
              title: Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 10,
                margin: const EdgeInsets.only(top: 4),
                width: 100,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}