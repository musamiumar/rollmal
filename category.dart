import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rollmal/prompt_data.dart';
import 'questions_screen.dart';
import 'home.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a semi-transparent green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This pops back to MainNavigationScreen
          },
        ),
      ),
      body:
          // Main content in the center
          Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500, // Maximum width of the container
            ),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: lightGreen, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header text asking to select a category
                Text(
                  'Please select your category:',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Pregnant Woman category button
                CategoryButton(
                  text: 'Pregnant Woman',
                  onPressed: () {
                    // Update the category in the PromptData provider
                    Provider.of<PromptData>(context, listen: false)
                        .updateCategory('Pregnant Women');
                    // Navigate to the QuestionsScreen with the selected category
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionsScreen(
                          selectedCategory: 'Pregnant Women',
                        ),
                      ),
                    );
                  },
                ),
                // Child Under 5 category button
                CategoryButton(
                  text: 'Care giver of a Child Under 5',
                  onPressed: () {
                    // Update the category in the PromptData provider
                    Provider.of<PromptData>(context, listen: false)
                        .updateCategory('Children Under Five');
                    // Navigate to the QuestionsScreen with the selected category
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionsScreen(
                          selectedCategory: 'Children Under Five',
                        ),
                      ),
                    );
                  },
                ),
                // Others category button
                CategoryButton(
                  text: 'Others',
                  onPressed: () {
                    // Update the category in the PromptData provider
                    Provider.of<PromptData>(context, listen: false)
                        .updateCategory('Others');
                    // Navigate to the QuestionsScreen with the selected category
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionsScreen(
                          selectedCategory: 'Others',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom button widget for selecting categories
class CategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // Constructor to initialize the text and onPressed callback
  const CategoryButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5), // Semi-transparent white
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Full width button
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            elevation: 2, // White text color
            padding:
                const EdgeInsets.symmetric(vertical: 15), // Vertical padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            textStyle: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(text), // Display the category text
        ),
      ),
    );
  }
}
