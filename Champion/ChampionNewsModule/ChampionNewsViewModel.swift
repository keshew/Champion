import SwiftUI

class ChampionNewsViewModel: ObservableObject {
    let contact = ChampionNewsModel()
    @Published var isDetail = false
    @Published var model = NewsModel(color: .clear, label: "", date: "", text: "", desc: "", detail: DetailInfo(title: "", desc: "", images: [""], text: [""]))
}
