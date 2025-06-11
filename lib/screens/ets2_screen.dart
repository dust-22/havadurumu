import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ets2_provider.dart';

class ETS2Screen extends StatelessWidget {
  const ETS2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ets2 = Provider.of<ETS2Provider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ETS2 Buton Box"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Yeni Buton Ekle",
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _AddETS2ButtonDialog(),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
            return GridView.builder(
              itemCount: ets2.buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final btn = ets2.buttons[index];
                return Stack(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Burası ileride bağlantı fonksiyonu ile tetiklenecek
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${btn.label} butonuna tıklandı!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
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
                        onTap: () => ets2.removeButton(index),
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
    );
  }
}

class _AddETS2ButtonDialog extends StatefulWidget {
  @override
  State<_AddETS2ButtonDialog> createState() => _AddETS2ButtonDialogState();
}

class _AddETS2ButtonDialogState extends State<_AddETS2ButtonDialog> {
  String label = "";
  IconData? selectedIcon;

  final List<IconData> iconOptions = [
    Icons.arrow_upward,
    Icons.arrow_downward,
    Icons.arrow_back,
    Icons.arrow_forward,
    Icons.stop,
    Icons.campaign,
    Icons.lightbulb,
    Icons.warning_amber_rounded,
    Icons.directions_car,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Yeni Buton Ekle"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(labelText: "Buton Adı"),
            onChanged: (val) => setState(() => label = val),
          ),
          const SizedBox(height: 16),
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("İptal"),
        ),
        ElevatedButton(
          onPressed: label.isNotEmpty && selectedIcon != null
              ? () {
                  Provider.of<ETS2Provider>(context, listen: false)
                      .addButton(label, selectedIcon!);
                  Navigator.pop(context);
                }
              : null,
          child: const Text("Ekle"),
        ),
      ],
    );
  }
}