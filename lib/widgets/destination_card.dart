import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class DestinationCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final int rating;

  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyLarge.copyWith(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                ),
                SizedBox(height: 5),

                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: index < rating ? Colors.amber : Colors.grey,
                          size: 20,
                        );
                      }),
                    ),
                    Spacer(),

                    Icon(Icons.bookmark_border, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
