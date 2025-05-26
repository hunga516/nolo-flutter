import 'package:flutter/material.dart';
import '../../data/models/live_stream_model.dart';
import '../../data/services/live_stream_service.dart';

class LiveStreamPage extends StatelessWidget {
  const LiveStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Thanh đăng nhập & tìm kiếm
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm ...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Breadcrumb
          Row(
            children: const [
              Text('Trang chủ', style: TextStyle(color: Colors.grey)),
              Icon(Icons.chevron_right, size: 16, color: Colors.grey),
              Text('...', style: TextStyle(color: Colors.grey)),
              Icon(Icons.chevron_right, size: 16, color: Colors.grey),
              Text('Cửa hàng', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 24),
          // Nút phát trực tuyến
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.wifi_tethering, color: Colors.white),
            label: const Text('Phát trực tuyến', style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Đang trực tuyến',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 16),
          // Grid các live stream (fetch từ API)
          FutureBuilder<List<LiveStreamModel>>(
            future: LiveStreamService().fetchLiveStreams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text('Lỗi: ${snapshot.error}'));
              }
              final streams = snapshot.data ?? [];
              if (streams.isEmpty) {
                return const Center(child: Text('Không có live stream nào.'));
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: streams.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  final item = streams[index];
                  return LiveStreamGridItem(item: item);
                },
              );
            },
          ),
          const SizedBox(height: 24),
          // Avatar user góc dưới
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.black,
                child: const Text('N', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LiveStreamGridItem extends StatelessWidget {
  final LiveStreamModel item;
  const LiveStreamGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.isActive ? Colors.grey[400] : Colors.red[400],
        borderRadius: BorderRadius.circular(14),
        image: item.thumbnail != null
            ? DecorationImage(
                image: NetworkImage(item.thumbnail!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (item.thumbnail == null)
            const Icon(Icons.campaign, color: Colors.white70, size: 36),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                item.duration ?? '0:00',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
