import 'package:flutter/material.dart';

class QueueService {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final String codePrefix;
  final int currentQueueLength;
  final int avgWaitPerPerson;

  const QueueService({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.codePrefix,
    required this.currentQueueLength,
    required this.avgWaitPerPerson,
  });

  static List<QueueService> defaultServices() {
    return const [
      QueueService(
        id: 'library',
        name: 'Library',
        subtitle: 'Grab a digital token — no more standing in line.',
        icon: Icons.menu_book_rounded,
        codePrefix: 'LIBRARY A',
        currentQueueLength: 3,
        avgWaitPerPerson: 3,
      ),
      QueueService(
        id: 'canteen',
        name: 'Canteen',
        subtitle: 'Grab a digital token — no more standing in line.',
        icon: Icons.restaurant_rounded,
        codePrefix: 'CANTEEN C',
        currentQueueLength: 7,
        avgWaitPerPerson: 2,
      ),
      QueueService(
        id: 'club_office',
        name: 'Club Office',
        subtitle: 'Grab a digital token — no more standing in line.',
        icon: Icons.groups_rounded,
        codePrefix: 'CLUB O',
        currentQueueLength: 2,
        avgWaitPerPerson: 4,
      ),
      QueueService(
        id: 'admin_office',
        name: 'Administrative Office',
        subtitle: 'Grab a digital token — no more standing in line.',
        icon: Icons.account_balance_rounded,
        codePrefix: 'ADMIN D',
        currentQueueLength: 5,
        avgWaitPerPerson: 5,
      ),
      QueueService(
        id: 'study_room',
        name: 'Study Room',
        subtitle: 'Grab a digital token — no more standing in line.',
        icon: Icons.laptop_chromebook_rounded,
        codePrefix: 'STUDY S',
        currentQueueLength: 4,
        avgWaitPerPerson: 3,
      ),
    ];
  }
}

class QueueToken {
  final String id;
  final String serviceName;
  final String tokenCode;
  final String issuedTime;
  int peopleAhead;
  int estimatedWaitMinutes;
  bool notifyBeforeTurn;

  QueueToken({
    required this.id,
    required this.serviceName,
    required this.tokenCode,
    required this.issuedTime,
    required this.peopleAhead,
    required this.estimatedWaitMinutes,
    this.notifyBeforeTurn = true,
  });
}
