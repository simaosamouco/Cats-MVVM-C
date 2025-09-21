# MVVM-C Proof of Concept  

This project is a proof of concept for an iOS app built with **MVVM-C**, applying several design patterns that follow the **SOLID principles** and **Clean Code** practices. The main goal is to create a simple application with a scalable and testable architecture.  

---

## Architecture Overview  

Following the **MVVM** pattern, all of the logic for a given screen is contained in the **ViewModel**, while the **View** is kept as “dumb” as possible. In a stricter implementation, the ViewModel could even provide all text and images to the View, but for this project that level of separation was unnecessary.  

Although the ViewModel acts as the “brain” of the screen, it does not directly perform business logic. Instead, it delegates responsibilities. For example, in the cats list screen, the user can type text into a field to filter breeds. The ViewModel does not execute this filtering itself. Instead, once the user enters the text, it calls a **Filtering Use Case** and essentially says: *“Here are the cats and the search text, please return the matching breeds.”*  

This separation is achieved through **Dependency Injection**. Dependencies are injected where needed, ensuring that each component adheres to the **Single Responsibility Principle**. As a result, the ViewModel is relieved from handling filtering logic, the filtering use case can be reused elsewhere, and once tested, it can be safely injected into any feature without duplication.  

---

## Navigation with Coordinators  

To simplify and centralize navigation, the **Coordinator** pattern is used. The View notifies the ViewModel when an action occurs, such as a button tap. The ViewModel then interprets this event and decides what should happen next, for instance: *“This means we should navigate to that screen — hey Coordinator, go there.”* The Coordinator then executes the navigation.  

The Coordinator never decides where to go on its own. It simply follows the instructions from the ViewModel, keeping responsibilities clear and separated.  

---

## Factories and Dependency Container  

One challenge with Coordinators is scaling. If a screen gains a new dependency, every Coordinator that navigates to it would need to be updated. To avoid this, the **Factory** pattern was introduced. The Factory is responsible for creating screens with all required dependencies. Coordinators then request screens from the Factory without knowing what those dependencies are.  

The Factory itself relies on a **Dependency Container**, which stores all dependencies and maps each protocol to a concrete implementation. When registering a dependency in the container there are three possible strategies: 
  - Immediate, where an instance is created as soon as it is registered
  - Lazy, where a closure is stored and the dependency is only created when it is first accessed
  - Factory, where a fresh instance is created each time the dependency is resolved.  

Thanks to this approach, if a screen requires a new dependency, only the Factory and the Dependency Container need updating. Coordinators remain unaffected.  

---

## SwiftUI + UIKit Integration  

For the user interface, the goal was to combine the best of **SwiftUI** and **UIKit**. SwiftUI makes it easy to build beautiful, modern, and animated interfaces, while UIKit still offers more robust navigation with `UINavigationController`.  

The solution was to wrap each SwiftUI view inside a `UIViewController` and place that controller into a navigation stack managed by the Coordinator. This allows the use of UIKit lifecycle methods such as `viewDidLoad` and `viewWillAppear`, while still benefiting from SwiftUI for layout and styling.  

Each screen is composed of four files: a View, a View Controller, a ViewModel, and a Coordinator. These components communicate via protocols rather than concrete implementations, keeping them decoupled. To reduce boilerplate, I also created an **Xcode file template** that automatically generates and wires these four files together whenever a new screen is created.  

---

## Tab Bar Configuration  

The **MainTabBarController** configures the tab bar when the app launches, but it does not know which tabs it is configuring or which ViewControllers are being used. Instead, there is a `TabBarScreen` enum where each case represents a tab. This enum provides the index, title, icon, and ViewController for each tab, and because it conforms to `CaseIterable`, the tab bar can be configured simply by iterating through its cases.  

If the order of the tabs ever needs to change, it is enough to adjust the `index` property in the enum. This keeps the configuration both centralized and flexible.  

---

## Other Features  

All text in the app is localized in both English and Portuguese, which means updating a string is as simple as editing the `Localizable.strings` file. The app supports both light and dark mode, and the chosen theme is persisted between launches using `UserDefaults`. Finally, **SwiftData** is used to persist saved cats locally on the device.  

---

## Development Note  

In the development process of this app, **AI was used as a tool** to optimize certain parts and document some code. However, the **overall architecture design and decisions are entirely mine**, inspired by **articles read, research, and professional experiences**.  
