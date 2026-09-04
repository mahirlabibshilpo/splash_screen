// Simple Book Model for Library Prototype
// (Sir ke explain kora khub shohoj: Simple data class)

class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String status; // 'Available', 'Unavailable', 'Ready for Collection', 'Reserved'
  final int totalCopies;
  final int availableCopies;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.status,
    required this.totalCopies,
    required this.availableCopies,
  });

  // Helper to check if book can be requested for queue
  bool get isAvailableForQueue =>
      status == 'Available' || status == 'Ready for Collection';
}
