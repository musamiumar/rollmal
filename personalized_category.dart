import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryGreen = Color(0xFF59754E); // Muted green accent color
const Color lightGreen = Color(0xFFE8F5E9); // Light green for background
const Color accentGreen = Color(0xFF4CAF50); // Vibrant green for buttons

// Main screen for selecting personalized categories
class PersonalizedCategorySelectionScreen extends StatelessWidget {
  const PersonalizedCategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please select your category:',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                CategoryButton(
                  text: 'Pregnant Woman',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PregnantWomanPrevention(),
                      ),
                    );
                  },
                ),
                CategoryButton(
                  text: 'Caregiver of a Child Under 5',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChildUnderFivePrevention(),
                      ),
                    );
                  },
                ),
                CategoryButton(
                  text: 'Others',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OthersPrevention(),
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

  const CategoryButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}

// Screen for personalized prevention tips for Pregnant Women
class PregnantWomanPrevention extends StatelessWidget {
  const PregnantWomanPrevention({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prevention Tips for Pregnant Women'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comprehensive Prevention Strategies for Pregnant Women:',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  preventionTip(
                      '1. Use insecticide-treated nets (ITNs): Ensure you sleep under an ITN to reduce mosquito bites, especially at night.'),
                  preventionTip(
                      '2. Attend regular antenatal check-ups: Discuss malaria prevention and screening with your healthcare provider.'),
                  preventionTip(
                      '3. Take intermittent preventive treatment during pregnancy (IPTp): Follow your doctor’s advice on IPTp to reduce malaria risk.'),
                  preventionTip(
                      '4. Avoid areas with high malaria transmission: If possible, limit your exposure to high-risk areas, especially during rainy seasons.'),
                  preventionTip(
                      '5. Wear protective clothing: Opt for long-sleeved shirts and long pants to minimize skin exposure to mosquito bites.'),
                  preventionTip(
                      '6. Use mosquito repellents: Apply repellents containing DEET on exposed skin when going outdoors.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen for personalized prevention tips for Caregivers of Children Under 5
class ChildUnderFivePrevention extends StatelessWidget {
  const ChildUnderFivePrevention({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prevention Tips for Caregivers of Children Under 5'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comprehensive Prevention Strategies for Caregivers:',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  preventionTip(
                      '1. Keep children indoors during peak mosquito activity: Usually at dawn and dusk to minimize exposure.'),
                  preventionTip(
                      '2. Ensure children use bed nets while sleeping: Protect them from mosquito bites at night using ITNs.'),
                  preventionTip(
                      '3. Seek immediate medical attention if fever develops: Early treatment is crucial for malaria. Do not delay.'),
                  preventionTip(
                      '4. Educate children on the importance of prevention: Teach them to recognize and avoid mosquitoes.'),
                  preventionTip(
                      '5. Use insect repellent on children: Apply repellents safe for children, especially when going outdoors.'),
                  preventionTip(
                      '6. Create a mosquito-free environment: Eliminate standing water around the home where mosquitoes breed.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen for personalized prevention tips for Others
class OthersPrevention extends StatelessWidget {
  const OthersPrevention({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prevention Tips for Others'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comprehensive Prevention Strategies for Others:',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  preventionTip(
                      '1. Use mosquito repellents on exposed skin: Apply repellents containing DEET or picaridin before going outside.'),
                  preventionTip(
                      '2. Eliminate standing water around your home: Mosquitoes breed in stagnant water, so regularly check and remove it from containers, gutters, and puddles.'),
                  preventionTip(
                      '3. Participate in community awareness programs about malaria: Stay informed about malaria prevention and share knowledge within your community.'),
                  preventionTip(
                      '4. Advocate for mosquito control programs: Support local initiatives to reduce mosquito populations and promote environmental health.'),
                  preventionTip(
                      '5. Install window and door screens: Use screens to keep mosquitoes out of your home.'),
                  preventionTip(
                      '6. Wear protective clothing: Long sleeves and pants can significantly reduce mosquito bites.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function for prevention tips
Widget preventionTip(String tip) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      children: [
        const Icon(Icons.check_circle,
            color: primaryGreen), // Add an icon for emphasis
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            tip,
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
