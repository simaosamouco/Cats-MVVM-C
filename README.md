# 🏛️ MVVM-C Architecture Demo

This is a proof of concept for an iOS app using MVVM-C with several design patterns that follow the SOLID principles and Clean Code practices. The goal is to create a simple application using a scalable and testable architecture.

<br>

<div align="center">

### 📱 Live Demo

https://github.com/user-attachments/assets/d10c7764-b00f-42ae-83c2-13274bd19997

</div>

<br>

## ⚙️ How it works

By following the MVVM architecture, all of the logic around a certain screen is contained in the View Model, making the View as "dumb" as possible. This could have been implemented in a more literal way if the view model provided all of the text and images to the view. For a simple project like this it felt unnecessary.

Although the View Model is the "brain" of the screen, it does not actually perform the tasks needed for the logic around the screen. For example, the cats list screen has a text field that will filter the list by breed names that contain the inputted text. This filtering is not done by the view model; once the user inserts some text, the view model will simply call a filtering use case and say "hey, here are the cats I have and the text, please return the breeds containing the text!". 

This is possible via **dependency injection**; throughout the app, dependencies are injected where needed to follow the single responsibility principle. By following this design pattern, the view model is relieved of the filtering responsibility, and the use case can be injected somewhere else, preventing the need to write the same code twice. Once the use case is tested, it can be used elsewhere safely.

## 🧭 Navigation

To simplify and centralize the navigation within the app, the **Coordinator design pattern** was used. This relieves the view model of this responsibility. The way it works is: the user taps a button on the view which then tells "hey view model! This button was tapped!" The view model, being the brain, will then decide what to do with that information "that means we should navigate to that screen, hey coordinator: go here!" The coordinator then simply goes where the view model tells it to go—it does not decide anything.

This works, but what if the screen the coordinator is supposed to navigate to gets a new dependency injected into it? Should all the coordinators that navigate to it be updated? This makes it a bit hard to scale, and this is where the **Factory design pattern** comes into play. The Factory is responsible for creating the screens with all of their dependencies. It will be injected into the coordinators that will tell the factory "please, give me the view controller for this screen" and then navigate to that screen. The coordinators have no idea what is injected into the screen.

## 📦 Dependency Management

In order for this to work, it's necessary that the factory has access to all of the dependencies of all of the screens. For this, the **Dependency Container design pattern** was implemented. It is simply a dictionary that contains all of the dependencies. When starting the application, the dependencies will be registered in the dependency container, meaning that for a certain protocol type there is a concrete instance associated with it. 

When registering a dependency in the container, there are three possible ways:
- **Immediate**: An instance is created as soon as the register method is called and saved in the container
- **Lazy**: A closure containing the creation of the dependency is saved, so that it is only created when trying to access it (resolving it). This is used for scenarios where the dependency will be needed but not right away, so it does not create it immediately, optimizing the app
- **Factory**: A new instance of the dependency is created every time it's resolved, useful for stateful objects that need to be "fresh" every time

The Factory will then access the container, resolve the dependencies needed for each screen, and inject them. So if at some point a screen requires a new dependency, this is the only place it will be created and injected.

## 🎨 UIKit and SwiftUI

When it comes to creating a beautiful user interface, SwiftUI is the state of the art—it's fun, simple and provides a lot of options for animations and such! But when it comes to navigation, it is not quite as robust as UIKit's UINavigationController.   
For this app I wanted to try and get the best of both: the ease of creating beautiful UI with SwiftUI and the smooth navigation UIKit provides.

The way I achieved this is by creating a UIViewController and injecting a SwiftUI view into it. The UIViewController is then in a navigation stack of the UINavigationController handled by the Coordinator.    
This works surprisingly well. The View really has just a single responsibility and has no idea what is happening elsewhere. This method allows access to methods in the UIKit lifecycle that are very useful, such as **viewDidLoad** and **viewWillAppear**. 

Each screen has 4 files associated with it: view, view controller, view model and coordinator.    
The connection between these is made via protocols—they don't know the concrete implementation of each other.

Although this works just fine, when creating a new screen, it's a little verbose. Creating all of those files and connecting them via protocols and such.   
To optimize this, I created an Xcode file template. So by simply creating a new file and giving it a name, the four files get instantly created and connected. There is even a commented part in the view controller showing the method the factory should implement, so it's just copy and paste.

<br>

<div align="center">

### 📱 File Creation Demo


https://github.com/user-attachments/assets/de4f7ab1-fcc6-43f9-8379-d71736d6cb07



</div>

<br>

## 📱 Tab Bar Configuration

That is basically how the app works—the responsibility is separated as much as possible. Another good example of that is in the configuration of the tab bar. The MainTabBarController configures the tab bar when the app is launched, but it does not know which tabs it's configuring, which view controllers it's using, the title, order, and such. 

I created a TabBarScreen enum where each case represents a screen in the tab. It is a CaseIterable enum, so the configure method in the tab bar controller goes through all of the cases and fetches what it needs for the tab bar setup: the index, title, image, and the view controller. So if we want to change the order of the screens, we would go to this enum and change the index variable—as simple as that.

So the TabBarScreen is responsible for providing all of the information necessary for the setup of the tab bar.

## ✨ Other Features

**Localization**: All of the text in the app is localized and translated to English and Portuguese, so if we want to change the text, we'd just go to the localized strings file and change it.

**Theme Support**: The app supports light and dark mode. The theme is persisted between app launches—UserDefaults was used to save the chosen theme.

**Data Persistence**: SwiftData was used to persist the saved cats in the device memory.

## 📋 Requirements

- iOS 17.0+ (due to SwiftData)
- Xcode 15.0+
- Swift 5.9+

## 🚀 Getting Started

1. Clone the repository
2. Open `Cats.xcodeproj` in Xcode
3. Build and run the project
4. Explore the architecture through the well-documented code

---

*In the development process of the app, AI was used as a tool to optimize some code and document some code here and there, but the architecture view is mine.*
