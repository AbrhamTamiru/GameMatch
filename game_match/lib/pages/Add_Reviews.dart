import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Submitted_Reviews.dart'; // Import the Submitted Reviews page

class AddReviewsPage extends StatefulWidget {
  final String gameId;

  const AddReviewsPage({super.key, required this.gameId});

  @override
  _AddReviewsPageState createState() => _AddReviewsPageState();
}

class _AddReviewsPageState extends State<AddReviewsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Firestore instance for database access
  final FirebaseAuth auth = FirebaseAuth.instance; // Firebase Authentication instance

  // Text controllers for review title and body input
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  double rating = 0.0; // Variable to store the rating value

  // Function to add a new review to Firestore
  Future<void> _addReview(String title, String body, double rating) async {
    User? user = auth.currentUser; // Get the current authenticated user
    if (user != null) {
      try {
        // Add a new review document to the Firestore 'reviews' collection
        await firestore.collection('reviews').add({
          'userId': user.uid, // Save the user ID associated with the review
          'gameId': widget.gameId, // Link the review to the game ID
          'title': title,
          'body': body,
          'rating': rating,
          'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
        });

        // Clear the text fields and reset the rating after submission
        titleController.clear();
        bodyController.clear();
        setState(() {
          this.rating = 0.0;
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review submitted successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } catch (e) {
        // Show an error message if the review submission fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit review. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      print('User not authenticated');
    }
  }

  // Function to update the rating based on user's interaction with the stars
  void _updateRating(double localX) {
    const double starWidth = 32.0; // Each star's width
    final double totalWidth = starWidth * 5; // Total width for all stars

    // Ensure the x position is within valid bounds
    if (localX < 0) localX = 0;
    if (localX > totalWidth) localX = totalWidth;

    double newRating = (localX / starWidth);

    setState(() {
      rating = (newRating * 2).round() / 2; // Round to the nearest 0.5
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Review',
        style: TextStyle(
              color: Colors.black, 
              fontSize: 16,
            ),),
        centerTitle: true,
        //backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review Title Input
            const Text(
              'Review Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter review title...',
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Review Body Input
            const Text(
              'Review Body',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: bodyController,
              maxLines: 8,
              maxLength: 300, // Limit the review body to 300 characters
              decoration: InputDecoration(
                hintText: 'Write your review here...',
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Star Rating Row
            const Text(
              'Rating:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onPanUpdate: (details) {
                _updateRating(details.localPosition.dx); // Update rating based on drag
              },
              onTapDown: (details) {
                _updateRating(details.localPosition.dx); // Update rating based on tap
              },
              child: Row(
                children: List.generate(5, (index) {
                  double starValue = (index + 1).toDouble();
                  return Icon(
                    rating >= starValue
                        ? Icons.star
                        : (rating >= starValue - 0.5 ? Icons.star_half : Icons.star_border), // Display full, half, or empty star
                    size: 32,
                    color: Colors.yellow,
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Post Review Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _addReview(titleController.text, bodyController.text, rating); // Call the function to submit the review
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF41B1F1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Post Review',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Navigate to Submitted Reviews Button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => SubmittedReviewsPage()), // Navigate to the SubmittedReviewsPage
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFF41B1F1),
            //       padding: EdgeInsets.symmetric(vertical: 16),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: Text(
            //       'Submitted Reviews',
            //       style: TextStyle(color: Colors.white, fontSize: 16),
            //     ),
            //   ),
            // ),

            // Guidelines Text
            //SizedBox(height: 20),
            const Text(
              'Please ensure your review follows our community guidelines.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose(); // Dispose of the text controllers to free up resources
    bodyController.dispose();
    super.dispose();
  }
}