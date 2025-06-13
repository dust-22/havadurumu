import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => profile.pickAvatar(context),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.blueGrey.shade100,
                backgroundImage: profile.avatar != null ? AssetImage(profile.avatar!) : null,
                child: profile.avatar == null
                    ? const Icon(Icons.person, size: 48)
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: TextEditingController(text: profile.username),
              decoration: const InputDecoration(labelText: "Kullanıcı Adı"),
              onChanged: (val) => profile.setUsername(val),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                profile.saveProfile();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profil kaydedildi!")),
                );
              },
              child: const Text("Kaydet"),
            )
          ],
        ),
      ),
    );
  }
}