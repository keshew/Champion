import SwiftUI

struct ChampionActivityView: View {
    @StateObject var championActivityModel = ChampionActivityViewModel()
    @State private var selectedActivity: ActivityModel?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Activity")
                                .PopBold(size: 28)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        ForEach(championActivityModel.contact.arrayModel, id: \.label) { item in
                            Button(action: {
                                selectedActivity = item
                                championActivityModel.isDet = true
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0/255, green: 0/255, blue: 84/255))
                                        .frame(height: 82)
                                        .cornerRadius(8)
                                        .padding(.horizontal, 20)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(item.color, lineWidth: 1)
                                                .padding(.horizontal,20)
                                        }
                                    
                                    HStack {
                                        Image(item.image)
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .padding(.leading, 30)
                                        
                                        VStack(alignment: .leading) {
                                            Text(item.label)
                                                .PopBold(size: 16)
                                            
                                            Text(item.text)
                                                .Pop(size: 14, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                        }
                                        
                                        Spacer()
                                        
                                        Image(.rightArrow)
                                            .resizable()
                                            .frame(width: 10, height: 14)
                                            .padding(.trailing, 40)
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        
                        Color(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top)
                }
                
                Color(.clear)
                    .frame(height: 60)
            }
            .fullScreenCover(isPresented: $championActivityModel.isDet) {
                if let selectedActivity = selectedActivity {
                    ChampionDetailActivityView(selectedActivity: selectedActivity)
                }
            }
        }
    }
}


#Preview {
    ChampionActivityView()
}

