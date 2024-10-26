import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'prompt_data.dart';

const Color primaryGreen = Color(0xFF2E5339);
const Color lightGreen = Color(0xFFE8F5E9);
const Color accentGreen = Color(0xFF4CAF50);

class SymptomsScreen extends StatefulWidget {
  final List<String> symptoms;
  final String title;

  const SymptomsScreen({
    super.key,
    required this.symptoms,
    required this.title,
  });

  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  Map<String, bool> selectedSymptoms = {};
  bool _isLoading = false;
  String? _resultMessage;
  late GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    for (var symptom in widget.symptoms) {
      selectedSymptoms[symptom] = false;
    }
    _initializeAI();
  }

  Future<void> _initializeAI() async {
    if (dotenv.env['API_KEY'] == null || dotenv.env['API_KEY']!.isEmpty) {
      throw Exception(
          'API Key is missing or invalid. Please check your .env file.');
    }

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: dotenv.env['API_KEY']!,
    );
  }

  Future<void> _submitDetails() async {
    setState(() {
      _isLoading = true;
    });

    final promptData = Provider.of<PromptData>(context, listen: false);
    String categoryPrompt = promptData.category;
    List<String> selectedSymptoms = this
        .selectedSymptoms
        .keys
        .where((key) => this.selectedSymptoms[key]!)
        .toList();

    String details = '''
Category: $categoryPrompt
Selected Symptoms: ${selectedSymptoms.join(', ')}
User Age: ${promptData.userAge}
Pregnancy Age: ${promptData.pregnancyAge}
Antenatal Clinic Visits: ${promptData.antenatalClinicVisits}
Mosquito Around: ${promptData.mosquitoAround}
Use Nets: ${promptData.useNets}
''';

    try {
      final response = await _model.generateContent([
        Content.text(
            'Please assess the following symptoms and details: $details. For educational purposes only, classify the risk level of malaria as high, moderate, or low. If the risk is high, respond with "High risk". If the risk is moderate, respond with "Moderate risk". If the risk is low, respond with "Low risk".')
      ]);

      setState(() {
        _resultMessage = _classifyRisk(response.text ?? '');
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RecommendationScreen(resultMessage: _resultMessage!),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _classifyRisk(String response) {
    if (response.contains('High risk')) {
      return 'High risk for malaria. Go to the nearest health facility, it’s an emergency.';
    } else if (response.contains('Moderate risk')) {
      return 'Moderate risk for malaria. Go to the health facility within a few hours.';
    } else {
      return 'Low risk for malaria. You can go for a checkup anytime.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightGreen,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  widget.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select your symptoms:',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: widget.symptoms.length,
                          itemBuilder: (context, index) {
                            final symptom = widget.symptoms[index];
                            final isSelected =
                                selectedSymptoms[symptom] ?? false;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSymptoms[symptom] = !isSelected;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? primaryGreen : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        isSelected ? primaryGreen : accentGreen,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryGreen.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      symptom,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : primaryGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitDetails,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationScreen extends StatefulWidget {
  final String resultMessage;

  const RecommendationScreen({super.key, required this.resultMessage});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Map<String, dynamic> _getRiskDetails() {
    if (widget.resultMessage.contains('High risk')) {
      return {
        'emoji': '😰',
        'color': Colors.red.shade700,
        'label': 'High Risk',
        'action': 'Emergency! Go to the nearest health facility immediately.'
      };
    } else if (widget.resultMessage.contains('Moderate risk')) {
      return {
        'emoji': '😐',
        'color': Colors.orange.shade700,
        'label': 'Moderate Risk',
        'action': 'Visit a health facility within a few hours.'
      };
    } else {
      return {
        'emoji': '😊',
        'color': accentGreen,
        'label': 'Low Risk',
        'action': 'Schedule a regular checkup when convenient.'
      };
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final riskDetails = _getRiskDetails();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightGreen,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Risk Assessment',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Container(
                                width: screenSize.width * 0.85,
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        riskDetails['emoji'],
                                        style: const TextStyle(fontSize: 72),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: Text(
                                        riskDetails['label'],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: riskDetails['color'],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: Text(
                                        riskDetails['action'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: primaryGreen,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'Please consult with a healthcare provider for a proper diagnosis and treatment.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: primaryGreen.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Check Again',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// PregnantWomanSymptomsScreen: Symptom screen for pregnant women
class PregnantWomanSymptomsScreen extends StatelessWidget {
  final List<String> symptoms = [
    'Fever',
    'Chills',
    'Flu-like illness',
    'Headache',
    'Joint pains',
    'Muscle soreness (pains)',
    'Extreme tiredness (fatigue)',
    'Poor appetite (bitter taste)',
    'Nausea',
    'Vomiting',
    'Diarrhea',
    'Dizziness',
    'Yellowness of the eyes or skin',
    'Lower abdominal pain',
    'Vaginal bleeding',
  ];

  PregnantWomanSymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SymptomsScreen(
      symptoms: symptoms,
      title: 'Symptoms',
    );
  }
}

// ChildUnderFiveSymptomsScreen: Symptom screen for children under five
class ChildUnderFiveSymptomsScreen extends StatelessWidget {
  final List<String> symptoms = [
    'Irritability',
    'Drowsiness',
    'Refusal to feed',
    'Trouble sleeping',
    'Cough',
    'Rapid breathing',
    'Fever',
    'Chills',
    'Rigors',
    'Diarrhea',
    'Vomiting',
    'Yellowish eyes',
    'Yellowish urine',
    'Abdominal pain',
  ];

  ChildUnderFiveSymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SymptomsScreen(
      symptoms: symptoms,
      title: 'Symptoms',
    );
  }
}

// OtherSymptomsScreen: Symptom screen for other general symptoms
class OtherSymptomsScreen extends StatelessWidget {
  final List<String> symptoms = [
    'Fever',
    'Chills',
    'Headache',
    'Muscle aches',
    'Fatigue',
    'Sweating',
    'Nausea',
    'Vomiting',
    'Diarrhea',
    'Dark urine',
    'Rapid breathing',
    'Confusion',
    'Seizures',
  ];

  OtherSymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SymptomsScreen(
      symptoms: symptoms,
      title: 'Symptoms',
    );
  }
}
