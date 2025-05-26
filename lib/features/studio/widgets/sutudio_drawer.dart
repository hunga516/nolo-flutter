import 'package:flutter/material.dart';

class StudioDrawer extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final String? selectedRoute;
  final Function(String route)? onSelect;

  const StudioDrawer({
    super.key,
    required this.userName,
    required this.avatarUrl,
    this.selectedRoute,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Logo & tên studio
            Row(
              children: const [
                Icon(Icons.star, size: 32, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'NOLO Studio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Avatar & tên user
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                    radius: 36,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quản lý nội dung của bạn',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Dashboard
            _StudioDrawerItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              selected: selectedRoute == 'dashboard',
              onTap: () => onSelect?.call('dashboard'),
            ),
            // Nội dung của bạn
            _StudioDrawerItem(
              icon: Icons.ondemand_video,
              label: 'Nội dung của bạn',
              selected: selectedRoute == 'content',
              onTap: () => onSelect?.call('content'),
            ),
            // Trở về community
            const SizedBox(height: 16),
            _StudioDrawerItem(
              icon: Icons.logout,
              label: 'Trở về Nolo Community',
              selected: false,
              onTap: () => onSelect?.call('community'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudioDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _StudioDrawerItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.grey[200] : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(label, style: const TextStyle(fontSize: 16)),
        onTap: onTap,
        selected: selected,
        selectedTileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
