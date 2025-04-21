import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_user.dart';

class GitHubService {
  static const String baseUrl = 'https://api.github.com';

  Future<GitHubUser> getUser(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));

    if (response.statusCode == 200) {
      return GitHubUser.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to load user data');
    }
  }
} 