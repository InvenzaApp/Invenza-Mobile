# Invenza
[![Codemagic build status](https://api.codemagic.io/apps/681ccb739357b7eb40c4b4f5/681ccb739357b7eb40c4b4f4/status_badge.svg)](https://codemagic.io/app/681ccb739357b7eb40c4b4f5/681ccb739357b7eb40c4b4f4/latest_build)

Invenza - mobile app

## About the app

Invenza is a simple app, which allows you to create your team, create groups of users, and follow tasks

## YouTrack
[Open YouTrack](https://invenza.youtrack.cloud/agiles/182-2/current)

## Getting Started

### Firebase
App uses firebase, so you have to create project in Firebase.
Also you will need to install [Firebase](https://firebase.google.com/docs/cli?authuser=6#setup_update_cli) and [Flutterfire](https://firebase.google.com/docs/flutter/setup?platform=ios#install-cli-tools)
To login to Firebase just run
```
firebase login
```
And to configure app project, run
```
flutterfire configure
```

### Mobile app

To initialize project run this command
```
flutter clean && flutter pub get && dart run build_runner build
```

### Signing app

To sign app for release, copy `key.properties.copy` file and rename it to `key.properties`. Fill `key.properties` file with proper data.
Also, you have to place `keystore.jks` file in `android/app` folder.
