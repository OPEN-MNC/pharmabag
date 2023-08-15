import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/custom_theme.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: CustomTheme.cardShadow,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: TextButton(
                child: const ReusableText(
                    text: "Seller Agreement",
                    fontSize: 17,
                    fontcolor: blackColor),
                onPressed: () {
                  launchUrl(
                      Uri.parse('https://pharmabag.in/seller_agreement.php'),
                      mode: LaunchMode.externalApplication);
                }),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: CustomTheme.cardShadow,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: TextButton(
                child: const ReusableText(
                    text: "Privacy Policy",
                    fontSize: 17,
                    fontcolor: blackColor),
                onPressed: () {
                  launchUrl(
                      Uri.parse('https://pharmabag.in/privacy_policy.php'),
                      mode: LaunchMode.externalApplication);
                }),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: CustomTheme.cardShadow,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: TextButton(
                child: const ReusableText(
                    text: "Mutual NDA", fontSize: 17, fontcolor: blackColor),
                onPressed: () {
                  launchUrl(Uri.parse('https://pharmabag.in/mutual_nda.php'),
                      mode: LaunchMode.externalApplication);
                }),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: CustomTheme.cardShadow,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: TextButton(
                child: const ReusableText(
                    text: "Term And Conditions",
                    fontSize: 17,
                    fontcolor: blackColor),
                onPressed: () {
                  launchUrl(
                      Uri.parse(
                          'https://pharmabag.in/terms_and_conditions.php'),
                      mode: LaunchMode.externalApplication);
                }),
          ),
        ),
      ],
    );
  }
}
