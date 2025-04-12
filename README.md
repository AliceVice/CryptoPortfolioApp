
<h1>
  Crypto Trends
  <img src="https://github.com/user-attachments/assets/8db2be80-ecee-45c9-bf84-8bcf06d7174c" width="30" height="30" style="vertical-align: middle;" />
</h1>

Crypto Trends is a test project showcasing a SwiftUI cryptocurrency trends application.

### Functionality
- The app displays the top 250 cryptocurrencies worldwide along with market statistics.
- Users can search for coins, sort them, and reload the data.
- Upon selecting a coin, users can view its statistics and price chart.
- The app uses Combine to fetch data and bind UI components reactively.
- Downloaded coin images are stored in the cache directory using FileManager.
- Users can select and add coins to their portfolio (wallet). Coin storage is implemented using Core Data.
- The app follows the MVVM pattern for clear separation of concerns.

<br /><br />


# CoinGecko API 🦎
CryptoTrends uses the [CoinGecko](https://docs.coingecko.com/v3.0.1/reference/introduction) to fetch the coins. 


<br /><br />

# Implementation 🛠️

### Stack:

- **SwiftUI**: For building the app’s user interface.
- **MVVM Architecture**: For clear separation of concerns and maintainable code.
- **Combine**: For handling asynchronous network calls and data processing. For binding components to each other.
- **Core Data**: For storing user's portfolio coins.
- **FileManager**: To store the images into cache directory.
- **CoinGecko API**: To fetch real‑time cryptocurrency data.

### Project Structure:
<img width="250" alt="Screenshot 2025-04-12 at 3 42 46 PM" src="https://github.com/user-attachments/assets/08a3fd27-9f3f-49fd-8f4f-925366d66f78" />

### Screens:
- When the user opens the app, custom loading screen appears.

https://github.com/user-attachments/assets/b1ac9890-4a48-4b02-b285-1f1daf1cb9f2

- HomeView includes a custom navigation bar, market statistics, a search text field, and a coin list that supports sorting and manual refreshing via a refresh button in the top-right corner.

https://github.com/user-attachments/assets/dd436361-8c2e-428f-9c6b-8471bf48a3ed

- The PortfolioView looks like the HomeView. But it includes user's portfolio coins. The user can add the coins to his portfolio by tapping the plus button on the left of the navigation bar.

https://github.com/user-attachments/assets/72c5f1e8-7a1f-4029-8018-2b6c66412b97

- Coin DetailView has coin statistics and its price chart.

https://github.com/user-attachments/assets/9829fd75-d2ad-4bd8-9d6d-5c0617731d66

- SettingsView has links and information about the project and API.

https://github.com/user-attachments/assets/744adf2e-51a1-4099-b93c-a3e9e394058a




  
