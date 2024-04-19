# Odaz - A flutter order tracking application

## [Demo](https://www.youtube.com/shorts/lmC2dD9Mgqo)

<video width="320" height="600">
  <source src="https://www.youtube.com/shorts/lmC2dD9Mgqo">
</video>

## How To Run the Application

### Step One: Clone the repo

```rust
git clone git@github.com:mel-fayne/odaz.git
```

### Step Two: Project Dependencies

- Once cloned, open the application in VS Code or Android Studio. To get project dependencies, in your terminal run:

```rust
flutter pub get
```

### Step Three: Run the Application

- After getting project dependencies, run the application by either clicking debug (in debug or release mode - release mode is recommended). Or in your terminal, run:

```rust
flutter run
```

### Step Four: Login

- Once the app is running, sign in with your preferred method (either Google or Github). This will then redirect you to the Home Page on successful sign in.
  <img src= "https://drive.google.com/uc?export=view&id=1Qdg5h7S2KbSZzncpaKMLolqFZyC_ibMk" alt="login page" width="320" height="600">

- On the home page, you'll be able to view the active order whose delivery status we will be updating using Ably.

  <img src= "https://drive.google.com/uc?export=view&id=1R9ytoIrHvHZZaXBRrykLqmQObVHba0FP" alt="home page" width="320" height="600">

### Step Five: Mock Real-time Delivery Status Update

- Click on Track Order to navigate to the Tracking Order Screen. From here you'll be able to see more details about the order, but more importantly you'll be able to mock Real-time updates using Ably.

  <img src= "https://drive.google.com/uc?export=view&id=1WUZEGYLwTrmf6pKdjAf3AxRvcbdBchcU" alt="message options page" width="320" height="600">

- To keep things simple, the **Mock Ably** button has been provided to enable one to mock Ably calls from the application.
- On clicking the button, a dialog pops up and presents different delivery status options you can send as a message using Ably.

  <img src= "https://drive.google.com/uc?export=view&id=1llEzyu3sKsHGMl94AZtAMg7cWkITEIhi" alt="first status page" width="320" height="600">

- Once an option has been selected, the **sendMessage** function shown below (found in [orders_controller.dart](https://github.com/mel-fayne/odaz/blob/main/lib/controllers/orders_controller.dart)) calls a channel called **orderStatus** and publishes the orderStatus message that was selected.

```dart
 Future<void> sendMessage() async {
    final channel = realtime!.channels.get('orderStatus');
    await channel.publish(name: 'greeting', data: statusDropDownValue);
    Get.back();
  }
```

- Once published, the **listenOnAbly** function will be called to update the delivery status as needed:

```dart
void listenOnAbly() {
    channel = realtime!.channels.get('orderStatus');
    channel!.subscribe().listen((message) {
      debugPrint('.');
      debugPrint('..');
      debugPrint('Received a greeting message in realtime: ${message.data}');
      debugPrint('.');
      debugPrint('..');
      updateStatus('${message.data}');
    });
  }
```

- On sending the message, the UI will be updated accordingly as shown:

  <img src= "https://drive.google.com/uc?export=view&id=1LmiLW0OIwSE2sNLNFLErY93XqHNHfMc0" alt="last status page" width="320" height="600">
