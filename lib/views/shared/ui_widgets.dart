import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../styles/constants.dart';

/// Ein angepasstes Texteingabefeld mit einheitlichem Design für die App
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Color color;
  final bool obscureText;
  final bool showVisibilityToggle;
  final VoidCallback? onToggleVisibility;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.color,
    this.obscureText = false,
    this.showVisibilityToggle = false,
    this.onToggleVisibility,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.roundedContainer(
        borderColor: color,
        borderRadius: 20,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: AppTextStyles.body,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)
          ),
          hintText: hint,
            hintStyle: TextStyle(color: AppColors.textPrimary.withAlpha(153)),
          prefixIcon: Icon(icon, color: color),
          suffixIcon: showVisibilityToggle
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: color,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}

/// Ein angepasster Button im App-Design
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final bool isLoading;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: AppTextStyles.buttonText,
              ),
      ),
    );
  }
}

/// Ein wiederverwendbares Logo-Widget für verschiedene Screens
class LogoWidget extends StatelessWidget {
  final double size;
  final bool heroEnabled;

  const LogoWidget({
    super.key,
    this.size = 150,
    this.heroEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidget = Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/logo.png',  // Stellen Sie sicher, dass das Logo im Asset-Ordner liegt
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback, wenn das Logo-Bild nicht gefunden wird
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_bar, size: size / 3, color: AppColors.accentPink),
                const SizedBox(height: 8),
                Text(
                  AppStrings.appName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.lightPink,
                    fontWeight: FontWeight.bold,
                    fontSize: size / 10,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    // Wenn Hero-Animation aktiviert ist, in Hero-Widget einpacken
    if (heroEnabled) {
      return Hero(
        tag: 'app_logo',
        child: logoWidget,
      );
    }

    return logoWidget;
  }
}

/// Custom TabBar für Login/Register
class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.roundedContainer(
        borderRadius: 30,
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.accentPink,    
        ),
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        tabs: tabs.map((tab){
          return Container(
            alignment: Alignment.center,
            child: Tab(text: tab),
          );
        }).toList(),
      ),
    );
  }
}

