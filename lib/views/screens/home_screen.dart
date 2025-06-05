import 'package:claudiskegelapp/viewmodels/auth_viewmodel.dart';
import 'package:claudiskegelapp/views/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/constants.dart';
import '../shared/card_widgets.dart';
import '../shared/ui_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final auth = Provider.of<AuthViewModel>(context);
    
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text(AppStrings.appName),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.lightGrey,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(

            children: [
              // Header with logo
              Row(
                children: [
                  LogoWidget(size: 60, heroEnabled: true),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Willkommen Claudi!', style: AppTextStyles.heading),
                      Text('Schön, dass du da bist.', style: AppTextStyles.subheading),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: const DashboardView(),
              ),
          
              Spacer(),

              // Menu Cards in horizontal scroll
              SizedBox(
                height: screenSize.height * 0.175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6, 
                  itemBuilder: (context, index) {

                    // Definitionen der Menüpunkte
                    final List<Map<String, dynamic>> menuItems = [
                      {
                        'title': 'Termine',
                        'icon': Icons.calendar_today,
                        'color': AppColors.accentPink,
                        'onTap': () => Navigator.pushNamed(context, '/calendar'),
                      },
                      {
                        'title': 'Mitspieler',
                        'icon': Icons.people,
                        'color': AppColors.accentBlue,
                        'onTap': () {},
                      },
                      {
                        'title': 'Statistiken',
                        'icon': Icons.bar_chart,
                        'color': AppColors.accentYellow,
                        'onTap': () {},
                      },
                      {
                        'title': 'Locations',
                        'icon': Icons.place,
                        'color': AppColors.darkPurple,
                        'onTap': () {},
                      },
                      {
                        'title': 'Spiele',
                        'icon': Icons.sports_mma,
                        'color': AppColors.primaryColor,
                        'onTap': () {},
                      },
                      {
                        'title': 'Über uns',
                        'icon': Icons.info,
                        'color': Colors.teal,
                        'onTap': () {},
                      },
                    ];
                    
                    final item = menuItems[index];
                    
                    return SizedBox(
                      width: screenSize.height * 0.175, 
                      child: MenuCard(
                        title: item['title'],
                        icon: item['icon'],
                        color: item['color'],
                        onTap: item['onTap'],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Button-Aktion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12), 
                    minimumSize: const Size(0, 0), 
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 32,
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
