import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Logo & tên app
            Row(
              children: const [
                Icon(Icons.star, size: 32, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'NOLO Community',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Nhóm 1
            const Text(
              'Cộng đồng và giao dịch',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text('Trang chủ'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.live_tv, color: Colors.black),
              title: const Text('Live Stream'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.public, color: Colors.black),
              title: const Text('Cộng đồng'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.show_chart, color: Colors.black),
              title: const Text('Xu hướng'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.black),
              title: const Text('Giao dịch'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.black),
              title: const Text('Hướng dẫn cài game'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.black),
              title: const Text('Hướng dẫn việc làm'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const SizedBox(height: 24),
            // Nhóm 2
            const Text(
              'Tiện ích',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.store, color: Colors.black),
              title: const Text('Cửa hàng'),
              trailing: const Icon(Icons.more_horiz),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit_note, color: Colors.black),
              title: const Text('Nhiệm vụ'),
              trailing: const Icon(Icons.more_horiz),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.map, color: Colors.black),
              title: const Text('Bản đồ thế giới'),
              trailing: const Icon(Icons.more_horiz),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.meeting_room, color: Colors.black),
              title: const Text('Meeting'),
              trailing: const Icon(Icons.more_horiz),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.more_horiz, color: Colors.black),
              title: const Text('More'),
              onTap: () {},
            ),
            const SizedBox(height: 24),
            // User cuối menu
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Text('N', style: TextStyle(color: Colors.white)),
              ),
              title: const Text('Taxi', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Thực tập'),
              trailing: const Icon(Icons.expand_more),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
