Student Profile Application

## Getting Started
    1. flutter pub get
    2. flutter run
    2. install json_rest_server by running dart global activate json_rest_server
    3. cd into the storage folder and run json_rest_server run
    4. this will get you started with the server

## Folder Structure
- lib
    |- components
    |- core
    |- features 
    |    |- home
    |    |- settings
    |    |- student
    |- services 
    |- utils 

**How to integrate APIs to the project**
The rest server is very easy to implement, follow the steps below

* activate json_rest_server from dart by running dart pub global activate json_rest_server
* then run json_rest_server run, it will start the server then can start fetching api

**Text and Content:**_

* Test text rendering, including font styles, sizes, and colors.
* Verify that dynamic content (e.g., text, images) is displayed correctly.

_**State Management:**_

* I made use of cubit from flutter_bloc package, this package was used because of the simplicity of the project, other options are riverpod, provider, e.t.c.
* Test how widgets handle different states (loading, success, error).
* Verify that the UI updates appropriately when the underlying state changes.


_**Navigation:**_

* I also used go router from the go_router package, because of it's flexibility and simplicity of navigation
* Test navigation between screens or routes.
* Verify that the correct screens are displayed based on navigation actions.

_**Animation and Transitions:**_

* Test animations and transitions to ensure they run smoothly.
* Verify that animations complete as expected.


## Notice

# I received the notification late, the day before submission as i didn't notice it in my mail, i would have made progress with this assessment but due to just one day of working this is just what i could come up with
# Also, i didn't gain clarity on the shared preference and sqlite because, i thought it was an option to either go with the local storage or api integration, which i fully integrated using (json_rest_server).
