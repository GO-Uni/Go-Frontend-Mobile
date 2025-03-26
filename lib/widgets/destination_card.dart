import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/text_styles.dart';
import '../services/routes.dart';

class DestinationCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double rating;
  final bool? isBooked;
  final String? district;
  final int? userid;

  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    this.isBooked,
    this.district,
    this.userid,
  });

  @override
  DestinationCardState createState() => DestinationCardState();
}

class DestinationCardState extends State<DestinationCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    String truncatedDescription =
        widget.description.length > 50
            ? '${widget.description.substring(0, 50)}...'
            : widget.description;

    return GestureDetector(
      onTap: () {
        context.go(
          ConfigRoutes.detailedDestination,
          extra: {
            "imageUrl": widget.imageUrl,
            "name": widget.name,
            "description": widget.description,
            "rating": widget.rating,
            "district": widget.district,
            "userid": widget.userid,
          },
        );
      },
      child: Container(
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
                        truncatedDescription,
                        style: AppTextStyles.bodyMedium.copyWith(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
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
                right: 16,
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
                right: 16,
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
      ),
    );
  }
}
