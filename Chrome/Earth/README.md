# 🌍 Earthquake Predictor Chrome Extension

A Chrome extension that monitors and displays recent earthquake activity using USGS data.

## ✨ Features

- 📊 Displays the 3 most recent earthquakes
- 🔄 Auto-updates every 10 minutes
- 🔔 Push notifications for earthquakes magnitude 5.0 or higher
- ⚡ Real-time data from USGS

## 💾 Installation

### Development Setup
1. Clone this repository
2. Open Chrome and navigate to `chrome://extensions/`
3. Enable "Developer mode" in the top right
4. Click "Load unpacked" and select the extension directory

### Packaging Your Extension
To create a distributable version of the extension:

1. Go to `chrome://extensions` in Chrome
2. Enable "Developer mode"
3. Click the "Pack extension" button
4. Select the folder where your `manifest.json` resides
5. Chrome will create:
   - A `.crx` file (the packaged extension)
   - A private key file (keep this for future updates)

> **Note:** The `.crx` file can be distributed or installed, while the private key should be kept secure for future updates.

## 🎯 Usage

- Click the extension icon to view recent earthquakes
- Use the "Check Now" button to manually refresh data
- Notifications will appear automatically for significant earthquakes

## 📊 Data Source

This extension uses the USGS Earthquake API:
- Endpoint: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson
- Updates: Every minute
- Coverage: Worldwide

## 📁 Files

- `popup.html/js` - User interface
- `background.js` - Background service worker
- `manifest.json` - Extension configuration

## ⚙️ Requirements

- Chrome browser
- Internet connection for API access

## 📝 License

MIT License

