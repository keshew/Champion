import SwiftUI

class ChampionActivityViewModel: ObservableObject {
    let contact = ChampionActivityModel()
    @Published var isDet = false
}
