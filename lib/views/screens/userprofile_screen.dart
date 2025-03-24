import 'package:claudiskegelapp/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/constants.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../shared/ui_widgets.dart';
import '../shared/card_widgets.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as String?;
    if (userId == null) return _buildErrorScreen('No user ID provided');

    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        final user = userViewModel.getUser(userId);
        if (user == null) return _buildErrorScreen('User not found');

        return Scaffold(
          backgroundColor: AppColors.lightGrey,
          appBar: AppBar(
            title: Text(userViewModel.getUser(userId)?.name ?? ''),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.lightGrey,
          ),
          body: Stack(
            children: [
              // Main content with padding at bottom for team section
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 140),
                child: Column(
                  children: [
                    _buildProfileHeader(context, userViewModel, userId),
                    _buildStatsSection(),
                    _buildRecentActivitySection(),
                  ],
                ),
              ),
              // Fixed team members section at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildTeamMembersSection(context, userViewModel, userId),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorScreen(String message) {
    return Scaffold(
      body: Center(child: Text(message)),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context, 
    UserViewModel userViewModel, 
    String userId,
  ) {
    final user = userViewModel.getUser(userId);
    if (user == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
            child: user.photoUrl == null
                ? Icon(Icons.person, size: 50, color: AppColors.primaryColor)
                : null,
          ),
          const SizedBox(height: 16),
          Text(user.name, style: AppTextStyles.heading),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiken',
            style: AppTextStyles.subheading.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStatRow('Spiele gesamt', '0'),
          _buildStatRow('Durchschnitt', '0.0'),
          _buildStatRow('Bestleistung', '0'),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Letzte Aktivitäten',
            style: AppTextStyles.subheading.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Center(child: Text('Keine Aktivitäten vorhanden')),
        ],
      ),
    );
  }

  Widget _buildTeamMembersSection(
    BuildContext context,
    UserViewModel userViewModel,
    String currentUserId,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Team Mitglieder',
              style: AppTextStyles.subheading.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: userViewModel.userIds.length,
              itemBuilder: (context, index) {
                final memberId = userViewModel.userIds[index];
                if (memberId == currentUserId) return const SizedBox.shrink();
                
                return TeamMemberCard(
                  userId: memberId,
                  color: AppColors.primaryColor,
                  onUserSelected: (selectedUserId) {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.userProfile,
                      arguments: selectedUserId,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body),
          Text(value, style: AppTextStyles.body),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
        ),
      ],
    );
  }
}