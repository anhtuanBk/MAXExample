import UIKit
import AppLovinSDK

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let settings = ALSdkSettings()
        settings.consentFlowSettings.isEnabled = true
        settings.consentFlowSettings.privacyPolicyURL = URL(string: "https://max-example.com/privacy_policy")
        settings.consentFlowSettings.termsOfServiceURL = URL(string: "https://max-example.com/terms_of_service")
        
        let sdk = ALSdk.shared(with: settings)
        sdk?.mediationProvider = "max"
        sdk?.userIdentifier = UUID().uuidString
        sdk?.initializeSdk { (configuration: ALSdkConfiguration) in
            
        }
        
        let maxVC = MAXExampleViewController.create() ?? UIViewController()
        let navController = UINavigationController(rootViewController: maxVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
