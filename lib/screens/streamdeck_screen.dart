class _AddStreamDeckButtonDialog extends StatefulWidget {
  @override
  State<_AddStreamDeckButtonDialog> createState() => _AddStreamDeckButtonDialogState();
}

class _AddStreamDeckButtonDialogState extends State<_AddStreamDeckButtonDialog> {
  String label = "";
  IconData? selectedIcon;
  Color selectedColor = Colors.blue;
  String command = "";

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
              onChanged: (val) {
                setState(() => label = val);
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: iconOptions.map((icon) {
                return ChoiceChip(
                  selected: selectedIcon == icon,
                  label: Icon(icon),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedIcon = icon;
                      }
                    });
                  },
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
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) selectedColor = color;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: "Komut (örn: notepad.exe, calc, custom_script.bat)",
                hintText: "Çalıştırılacak komut",
              ),
              onChanged: (val) => setState(() => command = val),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("İptal"),
        ),
        ElevatedButton(
          onPressed: label.trim().isNotEmpty && selectedIcon != null
              ? () {
                  Provider.of<StreamDeckProvider>(context, listen: false)
                      .addButton(StreamDeckButton(
                        label: label.trim(),
                        icon: selectedIcon!,
                        color: selectedColor,
                        command: command.trim().isNotEmpty ? command.trim() : null,
                      ));
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text("Ekle"),
        ),
      ],
    );
  }
}