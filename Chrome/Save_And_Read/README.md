# Save and Read Chrome Extension
The **Save and Read** Chrome extension allows users to save the current tab with a title, description, and note. Users can view a list of saved tabs, see when they were saved, and open them with a single click.

## Features

- **Save Current Tab**: Save the title, URL, description, and a personal note for the current tab.
- **View Saved Tabs**: Display a list of all saved tabs with their details.
- **Open Saved Tabs**: Click on any saved tab to open it in a new tab.
- **Timestamp**: See when each tab was saved.

## Installation

1. Clone or download this repository.
2. Open Chrome and navigate to `chrome://extensions/`.
3. Enable "Developer mode" in the top right corner.
4. Click "Load unpacked" and select the directory containing the extension files.

## Usage

1. Click the extension icon to open the popup.
2. Enter a description and note for the current tab.
3. Click "Save Current Tab" to save the tab.
4. Click "Show Saved Tabs" to view the saved tabs in the popup.
5. Click "Open Saved Tabs Page" to view the saved tabs in a dedicated page.

## Development

### File Structure

- `manifest.json`: Defines the extension's properties and permissions.
- `popup.html`: The HTML for the popup interface.
- `popup.js`: The JavaScript for the popup interface.
- `saved.html`: The HTML for the saved tabs page.
- `saved.js`: The JavaScript for the saved tabs page.
- `background.js`: Handles background tasks.
- `content.js`: Interacts with web pages.
- `icons/`: Contains the extension icons.
- `screenshots/`: Contains screenshots for the README.

### Adding New Features

1. Modify the relevant HTML, CSS, and JavaScript files.
2. Update the `manifest.json` file if necessary.
3. Reload the extension in Chrome to see the changes.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Made with by Paul Eekhof
