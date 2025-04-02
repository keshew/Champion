import SwiftUI

@main
struct ChampionApp: App {
    @StateObject var notificationManager = NotificationManager()
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                ChampionTabBarView()
            } else {
                ChampionSignInView()
                    .onAppear {
                        UserDefaultsManager().quitQuest()
                        notificationManager.requestPermission { granted in
                        }
                    }
            }
        }
    }
}
