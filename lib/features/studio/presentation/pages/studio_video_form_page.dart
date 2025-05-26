import 'package:flutter/material.dart';
import '../../data/services/studio_video_service.dart';

class StudioVideoFormPage extends StatefulWidget {
  final Map<String, dynamic>? initialData; // null nếu là tạo mới
  const StudioVideoFormPage({super.key, this.initialData});

  @override
  State<StudioVideoFormPage> createState() => _StudioVideoFormPageState();
}

class _StudioVideoFormPageState extends State<StudioVideoFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _videoUrlController;
  String? _thumbnail;
  String? _category;
  String? _visibility = 'Công khai';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialData?['title'] ?? '');
    _descController = TextEditingController(text: widget.initialData?['description'] ?? '');
    _videoUrlController = TextEditingController(text: widget.initialData?['videoUrl'] ?? '');
    _thumbnail = widget.initialData?['thumbnail'];
    _category = widget.initialData?['category'];
    _visibility = widget.initialData?['visibility'] ?? 'Công khai';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'title': _titleController.text,
      'description': _descController.text,
      'videoUrl': _videoUrlController.text,
      'thumbnail': _thumbnail,
      'category': _category,
      'visibility': _visibility,
    };
    try {
      await StudioVideoService().createOrUpdateVideo(
        data,
        id: widget.initialData?['_id'],
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lưu thành công!')));
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.menu, size: 28),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Thông tin video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Lưu'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload, color: Colors.black),
                label: const Text('Tải lên', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                radius: 20,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Quản lý video của bạn',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          // Form
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề
                const Text('Tiêu đề', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.auto_fix_high),
                      onPressed: () {},
                    ),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Không được để trống' : null,
                ),
                const SizedBox(height: 16),
                // Mô tả
                const Text('Mô tả', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _descController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.auto_fix_high),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Thumbnail
                const Text('Thumbnail', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                _thumbnail != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(_thumbnail!, width: 120, height: 70, fit: BoxFit.cover),
                      )
                    : Container(
                        width: 120,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.image, size: 36, color: Colors.black),
                      ),
                const SizedBox(height: 16),
                // Danh mục
                const Text('Doanh mục', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: _category,
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Chọn danh mục')),
                    DropdownMenuItem(value: 'music', child: Text('Âm nhạc')),
                    DropdownMenuItem(value: 'game', child: Text('Game')),
                    DropdownMenuItem(value: 'life', child: Text('Đời sống')),
                  ],
                  onChanged: (v) => setState(() => _category = v),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                // Video player (giả lập)
                const Text('Video', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
                  ),
                ),
                const SizedBox(height: 16),
                // Đường dẫn video
                const Text('Đường dẫn video', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _videoUrlController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Trạng thái video
                const Text('Trạng thái video', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Sẵn sàng'),
                ),
                const SizedBox(height: 16),
                // Trạng thái phụ đề
                const Text('Trạng thái phụ đề', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Sẵn sàng'),
                ),
                const SizedBox(height: 16),
                // Chế độ hiển thị
                const Text('Chế độ hiển thị', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: _visibility,
                  items: const [
                    DropdownMenuItem(value: 'Công khai', child: Text('Công khai')),
                    DropdownMenuItem(value: 'Riêng tư', child: Text('Riêng tư')),
                  ],
                  onChanged: (v) => setState(() => _visibility = v),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
