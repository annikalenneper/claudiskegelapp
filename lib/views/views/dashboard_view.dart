import 'package:claudiskegelapp/styles/constants.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          DashboardListTile(
            title: 'Nächster Termin',
            icon: Icons.calendar_today,
            subtitle: 'Keine anstehenden Termine',
          ),
          Divider(),
          DashboardListTile(
            title: 'Offene Finanzen',
            icon: Icons.euro,
            subtitle: 'Keine offenen Zahlungen',
          ),
          Divider(),
          DashboardListTile(
            title: 'Benachrichtigungen',
            icon: Icons.notifications,
            subtitle: 'Keine neuen Benachrichtigungen',
          ),
        ],
      ),
    );
  }
}

class DashboardListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final String subtitle;

  const DashboardListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  State<DashboardListTile> createState() => _DashboardListTileState();
}

class _DashboardListTileState extends State<DashboardListTile> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ListTile(
        leading: Icon(widget.icon, size: 32, color: AppColors.darkPurple,),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkPurple),
        ),
        subtitle: Text(
          widget.subtitle,
          style: const TextStyle(color: AppColors.darkPurple),
          ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Functionality will be added later
        },
      ),
    );
  }
}