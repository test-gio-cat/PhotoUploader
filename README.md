# PhotoUploader

PhotoUploader is a simple application that helps the users to upload in cloud local photos from their devices in order to share them using a link.

<img src="https://github.com/Gioevi90/PhotoUpload/blob/main/Resources/demo.gif" width="180">

# Architecture Overview

The architecture used to create the project is Redux. I've choosen it because I wanted to learn something new and the dimension of the project seemed to be good to try it.

To implement it, I used [ReSwift](https://github.com/ReSwift/ReSwift), a very famous framework to build Redux applications in swift. In order to implement also the server calls, I've used also [ReSwiftThunk](https://github.com/ReSwift/ReSwift-Thunk), a ReSwift extension which extends Redux to have automatic middlewares thunks for server calls.

# App Overview

The application consinsts in 3 sections:

1. The choose country section
2. The select photo section
3. The link list section

All the logic between the changes of states inside the appliction is managed by the reducers, so the sections has just the aim to draw the ui according to the actual state of the application.

To make the code more "clean" I tried to separate UI in different UIViews classes.

# Services

The application consists in 2 services:

1. a service to get the list of countries from a given endpoint
2. a service to upload a list of images to a given endpoint.

To implement the network requests I used [Alamofire](https://github.com/Alamofire/Alamofire) because it is updated and it's good library to perform network requestes without loosing time.

Each of the services return Combine publishers to which the thunks can subscribe in order to receive values. 

* The country service is easy, because simply uses the AlamoFire Combine extension to return the publisher to the thunk

* The images upload is more complex, because I needed to create something more useful to have the possibility to call the thunk on a list of image (so combining a list of multipart requests) and something that also returns to the thunk the progress state of the upload.

# Optimization

The upload of the images needed to be optimized because the upload of the images direcly from the photo library was very slow. The optimizations applied are:

* using combine, the upload of the images is performed in parallel. This should speed up the process.
* the image size (in terms of width and height) is reduced of the 70%. I've found that this is acceptable in terms of quality.
* the image is compressed of the 50% using the jpeg ios compression function.

# Dependencies

All the dependencies inside the application are integrated using [Swift Package Manager](https://swift.org/package-manager/). I decided to use this instead of other dependency managers ( such as Cocoapods ) because I think this is becoming the new standard for the new apple application, and because I didn't have any reason to not use it inside this project, since all I needed was already available in SPM.

# Tests

The 20% of the code is covered by unit tests. I decided to test some utils structure and the entire state logic of the application (testing all the reducers). To avoid to start the real application during the unit test run, I used a TestAppDelegate class in test targers in order to override the real AppDelegate using the main.swift before running the tests.

The code is not covered by ui tests.

# Continuos Integration

Continuos integration has been implemented using [Fastlane](https://docs.fastlane.tools) and [Github Actions](https://github.com/features/actions). I've decided to use Fastlane instead a Github Action job available in the Marketplace because Fastlane can be used also in other ci systems. 

On my side, for this project Github Actions was the best ci tool because it's free for simple user repository and because it was easier to integrate in my branch.

The only available lane is the one related to test because it's only for demo purposes.