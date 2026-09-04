import 'package:flutter/material.dart';
import 'models/book.dart';

// Simple Model for Queue Ticket
class QueueTicket {
  final String ticketNumber;
  final String bookTitle;
  final String nowServing;
  final int yourPosition;
  final int peopleAhead;
  final int peopleBehind;
  final int estimatedWaitMinutes;
  final String issueTime;

  QueueTicket({
    required this.ticketNumber,
    required this.bookTitle,
    required this.nowServing,
    required this.yourPosition,
    required this.peopleAhead,
    required this.peopleBehind,
    required this.estimatedWaitMinutes,
    required this.issueTime,
  });
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All'; // 'All', 'Available', 'CSE'

  // Mock Active Queue Ticket (Default e akta active ticket thakbe so user sorasori dekhte pare)
  QueueTicket? _activeTicket = QueueTicket(
    ticketNumber: 'A-027',
    bookTitle: 'Introduction to Algorithms',
    nowServing: 'A-015',
    yourPosition: 12,
    peopleAhead: 11,
    peopleBehind: 8,
    estimatedWaitMinutes: 15,
    issueTime: '10:30 AM',
  );

  // Mock Books Data
  final List<Book> _books = const [
    Book(
      id: 'b1',
      title: 'Introduction to Algorithms',
      author: 'Thomas H. Cormen, Charles E. Leiserson',
      category: 'CSE',
      status: 'Available',
      totalCopies: 6,
      availableCopies: 4,
    ),
    Book(
      id: 'b2',
      title: 'Database System Concepts',
      author: 'Abraham Silberschatz, Henry F. Korth',
      category: 'CSE',
      status: 'Available',
      totalCopies: 5,
      availableCopies: 2,
    ),
    Book(
      id: 'b3',
      title: 'Operating System Concepts',
      author: 'Silberschatz, Galvin, Gagne',
      category: 'CSE',
      status: 'Unavailable',
      totalCopies: 4,
      availableCopies: 0,
    ),
    Book(
      id: 'b4',
      title: 'Computer Networks',
      author: 'Andrew S. Tanenbaum',
      category: 'CSE',
      status: 'Ready for Collection',
      totalCopies: 4,
      availableCopies: 1,
    ),
    Book(
      id: 'b5',
      title: 'Artificial Intelligence: A Modern Approach',
      author: 'Stuart Russell, Peter Norvig',
      category: 'CSE',
      status: 'Available',
      totalCopies: 3,
      availableCopies: 3,
    ),
    Book(
      id: 'b6',
      title: 'Engineering Circuit Analysis',
      author: 'William H. Hayt, Jack Kemmerly',
      category: 'EEE',
      status: 'Reserved',
      totalCopies: 4,
      availableCopies: 1,
    ),
  ];

  // Filtered books list
  List<Book> get _filteredBooks {
    return _books.where((book) {
      final matchesSearch = book.title
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      if (_selectedFilter == 'Available') {
        return book.status == 'Available' ||
            book.status == 'Ready for Collection';
      } else if (_selectedFilter == 'CSE') {
        return book.category == 'CSE';
      }
      return true;
    }).toList();
  }

  // 1. Get Queue Ticket Function
  void _takeQueueTicket(Book book) {
    if (!book.isAvailableForQueue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${book.title} is currently unavailable for queue!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _activeTicket = QueueTicket(
        ticketNumber: 'A-${(28 + (_activeTicket == null ? 0 : 1)).toString().padLeft(3, '0')}',
        bookTitle: book.title,
        nowServing: 'A-015',
        yourPosition: 13,
        peopleAhead: 12,
        peopleBehind: 0,
        estimatedWaitMinutes: 18,
        issueTime: 'Just Now',
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Queue Ticket ${_activeTicket!.ticketNumber} issued for ${book.title}!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // 2. Cancel Queue Ticket Function with Dialog
  void _confirmCancelTicket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Queue Ticket'),
        content: const Text(
            'Are you sure you want to cancel your queue ticket? You will lose your current spot in line.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Ticket'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _activeTicket = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Queue ticket cancelled successfully.'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Cancel Ticket'),
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
        title: const Text(
          'Library Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. Library Status Card (Open/Closed & Hours)
            _buildStatusCard(),

            const SizedBox(height: 16),

            // ২. Available Seating Space Card
            _buildSeatingCard(),

            const SizedBox(height: 20),

            // ৩. My Active Queue Section
            _buildActiveQueueSection(),

            const SizedBox(height: 25),

            // ৪. Check Book Availability & Search Header
            const Text(
              'Check Book Availability',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Search Box
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by book title or author...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Filter Chips
            Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Available'),
                const SizedBox(width: 8),
                _buildFilterChip('CSE'),
              ],
            ),

            const SizedBox(height: 15),

            // Book Cards List
            if (_filteredBooks.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text(
                      'No books found matching "$_searchQuery"',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            else
              ..._filteredBooks.map((book) => _buildBookCard(book)),
          ],
        ),
      ),
    );
  }

  // --- Widget Components (Sir ke explain kora khub shohoj) ---

  // ১. Status Card: Open/Closed & Hours
  Widget _buildStatusCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.account_balance, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'CENTRAL LIBRARY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                // Open status badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Open Now',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.access_time, color: Colors.white70, size: 16),
                SizedBox(width: 6),
                Text(
                  'Hours: 8:00 AM - 8:00 PM (Sun - Thu)',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.white70, size: 16),
                SizedBox(width: 6),
                Text(
                  'Building 3, 2nd Floor',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ২. Seating Space Card (Total: 100, Occupied: 58, Available: 42)
  Widget _buildSeatingCard() {
    const int totalSeats = 100;
    const int occupiedSeats = 58;
    const int availableSeats = 42;
    const double occupancyRatio = occupiedSeats / totalSeats;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.chair, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Available Seats',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '$availableSeats / $totalSeats Available',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: occupancyRatio,
                minHeight: 10,
                backgroundColor: Colors.green.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
              ),
            ),

            const SizedBox(height: 14),

            // Details Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSeatStatItem('Total Seats', '$totalSeats', Colors.black87),
                Container(height: 24, width: 1, color: Colors.grey.shade300),
                _buildSeatStatItem('Occupied', '$occupiedSeats', Colors.red.shade700),
                Container(height: 24, width: 1, color: Colors.grey.shade300),
                _buildSeatStatItem('Available', '$availableSeats', Colors.green.shade700),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  // ৩. My Active Queue Section
  Widget _buildActiveQueueSection() {
    if (_activeTicket == null) {
      return Card(
        elevation: 1,
        color: Colors.green.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Colors.green.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: const Icon(Icons.confirmation_number, color: Colors.green),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Active Queue Ticket',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Select an available book below to get an online queue ticket!',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final ticket = _activeTicket!;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.green, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Ticket Title and Cancel Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'TICKET #${ticket.ticketNumber}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: const Text(
                        'In Queue',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: _confirmCancelTicket,
                  icon: const Icon(Icons.cancel_outlined, size: 18),
                  label: const Text('Cancel', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Book Name
            Text(
              'Book: ${ticket.bookTitle}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 14),

            // 4 Metrics Grid (Now Serving, Your Position, People Ahead, Est. Wait)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQueueMetric('Now Serving', ticket.nowServing, Colors.blue.shade700),
                  Container(height: 30, width: 1, color: Colors.grey.shade300),
                  _buildQueueMetric('Your Position', '#${ticket.yourPosition}', Colors.green.shade800),
                  Container(height: 30, width: 1, color: Colors.grey.shade300),
                  _buildQueueMetric('People Ahead', '${ticket.peopleAhead}', Colors.orange.shade800),
                  Container(height: 30, width: 1, color: Colors.grey.shade300),
                  _buildQueueMetric('Est. Wait', '${ticket.estimatedWaitMinutes}m', Colors.black87),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Notice badge
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.green.shade700),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'You will be notified when only 3 people are ahead of you.',
                    style: TextStyle(fontSize: 12, color: Colors.green.shade900),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueMetric(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }

  // ৪. Filter Chip Widget
  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.green,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
      backgroundColor: Colors.white,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
    );
  }

  // ৫. Book Card Widget
  Widget _buildBookCard(Book book) {
    // Determine status color and text
    Color statusBgColor;
    Color statusTextColor;
    String statusText = book.status;

    switch (book.status) {
      case 'Available':
        statusBgColor = Colors.green.shade50;
        statusTextColor = Colors.green.shade800;
        break;
      case 'Ready for Collection':
        statusBgColor = Colors.blue.shade50;
        statusTextColor = Colors.blue.shade800;
        break;
      case 'Reserved':
        statusBgColor = Colors.orange.shade50;
        statusTextColor = Colors.orange.shade800;
        break;
      case 'Unavailable':
      default:
        statusBgColor = Colors.red.shade50;
        statusTextColor = Colors.red.shade800;
        statusText = 'Currently Unavailable';
        break;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status Chip Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade50,
                  radius: 20,
                  child: const Icon(Icons.menu_book, color: Colors.green, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book.author,
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Category and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    book.category,
                    style: const TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusTextColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Available Copies & Action Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Copies: ${book.availableCopies}/${book.totalCopies}',
                  style: TextStyle(
                    fontSize: 12,
                    color: book.availableCopies > 0 ? Colors.black87 : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Button to Take Queue Ticket
                if (book.isAvailableForQueue)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _takeQueueTicket(book),
                    icon: const Icon(Icons.confirmation_number_outlined, size: 16),
                    label: const Text(
                      'Get Queue Ticket',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You will be notified when "${book.title}" is returned!'),
                        ),
                      );
                    },
                    child: const Text('Notify Me', style: TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
