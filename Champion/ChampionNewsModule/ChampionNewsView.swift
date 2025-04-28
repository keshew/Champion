import SwiftUI

struct ChampionNewsView: View {
    @StateObject var championNewsModel =  ChampionNewsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            if !UserDefaultsManager().checkLogin() {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(.leftArrow3)
                                        .resizable()
                                        .frame(width: 18, height: 20)
                                        .padding(.leading)
                                }
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("Club News")
                                    .PopBold(size: 20)
                                
                                Text("Stay up to date with the\nlatest club updates")
                                    .Pop(size: 14, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                    .multilineTextAlignment(.center)
                            }
                            Spacer(minLength: 120)
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 25) {
                            ForEach(championNewsModel.contact.model.indices, id: \.self) { index in
                                News(new: championNewsModel.contact.model[index])
                                    .onTapGesture {
                                        championNewsModel.isDetail = true
                                        championNewsModel.model = championNewsModel.contact.model[index]
                                    }
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $championNewsModel.isDetail) {
                ChampionNewDetailView(model: championNewsModel.model)
            }
        }
    }
}

#Preview {
    ChampionNewsView()
}

struct News: View {
    var new: NewsModel
    var body: some View {
        Rectangle()
            .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 38/255, green: 37/255, blue: 109/255), lineWidth: 2)
                    .overlay {
                        VStack {
                            HStack {
                                Text(new.label)
                                    .Pop(size: 12)
                                    .padding(5)
                                    .padding(.horizontal, 5)
                                    .background(new.color)
                                    .cornerRadius(8)
                                
                                Spacer()
                                
                                Text(new.date)
                                    .Pop(size: 12, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(new.text)
                                        .PopBold(size: 16)
                                        .lineLimit(1)
                                    
                                    Text(new.desc)
                                        .Pop(size: 14, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                }
                                .padding(.leading)
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                        }
                    }
            }
            .frame(height: 169)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}
