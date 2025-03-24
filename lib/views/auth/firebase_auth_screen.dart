import 'package:claudiskegelapp/styles/constants.dart';
import 'package:claudiskegelapp/views/shared/ui_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.onLoginSuccess = () {
      Navigator.pushReplacementNamed(context, '/main');
    };
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    // Logo-Container nimmt fast die gesamte Bildschirmbreite ein (mit Padding)
    final circleSize = screenSize.width * 0.7;
    
    return Scaffold(
      backgroundColor: AppColors.primaryColor, // Verwende den lila Modus-Hintergrund
      appBar: AppBar(
        title: Text(AppStrings.appName, style: AppTextStyles.purpleHeading),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.lightGrey,
        elevation: 0,
        leading: Icon(Icons.sports_bar, color: AppColors.creamBackground), // Beige Icon
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final contentHeight = circleSize + 350;
            final needsScrolling = contentHeight > availableHeight;
            
            return SingleChildScrollView(
              physics: needsScrolling 
                  ? const AlwaysScrollableScrollPhysics() 
                  : const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    height: needsScrolling ? contentHeight : availableHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: availableHeight * 0.05),
                          child: LogoWidget(
                            size: circleSize,
                            heroEnabled: false,
                          ),
                        ),
                    
                        // Unterer Bereich mit Eingabefeldern und Button
                        Padding(
                          padding: EdgeInsets.only(bottom: availableHeight * 0.07),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Consumer<AuthViewModel>(
                                builder: (context, vm, child) => CustomTextField(
                                  controller: vm.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  hint: AppStrings.email,
                                  color: AppColors.backgroundLight, // Beige Farbe beibehalten
                                  icon: Icons.email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'E-Mail erforderlich';
                                    return null;
                                  },
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              Consumer<AuthViewModel>(
                                builder: (context, vm, child) => CustomTextField(
                                  controller: vm.passwordController,
                                  obscureText: true,
                                  hint: AppStrings.password,
                                  color: AppColors.backgroundLight, // Beige Farbe beibehalten
                                  icon: Icons.lock,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              Consumer<AuthViewModel>(
                                builder: (context, vm, child) {
                                  return vm.isLoading
                                    ? const Center(child: CircularProgressIndicator(color: AppColors.creamBackground))
                                    : CustomButton(
                                        text: AppStrings.loginButton,
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            vm.signIn();
                                          }
                                        },
                                        backgroundColor: AppColors.accentBlue, // Beige Farbe beibehalten
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}