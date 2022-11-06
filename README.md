# vamachallenge

## Task summary
- The application is written using **Xcode 14** and **Swift 5**.
- Minimum deployment target - **iOS 13**.
- Supported interface orientations - **Portrait**.
- The application architecture is **MVVM**.
- **Combine** framework is used for data bindings between **ViewModel** and **View** and for **Repositories**.
- **Realm** is used for caching albums data.
- **URLSession** is used for loading albums feed and async image loading.
- Used dependency manager is **CocoaPods**.
- **UI** is built completely from code using **UIKit** and view anchors for layout. 
- Simple **Coordinator** is added for application navigation and dependency injections, no storyboards or nibs are used.
- Albums list screen is built using **CollectionView** with **Compositional layout** and **Diffable data source**. **Refresh control** was added to allow the user to reload the data. In case of no internet connection alert is shown.
- I’ve decided not to add ViewModel for the album details screen because there is no business logic on that screen.
- For data gathering, Local and Remote repositories are used.
- To simplify work with the layout I’ve added the extension to UIView that have common methods for layout that were used in the development.
- Date helper class was added to handle work with Date.
- Application colors are stored in the assets.
- Screen recording is made on iPhone 14 simulator

## Possible improvements
- Some **facade** could be created to provide single interface for Local and Remote repositories.
- Strings could be moved to **Constants**.
- Colors could be moved to **Constants**.
- Image cahing could be added.


https://user-images.githubusercontent.com/5870566/200184418-4941a9e5-6a71-4728-b40d-4b38abd5c5c3.mp4

