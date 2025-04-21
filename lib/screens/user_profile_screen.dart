import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/github_user.dart';

class UserProfileScreen extends StatelessWidget {
  final GitHubUser user;
  const UserProfileScreen({super.key, required this.user});

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            if (user.bio.isNotEmpty) _buildBio(),
            _buildOrganizationAndLocation(),
            if (user.blog.isNotEmpty) _buildBlogLink(),
            if (user.blog.contains('@')) _buildEmail(),
            const SizedBox(height: 16),
            _buildStats(),
            const SizedBox(height: 16),
            _buildFollowButton(),
            const SizedBox(height: 16),
            _buildNavigationItems(),
            const SizedBox(height: 16),
            _buildPopularSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF161B22),
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios, color: Colors.blue[600], size: 20),
            Text('Back', style: TextStyle(color: Colors.blue[600], fontSize: 17)),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.login,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(user.bio, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildOrganizationAndLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildInfoRow(Icons.business, '@github'),
          if (user.location.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on, user.location),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.grey[400])),
      ],
    );
  }

  Widget _buildBlogLink() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => _launchUrl(user.blog),
        child: Row(
          children: [
            const Icon(Icons.link, color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text(user.blog, style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _buildInfoRow(Icons.email, user.blog),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.people, color: Colors.grey, size: 20),
          const SizedBox(width: 4),
          Text(
            '${user.followers}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(' followers · ', style: TextStyle(color: Colors.grey[400])),
          Text(
            '${user.following}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(' following', style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Follow'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF21262D),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItems() {
    return Column(
      children: [
        _buildNavItem(Icons.book, 'Repositories', user.publicRepos.toString()),
        _buildNavItem(Icons.star_border, 'Starred', '3'),
        _buildNavItem(Icons.business, 'Organizations', '0'),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color:  Colors.black12,
        border: Border(
          bottom: BorderSide(color: Colors.grey[850]!, width: 1),
          top: BorderSide(color: Colors.grey[850]!, width: 1),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(count, style: const TextStyle(color: Colors.grey)),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.grey, size: 20),
              SizedBox(width: 8),
              Text(
                'Popular',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        _buildPopularRepositoryCard(),
      ],
    );
  }

  Widget _buildPopularRepositoryCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: const Color(0xFF0D1117),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: Colors.grey[850]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'octocat',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.book, color: Colors.grey, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Spoon-Knife',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'This repo is for demonstration purposes only.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'JavaScript',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Spacer(),
                  const Icon(Icons.star_border, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  const Text(
                    '128k',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0D1117),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: 3,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
