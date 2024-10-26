import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rollmal/category.dart';
import 'package:rollmal/personalized_category.dart';

// Color constants
const Color primaryGreen = Color(0xFF2E5339);
const Color lightGreen = Color(0xFFE8F5E9);
const Color accentGreen = Color(0xFF4CAF50);

class RollMallApp extends StatelessWidget {
  const RollMallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryGreen,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const RollMallHomePage(),
    const EducationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryGreen,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: _CustomIcon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school_outlined),
                activeIcon: _CustomIcon(Icons.school),
                label: 'Education',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomIcon extends StatelessWidget {
  final IconData iconData;

  const _CustomIcon(this.iconData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData),
    );
  }
}

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Malaria Education',
          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Understanding Malaria',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Malaria is caused by Plasmodium parasites that are transmitted through the bites of infected female Anopheles mosquitoes. Malaria can cause high fever, chills, flu-like symptoms, and if untreated, can be life-threatening.',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Symptoms of Malaria',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Common symptoms include:\n\n• Fever\n• Chills\n• Sweating\n• Headaches\n• Nausea and vomiting\n• Fatigue\n• Muscle aches\n• Joint pain\n• Cough',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Complications',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'If left untreated, malaria can lead to severe complications, such as:\n\n• Anemia (due to the destruction of red blood cells)\n• Cerebral malaria (which can cause brain damage)\n• Pulmonary edema (fluid buildup in the lungs)\n• Kidney failure\n• Death',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Risk Factors',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Several factors can increase a person\'s risk of contracting malaria, including:\n\n• Living in or traveling to areas where malaria is prevalent\n• Being exposed to mosquito bites\n• Having a weakened immune system\n• Being pregnant',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Prevention and Treatment',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Effective measures can help prevent and treat malaria:\n\nPrevention:\n• Use mosquito nets treated with insecticide.\n• Wear long-sleeved clothing and pants.\n• Apply insect repellent containing DEET or other effective ingredients.\n• Take antimalarial medication as prescribed.\n• Reduce exposure to mosquito breeding grounds.\n\nTreatment:\n• Seek medical attention promptly if you develop malaria symptoms.\n• Effective antimalarial drugs are available to treat the disease.',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Update RollMallHomePage to remove the Scaffold
class RollMallHomePage extends StatefulWidget {
  const RollMallHomePage({super.key});

  @override
  _RollMallHomePageState createState() => _RollMallHomePageState();
}

class _RollMallHomePageState extends State<RollMallHomePage> {
  final double fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/r.png", // Replace with your app logo path
            height: 100, // Adjust the height as needed
            width: 100, // Adjust the width as needed
          ),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to RollMall",
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 20),

              // AI Guide Card
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: lightGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            "assets/images/bot.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "My name is Dr. Aimal - your Malaria AI guide.",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "I am here to guide you through useful tips to help you identify early symptoms of malaria and prevent complications.",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'I would like to ask you some questions regarding your health. Would you like to continue?',
                      style: GoogleFonts.montserrat(
                        fontSize: fontSize,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CategorySelectionScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Yes',
                              style: GoogleFonts.montserrat(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showThankYouDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: primaryGreen,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 2,
                              side: const BorderSide(
                                  color: primaryGreen, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'No',
                              style: GoogleFonts.montserrat(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Action Buttons
              CustomButton(
                text: 'Learn more about Malaria',
                icon: Icons.school,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EducationScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              CustomButton(
                text: 'Get Personalized Prevention tips',
                icon: Icons.shield_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PersonalizedCategorySelectionScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              CustomButton(
                text: 'Check Your Risk of Having Malaria',
                icon: Icons.error_outline,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategorySelectionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thank you'),
        content: SingleChildScrollView(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'Thank you for your time. Remember, you can return to my clinic at any time.\n\n',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      'Meanwhile, remember that malaria is common, transmitted by mosquito bites, and can be prevented with proper precautions.\n\n',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      'Sleeping under nets, clearing surroundings, and early symptom detection can reduce complications.\n\n',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: "Have a nice day",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(text: " 😀😀😀", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
