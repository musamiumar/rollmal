import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rollmal/symptoms_and_AI_integration.dart'; // Import the PregnantWomanSymptomsScreen widget

class PregnantWomenQuestionsScreen extends StatefulWidget {
  const PregnantWomenQuestionsScreen({super.key});

  @override
  _PregnantWomenQuestionsScreenState createState() =>
      _PregnantWomenQuestionsScreenState();
}

class _PregnantWomenQuestionsScreenState
    extends State<PregnantWomenQuestionsScreen> {
  String? selectedAgeGroup;
  String? selectedPregnancyAge;
  String? antenatalClinicVisit;

  Widget buildOption(
      String option, bool isSelected, VoidCallback onTap, double fontSize) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF59754E)
              : Colors.white, // Muted green for selected
          border: Border.all(
              color: const Color(0xFF59754E)), // Muted green for borders
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.grey[800], // Dark grey for unselected text
              fontSize: fontSize, // Dynamically set font size
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Dynamically adjust font sizes based on the screen width
    final double fontSize = width * 0.04; // Adjusts the font size

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Questions',
          style: GoogleFonts.montserrat(
            fontSize: width * 0.07, // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.grey[800], // Dark grey for title
          ),
        ),
        iconTheme:
            IconThemeData(color: Colors.grey[800]), // Dark grey for icons
      ),
      body: Stack(
        children: [
          // Background color
          Container(
            color: Colors.white,
          ),
          Column(
            children: [
              // Main Content Scrollable
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05), // Responsive padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20), // Responsive spacing

                      // Question 1: Age Group
                      Text(
                        'How old are you?',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize, // Responsive font size
                          color: Colors.grey[800], // Dark grey for text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildOption('Less than 18 years',
                          selectedAgeGroup == 'Less than 18 years', () {
                        setState(() {
                          selectedAgeGroup = 'Less than 18 years';
                        });
                      }, fontSize),
                      buildOption('18 to 35 years',
                          selectedAgeGroup == '18 to 35 years', () {
                        setState(() {
                          selectedAgeGroup = '18 to 35 years';
                        });
                      }, fontSize),
                      buildOption('Above 35 years',
                          selectedAgeGroup == 'Above 35 years', () {
                        setState(() {
                          selectedAgeGroup = 'Above 35 years';
                        });
                      }, fontSize),
                      buildOption(
                          'Don\'t know', selectedAgeGroup == 'Don\'t know', () {
                        setState(() {
                          selectedAgeGroup = 'Don\'t know';
                        });
                      }, fontSize),
                      buildOption('Don\'t want to say',
                          selectedAgeGroup == 'Don\'t want to say', () {
                        setState(() {
                          selectedAgeGroup = 'Don\'t want to say';
                        });
                      }, fontSize),

                      const SizedBox(height: 20), // Space between questions

                      // Question 2: Pregnancy Age
                      Text(
                        'How old is your pregnancy?',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize, // Responsive font size
                          color: Colors.grey[800], // Dark grey for text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildOption('Less than 14 weeks (3 months and below)',
                          selectedPregnancyAge == 'Less than 14 weeks', () {
                        setState(() {
                          selectedPregnancyAge = 'Less than 14 weeks';
                        });
                      }, fontSize),
                      buildOption('14 to 28 weeks (3 to less than 7 months)',
                          selectedPregnancyAge == '14 to 28 weeks', () {
                        setState(() {
                          selectedPregnancyAge = '14 to 28 weeks';
                        });
                      }, fontSize),
                      buildOption('28 to 38 weeks and above (7 to 9 months)',
                          selectedPregnancyAge == '28 to 38 weeks', () {
                        setState(() {
                          selectedPregnancyAge = '28 to 38 weeks';
                        });
                      }, fontSize),

                      const SizedBox(height: 20), // Responsive spacing

                      Text(
                        'Have you started visiting any Antenatal Clinic for this pregnancy?',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize, // Responsive font size
                          color: Colors.grey[800], // Dark grey for text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildOption('Yes', antenatalClinicVisit == 'Yes', () {
                        setState(() {
                          antenatalClinicVisit = 'Yes';
                        });
                      }, fontSize),
                      buildOption('No', antenatalClinicVisit == 'No', () {
                        setState(() {
                          antenatalClinicVisit = 'No';
                        });
                      }, fontSize),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Next Button at the Bottom
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the PregnantWomanSymptomsScreen on button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PregnantWomanSymptomsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF59754E), // Muted green for button
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50), // Full width
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02), // Responsive padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: GoogleFonts.montserrat(
                      fontSize: fontSize * 1.2, // Slightly larger for buttons
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('NEXT'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
