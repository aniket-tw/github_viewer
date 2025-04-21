# GitHub Profile Viewer

A Flutter application that allows users to search and view GitHub user profiles with a clean, modern UI that closely resembles GitHub's mobile app interface.

## Features

- 🔍 **Search GitHub Users**
    - Real-time search functionality
    - Recent search history suggestions
    - Elegant loading and error states

- 👤 **User Profile Details**
    - Profile picture and name
    - Bio and location
    - Organization details
    - Blog/website links
    - Email information
    - Follower and following counts
    - Repository statistics

- 📱 **GitHub-like UI**
    - Dark theme matching GitHub's mobile app
    - Responsive design
    - Smooth animations
    - Native bottom navigation

- 📊 **Repository Information**
    - Total repositories count
    - Starred repositories
    - Organization memberships
    - Popular repositories with descriptions

## Technologies Used

- Flutter
- GetX for state management
- GitHub REST API
- Cached Network Image for efficient image loading
- URL Launcher for external links
- Shared Preferences for local storage

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- An IDE (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/github_viewer.git
```

2. Navigate to the project directory:
```bash
cd github_viewer
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── controllers/      # GetX controllers
├── models/          # Data models
├── screens/         # UI screens
├── widgets/         # Reusable widgets
└── services/        # API services
```

## Usage

1. Launch the app
2. Enter a GitHub username in the search bar
3. View the user's profile information
4. Access recent searches through suggestions
5. Navigate through different sections using the bottom navigation

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- GitHub for the API and design inspiration
- Flutter team for the amazing framework
- GetX team for the state management solution
