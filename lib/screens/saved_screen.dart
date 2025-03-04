import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/destination_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> savedDestinations = [
      {
        "imageUrl":
            "https://images.pexels.com/photos/16414732/pexels-photo-16414732/free-photo-of-ancient-greek-ruin.jpeg?auto=compress&cs=tinysrgb&w=600",
        "name": "Baalbek Ruins",
        "description": "Ancient Roman temple",
        "rating": 4,
        "isBooked": true,
      },
      {
        "imageUrl":
            "https://images.pexels.com/photos/4632800/pexels-photo-4632800.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        "name": "Harissa",
        "description": "Beautiful mountain view",
        "rating": 5,
        "isBooked": true,
      },
      {
        "imageUrl":
            "https://images.pexels.com/photos/16414732/pexels-photo-16414732/free-photo-of-ancient-greek-ruin.jpeg?auto=compress&cs=tinysrgb&w=600",
        "name": "Baalbek Ruins",
        "description": "Ancient Roman temple",
        "rating": 4,
        "isBooked": false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 14, left: 10, right: 10),
              itemCount: savedDestinations.length,
              itemBuilder: (context, index) {
                final destination = savedDestinations[index];
                return Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: DestinationCard(
                    imageUrl: destination["imageUrl"],
                    name: destination["name"],
                    description: destination["description"],
                    rating: destination["rating"],
                    isBooked: destination["isBooked"],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
