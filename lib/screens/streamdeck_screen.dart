import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/streamdeck_provider.dart';

class StreamDeckScreen extends StatelessWidget {
  const StreamDeckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final streamDeck = Provider.of<StreamDeckProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream Deck"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Yeni Buton Ekle",
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _AddStreamDeckButtonDialog(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.library_add),
            tooltip: "Yeni Sayfa",
            onPressed: () => streamDeck.addPage(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
                  return GridView.builder(
                    itemCount: streamDeck.currentButtons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final btn = streamDeck.currentButtons[index];
                      return Stack(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Burası ileride komut/aksiyon fonksiyonu ile tetiklenecek
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${btn.label} butonuna tıklandı!")),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: btn.color,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(btn.icon, size: 36),
                                const SizedBox(height: 12),
                                Text(btn.label, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => streamDeck.removeButton(index),
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 14,
                                child: Icon(Icons.close, color: Colors.white, size: 18),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  tooltip: "Önceki Sayfa",
                  onPressed: streamDeck.currentPage > 0 ? streamDeck.prevPage : null,
                ),
                Text(
                  "Sayfa ${streamDeck.currentPage + 1}/${streamDeck.totalPages}",
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  tooltip: "Sonraki Sayfa",
                  onPressed: streamDeck.currentPage < streamDeck.totalPages - 1
                      ? streamDeck.nextPage
                      : null,
                ),
                if (streamDeck.totalPages > 1)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: "Sayfayı Sil",
                    onPressed: () => streamDeck.removePage(streamDeck.currentPage),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddStreamDeckButtonDialog extends StatefulWidget {
  @override
  State<_AddStreamDeckButtonDialog> createState() => _AddStreamDeckButtonDialogState();
}

class _AddStreamDeckButtonDialogState extends State<_AddStreamDeckButtonDialog> {
  String label = "";
  IconData? selectedIcon;
  Color selectedColor = Colors.blue;

  final List<IconData> iconOptions = [
    Icons.mic,
    Icons.videocam,
    Icons.camera,
    Icons.volume_up,
    Icons.volume_off,
    Icons.play_arrow,
    Icons.pause,
    Icons.stop,
    Icons.lightbulb,
    Icons.desktop_windows,
    Icons.link,
    Icons.settings,
  ];

  final List<Color> colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.pink,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Yeni Buton Ekle"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: "Buton Adı"),
              onChanged: (val) => setState(() => label = val),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: iconOptions.map((icon) {
                return ChoiceChip(
                  selected: selectedIcon == icon,
                  label: Icon(icon),
                  onSelected: (_) => setState(() => selectedIcon = icon),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: colorOptions.map((color) {
                return ChoiceChip(
                  selected: selectedColor == color,
                  label: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onSelected: (_) => setState(() => selectedColor = color),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("İptal"),
        ),
        ElevatedButton(
          onPressed: label.isNotEmpty && selectedIcon != null
              ? () {
                  Provider.of<StreamDeckProvider>(context, listen: false)
                      .addButton(StreamDeckButton(
                        label: label,
                        icon: selectedIcon!,
                        color: selectedColor,
                      ));
                  Navigator.pop(context);
                }
              : null,
          child: const Text("Ekle"),
        ),
      ],
    );
  }
}