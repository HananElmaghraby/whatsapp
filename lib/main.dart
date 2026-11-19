import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Color green = const Color(0xFF168C4B);
  final Color grayBubble = const Color(0xFF232D36);
  final Color darkBg = const Color(0xFF181818);
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {
      'text':
          "Hey! Have you ever thought about how random moments can sometimes turn into the best memories? It's like the universe loves to surprise us when we least expect it!",
      'isMe': false,
    },
    {'text': 'Hello!', 'isMe': true},
  ];

  void sendMessage() {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isMe': true});
    });
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,

      appBar: AppBar(
        backgroundColor: green,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/profile_image.png'),
            ),
            SizedBox(width: 10),
            Text(
              'John Safwat',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        actions: [
          _assetIcon('Phone', size: 24),
          const SizedBox(width: 12),
          _assetIcon('video', size: 24),
          const SizedBox(width: 12),
          _assetIcon('More-vertical', size: 24),
          const SizedBox(width: 8),
        ],
      ),

      body: DecoratedBox(
        decoration: BoxDecoration(
          color: darkBg,
          image: DecorationImage(
            image: const AssetImage('lib/assets/background_pattern.png'),
            fit: BoxFit.cover,
            opacity: 0.18,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return buildBubble(
                    messages[index]['text'],
                    messages[index]['isMe'],
                  );
                },
              ),
            ),
            buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _assetIcon(String name, {double size = 22}) {
    return SvgPicture.asset(
      'lib/assets/icons/$name.svg',
      width: size,
      height: size,
    );
  }

  Widget buildBubble(String text, bool isMe) {
    return Row(
      mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          width: 260,
          decoration: BoxDecoration(
            color: isMe ? grayBubble : green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildInputBar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                border: Border.all(color: green),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _assetIcon('Camera'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: _assetIcon('Send'),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: green,
              shape: BoxShape.circle,
            ),
            child: _assetIcon('Mic', size: 24),
          ),
        ],
      ),
    );
  }
}