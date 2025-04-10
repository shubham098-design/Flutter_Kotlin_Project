import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/user_provider.dart';
import '../../order/screens/order_screen.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account-screen';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch user data when screen is loaded.
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: userProvider.user == null
          ? Center(child: CircularProgressIndicator()) // Loading indicator if user is null
          : Column(
        children: [
          // Profile Section with Hero Animation
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Hero(
                  tag: "profilePic",
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/person.png'), // Use NetworkImage if needed
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userProvider.user!.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 5),
                Text(
                  userProvider.user!.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, EditProfileScreen.routeName);
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Account Options with Cards
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                AccountOptionCard(
                  icon: Icons.shopping_cart,
                  title: "Order History",
                  subtitle: "View your past orders",
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, OrderScreen.routeName);
                  },
                ),
                AccountOptionCard(
                  icon: Icons.favorite,
                  title: "Wishlist",
                  subtitle: "View your saved items",
                  color: Colors.redAccent,
                  onTap: () {},
                ),
                AccountOptionCard(
                  icon: Icons.settings,
                  title: "Settings",
                  subtitle: "Manage account settings",
                  color: Colors.blue,
                  onTap: () {},
                ),
                SizedBox(height: 10),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Logout Functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Account Option Card Widget
class AccountOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  AccountOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
