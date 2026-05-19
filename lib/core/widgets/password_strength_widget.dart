import 'package:flutter/material.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';

class PasswordStrengthWidget extends StatelessWidget {
  final String password;

  const PasswordStrengthWidget({super.key, required this.password});

  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(password);

  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(password);

  bool get hasNumber => RegExp(r'[0-9]').hasMatch(password);

  bool get hasSpecialChar => RegExp(r'[@$!%*?&]').hasMatch(password);

  bool get hasMinLength => password.length >= 8;

  int get strength {
    int value = 0;

    if (hasUppercase) value++;
    if (hasLowercase) value++;
    if (hasNumber) value++;
    if (hasSpecialChar) value++;
    if (hasMinLength) value++;

    return value;
  }

  Color get strengthColor {
    if (strength <= 2) {
      return LightAppColors.primaryColor;
    } else if (strength == 3 || strength == 4) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String get strengthText {
    if (strength <= 2) {
      return 'Weak Password';
    } else if (strength == 3 || strength == 4) {
      return 'Medium Password';
    } else {
      return 'Strong Password';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: strengthColor.withValues(alpha: 0.08),
        border: Border.all(
          color: strengthColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= Strength Header =================
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: strength / 5,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(strengthColor),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Text(
                strengthText,
                style: TextStyle(
                  color: strengthColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _buildRequirement(
            title: 'Uppercase Letter',
            isValid: hasUppercase,
          ),

          _buildRequirement(
            title: 'Lowercase Letter',
            isValid: hasLowercase,
          ),

          _buildRequirement(title: 'Number', isValid: hasNumber),

          _buildRequirement(
            title: 'Special Character',
            isValid: hasSpecialChar,
          ),

          _buildRequirement(
            title: 'Minimum 8 Characters',
            isValid: hasMinLength,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement({
    required String title,
    required bool isValid,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isValid ? Colors.green : Colors.grey.shade400,
            ),
            child: Icon(
              isValid ? Icons.check : Icons.close,
              size: 14,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Text(title),
        ],
      ),
    );
  }
}
