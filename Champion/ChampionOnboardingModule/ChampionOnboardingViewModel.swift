import SwiftUI

class ChampionOnboardingViewModel: ObservableObject {
    let contact = ChampionOnboardingModel()
    @Published var currentIndex = 0
    @Published var isGetStarted = false
}
