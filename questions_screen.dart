import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'prompt_data.dart';
import 'pregnant_woman_questions_screen.dart';
import 'symptoms_and_AI_integration.dart';

class QuestionsScreen extends StatefulWidget {
  final String selectedCategory;

  const QuestionsScreen({super.key, required this.selectedCategory});

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  String? mosquitoAround;
  String? useNets;

  @override
  Widget build(BuildContext context) {
    final promptData = Provider.of<PromptData>(context, listen: false);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final double fontSize = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Questions',
          style: GoogleFonts.montserrat(
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800], // Use dark grey for text
          ),
        ),
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Off-white background for cards
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(width * 0.04),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Do you have mosquitoes living around you?',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('Yes',
                                  style: TextStyle(fontSize: fontSize)),
                              value: 'Yes',
                              groupValue: mosquitoAround,
                              activeColor:
                                  const Color(0xFF59754E), // Muted green
                              onChanged: (value) {
                                setState(() {
                                  mosquitoAround = value;
                                  promptData.updateMosquitoAround(value!);
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('No',
                                  style: TextStyle(fontSize: fontSize)),
                              value: 'No',
                              groupValue: mosquitoAround,
                              activeColor:
                                  const Color(0xFF59754E), // Muted green
                              onChanged: (value) {
                                setState(() {
                                  mosquitoAround = value;
                                  promptData.updateMosquitoAround(value!);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Do you use insecticide-treated mosquito nets while sleeping?',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('Yes',
                                  style: TextStyle(fontSize: fontSize)),
                              value: 'Yes',
                              groupValue: useNets,
                              activeColor:
                                  const Color(0xFF59754E), // Muted green
                              onChanged: (value) {
                                setState(() {
                                  useNets = value;
                                  promptData.updateUseNets(value!);
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('No',
                                  style: TextStyle(fontSize: fontSize)),
                              value: 'No',
                              groupValue: useNets,
                              activeColor:
                                  const Color(0xFF59754E), // Muted green
                              onChanged: (value) {
                                setState(() {
                                  useNets = value;
                                  promptData.updateUseNets(value!);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Now I would like to ask you a few questions that are very useful to your health. Please click next to continue.',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSize,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            navigateToNextScreen();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF59754E), // Muted green
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 40),
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.015),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: GoogleFonts.montserrat(
                              fontSize: fontSize * 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('NEXT'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen() {
    if (widget.selectedCategory == "Pregnant Women") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PregnantWomenQuestionsScreen(),
        ),
      );
    } else if (widget.selectedCategory == "Children Under Five") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChildUnderFiveSymptomsScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherSymptomsScreen(),
        ),
      );
    }
  }
}
