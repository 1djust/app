import 'package:flutter/material.dart';
import 'select_account_type_screen.dart';
import '../widgets/progress_bar.dart';
import '../theme/app_colors.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Mock list of countries with codes
  final List<Map<String, String>> _countries = [
    {'name': 'Nigeria', 'code': 'ng'},
    {'name': 'United States', 'code': 'us'},
    {'name': 'United Kingdom', 'code': 'gb'},
    {'name': 'Canada', 'code': 'ca'},
    {'name': 'Ghana', 'code': 'gh'},
    {'name': 'Cameroon', 'code': 'cm'},
    {'name': 'Liberia', 'code': 'lr'},
  ];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectAccountTypeScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: isDark ? AppColors.textMainDark : AppColors.textMain),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Start',
          style: TextStyle(
              color: isDark ? AppColors.textMainDark : AppColors.textMain,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(currentStep: 1, totalSteps: 5),
              const SizedBox(height: 24),
              Text(
                'Create Your Figures Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Let's get started — enter your email and country of residence to continue.",
                style: TextStyle(
                    fontSize: 14,
                    color:
                        isDark ? AppColors.textMutedDark : AppColors.textMuted),
              ),
              const SizedBox(height: 32),

              // Country Dropdown
              RichText(
                text: TextSpan(
                  text: 'Country of Residence ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  ),
                  children: const [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: TextEditingController(text: _selectedCountry),
                readOnly: true,
                style: TextStyle(
                    color:
                        isDark ? AppColors.textMainDark : AppColors.textMain),
                decoration: InputDecoration(
                  hintText: 'Select your country',
                  hintStyle: TextStyle(
                      color:
                          isDark ? AppColors.textHintDark : AppColors.textHint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  fillColor: isDark
                      ? AppColors.midnightSurface
                      : AppColors.surfaceLight,
                  filled: true,
                  prefixIcon: _selectedCountry != null
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            'https://flagcdn.com/w40/${_countries.firstWhere((c) => c['name'] == _selectedCountry)['code']}.png',
                            width: 24,
                            height: 16,
                            errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.flag,
                                size: 24,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMuted),
                          ),
                        )
                      : null,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color:
                        isDark ? AppColors.textMutedDark : AppColors.textMuted,
                  ),
                ),
                onTap: () async {
                  final selected = await showModalBottomSheet<String>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.midnightBase : Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Select country of residence',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.textMainDark
                                    : AppColors.textMain,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _countries.length,
                                separatorBuilder: (context, index) => Divider(
                                    height: 1,
                                    color: isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderLight),
                                itemBuilder: (context, index) {
                                  final country = _countries[index];
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        'https://flagcdn.com/w40/${country['code']}.png',
                                        width: 32,
                                        height: 24,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.flag,
                                                    color: AppColors.textMuted),
                                      ),
                                    ),
                                    title: Text(
                                      country['name']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? AppColors.textMainDark
                                            : AppColors.textMain,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context, country['name']);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  if (selected != null && mounted) {
                    setState(() {
                      _selectedCountry = selected;
                    });
                  }
                },
                validator: (value) =>
                    _selectedCountry == null ? 'Please select a country' : null,
              ),
              const SizedBox(height: 8),
              Text(
                'Determines which form applies to you',
                style: TextStyle(
                    fontSize: 12,
                    color:
                        isDark ? AppColors.textMutedDark : AppColors.textMuted),
              ),
              const SizedBox(height: 24),

              // Email Input
              RichText(
                text: TextSpan(
                  text: 'Email Address ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  ),
                  children: const [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color:
                        isDark ? AppColors.textMainDark : AppColors.textMain),
                decoration: InputDecoration(
                  hintText: 'e.g., johndoe@email.com',
                  hintStyle: TextStyle(
                      color:
                          isDark ? AppColors.textHintDark : AppColors.textHint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  fillColor: isDark
                      ? AppColors.midnightSurface
                      : AppColors.surfaceLight,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Used for login and verification',
                style: TextStyle(
                    fontSize: 12,
                    color:
                        isDark ? AppColors.textMutedDark : AppColors.textMuted),
              ),
              const SizedBox(height: 24),

              // Password Input
              RichText(
                text: TextSpan(
                  text: 'Password ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  ),
                  children: const [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(
                    color:
                        isDark ? AppColors.textMainDark : AppColors.textMain),
                decoration: InputDecoration(
                  hintText: 'P\$Example1',
                  hintStyle: TextStyle(
                      color:
                          isDark ? AppColors.textHintDark : AppColors.textHint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  fillColor: isDark
                      ? AppColors.midnightSurface
                      : AppColors.surfaceLight,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Confirm Password Input
              RichText(
                text: TextSpan(
                  text: 'Confirm Password ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  ),
                  children: const [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                style: TextStyle(
                    color:
                        isDark ? AppColors.textMainDark : AppColors.textMain),
                decoration: InputDecoration(
                  hintText: 'P\$Example1',
                  hintStyle: TextStyle(
                      color:
                          isDark ? AppColors.textHintDark : AppColors.textHint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  fillColor: isDark
                      ? AppColors.midnightSurface
                      : AppColors.surfaceLight,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Terms
              Text.rich(
                TextSpan(
                  text:
                      'By clicking Continue account, I agree that I have read and accepted the ',
                  style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted),
                  children: const [
                    TextSpan(
                      text: 'Terms of use',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDark ? AppColors.electricAccent : AppColors.textMain,
                    foregroundColor:
                        isDark ? AppColors.midnightBase : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.midnightBase : Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
