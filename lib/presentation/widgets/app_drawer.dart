import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // 1. THE HEADER (Your Details)
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Matches your App Theme
              image: DecorationImage(
                image: NetworkImage(
                  // A nice abstract background image for the header
                  "https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=2029&auto=format&fit=crop",
                ),
                fit: BoxFit.cover,
                opacity: 0.9, // Slight transparency to make text readable
              ),
            ),
            accountName: const Text(
              "Jahid",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: const Text(
              "Flutter Developer",
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blue),
                // If you have a real photo, use this instead:
                // backgroundImage: NetworkImage("YOUR_PHOTO_URL"),
              ),
            ),
          ),

          // 2. DRAWER ITEMS
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context), // Close drawer
          ),
          ListTile(
            leading: const Icon(Icons.local_fire_department),
            title: const Text("Top Deals"),
            onTap: () {
              // Add navigation logic here if needed
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Saved"),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(), // Visual separator
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => Navigator.pop(context),
          ),

          // Spacer pushes the "About" section to the bottom
          const Spacer(),

          // 3. FOOTER
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("App v1.0.0", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
