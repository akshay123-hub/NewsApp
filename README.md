# NewsApp

A SwiftUI iOS application that displays top news headlines with a clean, modern interface. Articles are listed with a gradient background, support pull-to-refresh, and open in an in-app WebView for reading.

## Features
- SwiftUI interface with `NavigationStack`
- List of top headlines with custom article rows
- In-app browser using WebKit (`WebView`)
- Loading state with `ProgressView`
- Pull-to-refresh to fetch latest articles
- Error handling with alerts
- Async/await networking handled by a view model

## Architecture (MVVM with Swift Concurrency)
- Model: Types representing news articles and API responses (e.g., `Article`, response container)
- View: `NewsArticleView` renders the list, navigation, and background
- View Components: `ArticleRowView` for rows, `WebView` for displaying article URLs
- ViewModel: `NewsArticleViewModel` orchestrates data fetching, exposes `article`, `isLoading`, and `errorMessage`
- Concurrency: Uses Swift Concurrency (`async/await`) for non-blocking networking and UI updates

Data flow:
1. `NewsArticleView` appears and triggers `loadArticleData()`
2. The view model `getArticleData(limit:)` fetches articles asynchronously
3. `isLoading` toggles to show/hide `ProgressView`
4. On success, the view lists articles; on failure, `errorMessage` triggers an alert

## Setup Instructions
1. Open the project in Xcode (15 or newer recommended)
2. Select an iOS Simulator or a connected device
3. Build and run (Cmd+R)
4. The app fetches top headlines automatically on launch

Optional configuration:
- Change the number of articles by editing the `limit` parameter passed to `getArticleData(limit:)` in `loadArticleData()`
- Tweak the gradient background in `NewsArticleView` via the `background` property

## Troubleshooting
- Blank list of articles
  - Verify the API endpoint and parsing logic in `NewsArticleViewModel`
  - Check that `article.data` is populated and IDs are unique for `List`
- Loading indicator never disappears
  - Ensure `isLoading` is set to `false` in both success and error paths
  - Confirm `loadArticleData()` awaits the async call and handles errors
- Navigation not working
  - Make sure `NavigationStack` wraps the `List` and `NavigationLink` destinations are valid
- Web page fails to load
  - Validate that `article.url` is a proper URL string and `WebView` is initialized with a non-nil `URL`
- Alerts not showing
  - Confirm `errorMessage` is set on failures and the `.alert` binding evaluates to `true`

## Project Structure (at a glance)
- `NewsArticleView.swift`: Main screen that lists articles and handles navigation
- `ArticleRowView.swift`: Row view for article presentation
- `WebView.swift`: SwiftUI wrapper for WebKit to load article URLs
- `NewsArticleViewModel.swift`: Fetches data, manages `isLoading` and `errorMessage`

## Requirements
- iOS 17+
- Xcode 15+
- Swift 5.9+

## License
This project is provided as-is for educational purposes. Add your license of choice here.
