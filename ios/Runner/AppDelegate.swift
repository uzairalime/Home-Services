import UIKit
import Flutter
// import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  
    GeneratedPluginRegistrant.register(with: self)
        // GMSServices.provideAPIKey("AIzaSyCuC0N234IJDgCJLD6pV3YHBh0NcL29Tuw")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
