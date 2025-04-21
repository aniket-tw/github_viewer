import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/github_user.dart';
import '../services/github_service.dart';

class GitHubController extends GetxController {
  final GitHubService _githubService = GitHubService();
  final Rx<GitHubUser?> user = Rx<GitHubUser?>(null);
  final RxString searchUsername = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxList<String> searchHistory = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('searchHistory') ?? [];
    searchHistory.value = history;
  }

  Future<void> saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', searchHistory);
  }

  Future<void> searchUser(String username) async {
    if (username.isEmpty) return;

    isLoading.value = true;
    error.value = '';

    try {
      final userData = await _githubService.getUser(username);
      user.value = userData;

      if (!searchHistory.contains(username)) {
        searchHistory.add(username);
        await saveSearchHistory();
      }
    } catch (e) {
      error.value = e.toString();
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
