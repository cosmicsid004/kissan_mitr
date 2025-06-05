import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance.collection('messages').add({
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'sender': 'Ram',
    });
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFFCA),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 15),
            Text("Expert Chat"),
            const Spacer(),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('status').doc('expertOnline').snapshots(),
              builder: (context, snapshot) {
                bool online = false;
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  online = data['online'] == true;
                }
                return Row(
                  children: [
                    Icon(
                      online ? Icons.circle : Icons.circle_outlined,
                      color: online ? Colors.green.shade800 : Colors.red,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      online ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: online ? Colors.green.shade800 : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFF84AE92),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '[${data['sender'] ?? 'unknown'}] ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (data['sender'] == 'web') ? Color(0xFF1976d2) : Color(0xFF388e3c),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                data['text'] ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: _sendMessage,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
