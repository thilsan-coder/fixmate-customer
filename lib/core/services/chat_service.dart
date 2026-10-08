enum MessageType { text, image, location }

class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isMe;
  final MessageType type;
  final String? imageUrl;
  final String? locationName;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.type = MessageType.text,
    this.imageUrl,
    this.locationName,
  });
}

class ChatThread {
  final String workerName;
  final String workerRole;
  final String workerAvatarUrl;
  final String serviceName;
  final bool isOnline;
  final int unreadCount;
  final List<ChatMessage> messages;

  const ChatThread({
    required this.workerName,
    required this.workerRole,
    required this.workerAvatarUrl,
    required this.serviceName,
    this.isOnline = true,
    this.unreadCount = 0,
    required this.messages,
  });

  ChatMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;

  ChatThread copyWith({
    String? workerName,
    String? workerRole,
    String? workerAvatarUrl,
    String? serviceName,
    bool? isOnline,
    int? unreadCount,
    List<ChatMessage>? messages,
  }) {
    return ChatThread(
      workerName: workerName ?? this.workerName,
      workerRole: workerRole ?? this.workerRole,
      workerAvatarUrl: workerAvatarUrl ?? this.workerAvatarUrl,
      serviceName: serviceName ?? this.serviceName,
      isOnline: isOnline ?? this.isOnline,
      unreadCount: unreadCount ?? this.unreadCount,
      messages: messages ?? this.messages,
    );
  }
}

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  static final List<ChatThread> _threads = [
    ChatThread(
      workerName: 'Marcus Chen',
      workerRole: 'Cleaning Specialist',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&fit=crop&q=80',
      serviceName: 'Home Deep Cleaning',
      isOnline: true,
      unreadCount: 2,
      messages: [
        const ChatMessage(
          id: 'm1',
          text: "Hello! I am on my way to your location with all the cleaning supplies.",
          time: '10:15 AM',
          isMe: false,
        ),
        const ChatMessage(
          id: 'm2',
          text: "Great! Let me know once you are near the security gate.",
          time: '10:18 AM',
          isMe: true,
        ),
        const ChatMessage(
          id: 'm3',
          text: "I have arrived at the building entrance. Can you buzz me in?",
          time: '10:28 AM',
          isMe: false,
        ),
      ],
    ),
    ChatThread(
      workerName: 'Sarah Jenkins',
      workerRole: 'Certified Electrician',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&fit=crop&q=80',
      serviceName: 'Light & Fan Installation',
      isOnline: true,
      unreadCount: 0,
      messages: [
        const ChatMessage(
          id: 's1',
          text: "Hi Alex! The main circuit breaker replacement is complete.",
          time: '09:30 AM',
          isMe: false,
        ),
        const ChatMessage(
          id: 's2',
          text: "All fans and lights have been tested and verified safe.",
          time: '09:31 AM',
          isMe: false,
        ),
        const ChatMessage(
          id: 's3',
          text: "Thank you so much Sarah! The lights work perfectly now.",
          time: '09:35 AM',
          isMe: true,
        ),
      ],
    ),
    ChatThread(
      workerName: 'David Wilson',
      workerRole: 'Licensed Plumber',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&fit=crop&q=80',
      serviceName: 'Pipe Repair & Leak Fix',
      isOnline: false,
      unreadCount: 1,
      messages: [
        const ChatMessage(
          id: 'd1',
          text: "Hello, I have confirmed the booking for tomorrow at 2:00 PM.",
          time: 'Yesterday',
          isMe: false,
        ),
        const ChatMessage(
          id: 'd2',
          text: "Please make sure the main water valve is accessible.",
          time: 'Yesterday',
          isMe: false,
        ),
      ],
    ),
    ChatThread(
      workerName: 'Kamal Perera',
      workerRole: 'Master Carpenter',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&fit=crop&q=80',
      serviceName: 'Furniture Repair',
      isOnline: true,
      unreadCount: 0,
      messages: [
        const ChatMessage(
          id: 'k1',
          text: "I have the wood polish and replacement hinges ready for the door fix.",
          time: 'Oct 23',
          isMe: false,
        ),
        const ChatMessage(
          id: 'k2',
          text: "Sounds good, see you on Saturday!",
          time: 'Oct 23',
          isMe: true,
        ),
      ],
    ),
    ChatThread(
      workerName: 'FixMate Support',
      workerRole: 'Official Help Desk',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&fit=crop&q=80',
      serviceName: 'Customer Support 24/7',
      isOnline: true,
      unreadCount: 0,
      messages: [
        const ChatMessage(
          id: 'sup1',
          text: "Welcome to FixMate! How can our customer care team assist you today?",
          time: 'Oct 20',
          isMe: false,
        ),
      ],
    ),
  ];

  static List<ChatThread> get threads => List.unmodifiable(_threads);

  static ChatThread getOrCreateThread({
    required String workerName,
    required String workerRole,
    required String avatarUrl,
    String serviceName = 'Service Request',
  }) {
    final existingIndex = _threads.indexWhere(
      (t) => t.workerName.toLowerCase() == workerName.toLowerCase(),
    );

    if (existingIndex != -1) {
      return _threads[existingIndex];
    }

    final newThread = ChatThread(
      workerName: workerName,
      workerRole: workerRole,
      workerAvatarUrl: avatarUrl,
      serviceName: serviceName,
      isOnline: true,
      unreadCount: 0,
      messages: [
        ChatMessage(
          id: 'init_${DateTime.now().millisecondsSinceEpoch}',
          text: "Hello! I am assigned to your $serviceName. How can I help you?",
          time: _getCurrentFormattedTime(),
          isMe: false,
        ),
      ],
    );

    _threads.insert(0, newThread);
    return newThread;
  }

  static void sendMessage({
    required String workerName,
    required String text,
    MessageType type = MessageType.text,
    String? imageUrl,
    String? locationName,
  }) {
    final threadIndex = _threads.indexWhere(
      (t) => t.workerName.toLowerCase() == workerName.toLowerCase(),
    );

    final newMessage = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      time: _getCurrentFormattedTime(),
      isMe: true,
      type: type,
      imageUrl: imageUrl,
      locationName: locationName,
    );

    if (threadIndex != -1) {
      final oldThread = _threads[threadIndex];
      final updatedMessages = List<ChatMessage>.from(oldThread.messages)..add(newMessage);
      final updatedThread = oldThread.copyWith(messages: updatedMessages, unreadCount: 0);

      // Move updated thread to top of inbox
      _threads.removeAt(threadIndex);
      _threads.insert(0, updatedThread);
    }
  }

  static void markAsRead(String workerName) {
    final index = _threads.indexWhere(
      (t) => t.workerName.toLowerCase() == workerName.toLowerCase(),
    );
    if (index != -1) {
      _threads[index] = _threads[index].copyWith(unreadCount: 0);
    }
  }

  static String _getCurrentFormattedTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}
