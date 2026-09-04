import 'package:flutter/material.dart';
import 'models/book.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Map<String, dynamic>? _ticket = {
    'number': 'A-027',
    'book': 'Introduction to Algorithms',
    'serving': 'A-015',
    'position': 12,
    'ahead': 11,
    'wait': '15 mins',
  };

  final List<Book> _books = const [
    Book('Introduction to Algorithms', 'Thomas H. Cormen', 'Available', 4),
    Book('Database System Concepts', 'Abraham Silberschatz', 'Available', 2),
    Book('Operating System Concepts', 'Abraham Silberschatz', 'Unavailable', 0),
    Book('Computer Networks', 'Andrew S. Tanenbaum', 'Ready for Collection', 1),
    Book('Artificial Intelligence', 'Stuart Russell', 'Available', 3),
  ];

  List<Book> get _filteredBooks {
    return _books.where((b) {
      final q = _searchQuery.toLowerCase();
      return b.title.toLowerCase().contains(q) || b.author.toLowerCase().contains(q);
    }).toList();
  }

  void _getTicket(Book book) {
    if (book.status == 'Unavailable') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${book.title} is currently unavailable!')),
      );
      return;
    }
    setState(() {
      _ticket = {
        'number': 'A-028',
        'book': book.title,
        'serving': 'A-015',
        'position': 13,
        'ahead': 12,
        'wait': '18 mins',
      };
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ticket ${_ticket!['number']} issued for ${book.title}!'), backgroundColor: Colors.green),
    );
  }

  void _cancelTicket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Ticket'),
        content: const Text('Are you sure you want to cancel your queue ticket?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              setState(() => _ticket = null);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ticket cancelled successfully.')),
              );
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Library Services', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.green.shade800,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CENTRAL LIBRARY', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Hours: 8:00 AM - 8:00 PM', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                    Text('● Open Now', style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Seats', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('42 / 100 Available', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: 0.58,
                        minHeight: 8,
                        backgroundColor: Colors.green.shade100,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Total: 100  |  Occupied: 58  |  Available: 42', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (_ticket != null)
              Card(
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.green)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TICKET #${_ticket!['number']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                          TextButton(
                            onPressed: _cancelTicket,
                            child: const Text('Cancel Ticket', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                      Text('Book: ${_ticket!['book']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text('Now Serving: ${_ticket!['serving']}  |  Your Position: #${_ticket!['position']}'),
                      Text('People Ahead: ${_ticket!['ahead']}  |  Est. Wait: ${_ticket!['wait']}', style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    ],
                  ),
                ),
              )
            else
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text('No active ticket. Tap "Get Ticket" on any book below to join queue.', style: TextStyle(color: Colors.black54)),
                ),
              ),
            const SizedBox(height: 20),

            const Text('Check Book Availability', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search book title or author...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),

            ..._filteredBooks.map((book) {
              final isAvailable = book.status != 'Unavailable';
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade50,
                    child: const Icon(Icons.menu_book, color: Colors.green),
                  ),
                  title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.author, style: const TextStyle(fontSize: 12)),
                      Text(book.status, style: TextStyle(color: isAvailable ? Colors.green : Colors.red, fontWeight: FontWeight.w600, fontSize: 12)),
                    ],
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAvailable ? Colors.green : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onPressed: () => _getTicket(book),
                    child: Text(isAvailable ? 'Get Ticket' : 'Unavailable', style: const TextStyle(fontSize: 12)),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
