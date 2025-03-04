import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class DestinationCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;
  final int rating;
  final bool? isBooked;

  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    this.isBooked,
  });

  @override
  DestinationCardState createState() => DestinationCardState();
}

class DestinationCardState extends State<DestinationCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  widget.imageUrl,
                  height: 105,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTextStyles.bodyLarge.copyWith(fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: AppTextStyles.bodyMedium.copyWith(fontSize: 11),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < widget.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color:
                                  index < widget.rating
                                      ? Colors.amber
                                      : Colors.grey,
                              size: 20,
                            );
                          }),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                          },
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked ? Colors.green : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (widget.isBooked == true)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "Booked",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

          if (widget.isBooked == false)
            Positioned(
              top: 8,
              right: 8,
              bottom: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "Book",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
