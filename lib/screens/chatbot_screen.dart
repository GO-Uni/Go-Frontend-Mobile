import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/providers/chatbot_provider.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_frontend_mobile/widgets/discover_dialog.dart';
import 'package:provider/provider.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  bool _dialogShown = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadUserIfNeeded();
  }

  Future<void> _loadUserIfNeeded() async {
    final profileProvider = context.read<ProfileProvider>();
    if (profileProvider.user == null) {
      await profileProvider.loadAuthenticatedUser();
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isGuest = context.read<AuthProvider>().isGuest;

    if (isGuest && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => const DiscoverDialog(),
          );
        }
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() async {
    final userMessage = _textController.text.trim();
    if (userMessage.isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
      _messages.add({"sender": "user", "message": userMessage});
      _textController.clear();
      _messages.add({"sender": "bot", "message": "typing..."});
    });
    _scrollToBottom();

    try {
      await context.read<ChatbotProvider>().loadChatbotMessage(userMessage);

      if (mounted) {
        setState(() {
          _messages.removeLast();
          _messages.add({
            "sender": "bot",
            "message": context.read<ChatbotProvider>().message!,
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add({
          "sender": "bot",
          "message": "⚠️ Failed to get response.",
        });
      });
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";
                return _buildMessageBubble(message["message"]!, isUser);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.mediumGray,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (_) => _sendMessage(),
                      minLines: 2,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Type here...",
                        border: InputBorder.none,
                        hintStyle: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.lightGray,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 26,
                      ),
                      padding: const EdgeInsets.all(16),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isUser) {
    final isTyping = message.toLowerCase() == "typing...";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/images/chatbot.svg',
                  width: 43,
                  height: 43,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.navyGray,
              borderRadius: BorderRadius.circular(20),
            ),
            constraints: const BoxConstraints(maxWidth: 250),
            child: Text(
              isTyping ? "Chatbot is typing..." : message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isTyping ? Colors.white70 : Colors.white,
                fontStyle: isTyping ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
          if (isUser)
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Builder(
                builder: (context) {
                  final user =
                      Provider.of<ProfileProvider>(context, listen: false).user;
                  final initial =
                      (user?.name.isNotEmpty == true)
                          ? user!.name[0].toUpperCase()
                          : "";
                  final profileImg = user?.profileImg;

                  return CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primary,
                    backgroundImage:
                        (profileImg != null && profileImg.isNotEmpty)
                            ? NetworkImage(profileImg)
                            : null,
                    child:
                        (profileImg == null || profileImg.isEmpty)
                            ? Text(
                              initial,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white,
                              ),
                            )
                            : null,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
