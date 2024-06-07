import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _contacts = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addContact() {
    final String name = _nameController.text;
    final String phone = _phoneController.text;
    if (name.isNotEmpty && phone.isNotEmpty) {
      setState(() {
        _contacts.add({'name': name, 'phone': phone});
      });
      _nameController.clear();
      _phoneController.clear();
    }
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              setState(() {
                _contacts.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0), // Square border
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Contact',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0), // Square border
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addContact,
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 36),
                backgroundColor: Colors.grey,
                textStyle: TextStyle(
                  color: Colors.black
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0), // Square border
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      _contacts[index]['name']!,
                      style: TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(_contacts[index]['phone']!),
                    trailing: IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {},
                    ),
                    onTap: () => _deleteContact(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
