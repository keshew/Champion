import SwiftUI

struct ChampionNewDetailView: View {
    @StateObject var championNewDetailModel =  ChampionNewDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isShareSheetShowing = false
    var model: NewsModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.leftArrow3)
                                    .resizable()
                                    .frame(width: 18, height: 20)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                            
                            Text("NEWS DETAILS")
                                .PopBold(size: 20,
                                     color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                .multilineTextAlignment(.center)
                            
                            Spacer(minLength: 130)
                        }
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(model.text)
                                    .PopBold(size: 24)
                                    .padding(.leading)
                                
                                Text(model.desc)
                                    .Pop(size: 16,
                                         color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        Rectangle()
                            .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 38/255, green: 37/255, blue: 109/255), lineWidth: 1)
                                    .overlay {
                                        VStack(spacing: 20) {
                                            HStack {
                                                Text("New Operating Hours")
                                                    .PopBold(size: 18,
                                                             color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                .padding(.leading)
                                                
                                                Spacer()
                                            }
                                            
                                            VStack(spacing: 15) {
                                                HStack {
                                                    Text("Weekdays")
                                                        .Pop(size: 16)
                                                    
                                                    Spacer()
                                                    
                                                    Text("5:30 AM - 10:30 PM")
                                                        .Pop(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                }
                                                
                                                HStack {
                                                    Text("Weekdays")
                                                        .Pop(size: 16)
                                                    
                                                    Spacer()
                                                    
                                                    Text("6:30 AM - 9:30 PM")
                                                        .Pop(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                }
                                                
                                                HStack {
                                                    Text("Weekdays")
                                                        .Pop(size: 16)
                                                    
                                                    Spacer()
                                                    
                                                    Text("8:00 AM - 8:00 PM")
                                                        .Pop(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                            }
                            .frame(height: 178)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Text("Special Sessions")
                                .PopBold(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(model.detail.text.indices, id: \.self) { index in
                                    SessionView(text: model.detail.text[index],
                                                image: model.detail.images[index])
                                }
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack(spacing: -10) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                                    .overlay {
                                        Text("Book Now")
                                            .Pop(size: 16, color: Color(red: 7/255, green: 9/255, blue: 84/255))
                                    }
                                    .frame(height: 50)
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                            
                            Button(action: {
                                isShareSheetShowing = true
                            }) {
                                Rectangle()
                                    .fill(.clear)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                        
                                        Text("Share Schedule")
                                            .Pop(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                    }
                                    .frame(height: 50)
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isShareSheetShowing) {
                //MARK: - url
                ShareSheet(items: [""])
            }
        }
    }
}

#Preview {
    ChampionNewDetailView(model: NewsModel(color: Color.clear, label: "", date: "", text: "", desc: "", detail: DetailInfo(title: "", desc: "", images: [""], text: [""])))
}

struct SessionView: View {
    var text: String
    var image: String
    var body: some View {
        Rectangle()
            .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 38/255, green: 37/255, blue: 109/255), lineWidth: 1)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 20)
                                
                                Text(text)
                                    .Pop(size: 16)
                                
                                Text("5:30 AM - 7:30 AM")
                                    .Pop(size: 14, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                    }
            }
            .frame(width: 200, height: 112)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}
