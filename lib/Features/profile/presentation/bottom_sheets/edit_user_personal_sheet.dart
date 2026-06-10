import 'package:flutter/material.dart';
import 'package:nova_news/Features/profile/presentation/controller/profile_controller.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/core/utils/utils.dart';
import 'package:nova_news/core/widgets/custom_elevated_button.dart';
import 'package:nova_news/core/widgets/shared_text_form_field.dart';
import 'package:provider/provider.dart';

class EditUserPersonalSheet extends StatefulWidget {
  const EditUserPersonalSheet({super.key});

  @override
  State<EditUserPersonalSheet> createState() => _EditUserPersonalSheetState();
}

class _EditUserPersonalSheetState extends State<EditUserPersonalSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AutovalidateMode _autoValidateMode = AutovalidateMode.onUserInteraction;

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<ProfileController>(
      builder: (context, controller, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.fromLTRB(
            AppSizes.w(20),
            AppSizes.h(8),
            AppSizes.w(20),
            keyboardHeight + AppSizes.h(24),
          ),
          child: Form(
            autovalidateMode: _autoValidateMode,
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: AppSizes.h(20)),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                Text('Profile Info', style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                )),

                SizedBox(height: AppSizes.h(24)),

                _FieldLabel(label: 'Username', icon: Icons.alternate_email_rounded),
                SizedBox(height: AppSizes.h(8)),
                SharedTextFormField(
                  keyboardType: TextInputType.name,
                  focusNode: controller.usernameFocusNode,
                  controller: controller.usernameController,
                  hintText: 'ahmedalaayq',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(controller.emailFocusNode);
                  },
                ),

                SizedBox(height: AppSizes.h(16)),

                // ── Email ────────────────────────────────────────────────
                _FieldLabel(label: 'Email', icon: Icons.mail_outline_rounded),
                SizedBox(height: AppSizes.h(8)),
                SharedTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  focusNode: controller.emailFocusNode,
                  controller: controller.emailController,
                  hintText: 'ahmed@gmail.com',
                  validator: (value) => Utils.emailFieldValidator(value),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),

                SizedBox(height: AppSizes.h(28)),

                // ── Save button ──────────────────────────────────────────
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pop(context);
                      context.read<ProfileController>().updatePersonalInfo();
                    }
                  },
                  buttonText: 'Save Changes',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Small reusable label widget ──────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}