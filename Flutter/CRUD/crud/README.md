# CRUD Application
Full CRUD functionality:

Create: FAB and menu button to create new records
Read: List view with pull-to-refresh
Update: Edit button for each record
Delete: Delete button with confirmation dialog
Improved UI/UX:

Loading indicator while fetching data
Error handling with retry option
Empty state with call-to-action
Pull-to-refresh functionality
Card-based list items
Proper navigation to detail view
Better error handling:

Shows error messages in SnackBar
Provides retry options
Handles network/data loading errors
State management:

Proper loading states
Error states
Data refresh after CRUD operations
Navigation:

Integration with router
Passing data between screens
Refresh after navigation returns
## Getting Started

This project is a simple CRUD (Create, Read, Update, Delete) application built with Flutter. It includes a custom drawer for easy navigation between different screens.

## Screens

- **Home Screen**: The main screen of the application.
- **Create Screen**: A form to create new entries.
- **Read Screen**: A screen to read/view entries.
- **Update Screen**: A form to update existing entries.
- **Delete Screen**: A screen to delete entries.
- **Detail Screen**: A screen to view detailed information.

## Navigation

The application uses a custom drawer for navigation. The drawer includes links to all the screens mentioned above.

## Running the Application

To run the application, use the following command:

```sh
flutter run
```

## Assets

The `assets` directory houses images, fonts, and any other files you want to include with your application.

The `assets/images` directory contains [resolution-aware images](https://flutter.dev/to/resolution-aware-images).

## Localization

This project generates localized messages based on arb files found in the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on [Internationalizing Flutter apps](https://flutter.dev/to/internationalization).

## Additional Resources

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev), which offers tutorials, samples, guidance on mobile development, and a full API reference.
