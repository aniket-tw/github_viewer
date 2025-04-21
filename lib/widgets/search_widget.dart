import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/github_controller.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final GitHubController controller = Get.find<GitHubController>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {}); // Rebuild when focus changes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                focusNode: _focusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter GitHub username',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  controller.searchUsername.value = value;
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.searchUser(value);
                  }
                },
              ),
              if (_focusNode.hasFocus && 
                  controller.searchUsername.value.isNotEmpty && 
                  controller.searchHistory.isNotEmpty)
                _buildSuggestions(),
            ],
          ),
        ),
        _buildStatus(),
      ],
    );
  }

  Widget _buildSuggestions() {
    return Obx(() {
      final suggestions = controller.searchHistory
          .where((username) => username
              .toLowerCase()
              .contains(controller.searchUsername.value.toLowerCase()))
          .toList();

      if (suggestions.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final username = suggestions[index];
            return ListTile(
              leading: const Icon(
                Icons.history,
                color: Colors.grey,
                size: 20,
              ),
              title: Text(
                username,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                _textController.text = username;
                controller.searchUsername.value = username;
                controller.searchUser(username);
                _focusNode.unfocus();
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildStatus() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.error.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            controller.error.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
} 