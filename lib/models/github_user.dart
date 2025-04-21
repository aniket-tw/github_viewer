class GitHubUser {
  final String login;
  final String avatarUrl;
  final String name;
  final String bio;
  final String location;
  final String blog;
  final int publicRepos;
  final int followers;
  final int following;
  final String htmlUrl;

  GitHubUser({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.location,
    required this.blog,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.htmlUrl,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'] ?? 'Not Available',
      bio: json['bio'] ?? 'No bio available',
      location: json['location'] ?? 'Location not specified',
      blog: json['blog'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      htmlUrl: json['html_url'] ?? '',
    );
  }
} 