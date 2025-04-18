import SwiftUI

struct ChampionProfileView: View {
    @StateObject var championProfileModel =  ChampionProfileViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                if UserDefaultsManager().isGuest() {
                                    Text("Guest")
                                        .PopBold(size: 28)
                                        .padding(.leading)
                                    
                                    Text("Guest Member")
                                        .PopBold(size: 20,
                                                 color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                        .padding(.leading)
                                } else {
                                    Text("User")
                                        .PopBold(size: 28)
                                        .padding(.leading)
                                    
                                    Text("Premium Member")
                                        .PopBold(size: 20,
                                                 color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                        .padding(.leading)
                                }
                            }
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                                .frame(height: 96)
                                .cornerRadius(8)
                            
                            VStack(spacing: 15) {
                                HStack(spacing: 10) {
                                    Image(.id)
                                        .resizable()
                                        .frame(width: 18, height: 16)
                                    
                                    Text("Club ID")
                                        .Pop(size: 14)
                                    
                                    Spacer()
                                    
                                    if UserDefaultsManager().isGuest() {
                                        Text("Guest")
                                            .PopBold(size: 16,
                                                     color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                    } else {
                                        Text("EC25498")
                                            .PopBold(size: 16,
                                                     color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                    }
                                }
                                .padding(.horizontal)
                                
                                HStack {
                                    Image(.member)
                                        .resizable()
                                        .frame(width: 18, height: 16)
                                    
                                    Text("Membership Status")
                                        .Pop(size: 14)
                                    
                                    Spacer()
                                    
                                    if UserDefaultsManager().isGuest() {
                                        Text("Guest")
                                            .PopBold(size: 16,
                                                     color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                    } else {
                                        Text("Active")
                                            .PopBold(size: 16,
                                                     color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                    }
                                 
                                }
                                .padding(.horizontal)
                            }
                        }
                        .frame(height: 96)
                        .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                                .frame(height: 53)
                                .cornerRadius(8)
                            
                            HStack(spacing: 10) {
                                Image(.notif)
                                    .resizable()
                                    .frame(width: 14, height: 16)
                                
                                Text("Notifications")
                                    .Pop(size: 14)
                                
                                Spacer()
                                
                                
                                Toggle("", isOn: $championProfileModel.isTog)
                                    .toggleStyle(CustomToggleStyle())
                            }
                            .padding(.leading)
                        }
                        .frame(height: 53)
                        .padding(.horizontal)
                        
                        Spacer(minLength: UserDefaultsManager().isGuest() ? 360 : 280)
                        
                        Button(action: {
                            championProfileModel.isOut = true
                            UserDefaultsManager().saveLoginStatus(false)
                            UserDefaultsManager().deletePhone()
                            UserDefaultsManager().deletePassword()
                            if UserDefaultsManager().isGuest() {
                                UserDefaultsManager().quitQuest()
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 26/255, green: 0/255, blue: 95/255))
                                    .frame(height: 58)
                                    .cornerRadius(8)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(red: 255/255, green: 0/255, blue: 188/255), lineWidth: 1)
                                    }
                                
                                Text("Logout")
                                    .PopBold(size: 16,
                                             color: Color(red: 255/255, green: 0/255, blue: 188/255))
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                        
                        if !UserDefaultsManager().isGuest() {
                            Button(action: {
                                championProfileModel.deleteUser { success in
                                    if success {
                                        championProfileModel.isOut = true
                                    }
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 26/255, green: 0/255, blue: 95/255))
                                        .frame(height: 58)
                                        .cornerRadius(8)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(red: 245/255, green: 1/255, blue: 65/255), lineWidth: 1)
                                        }
                                    
                                    Text("Delete user")
                                        .PopBold(size: 16,
                                                 color: Color(red: 245/255, green: 1/255, blue: 65/255))
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Color(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top)
                }
            }
            .alert(isPresented: $championProfileModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(championProfileModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            .fullScreenCover(isPresented: $championProfileModel.isOut) {
                ChampionSignInView()
            }
        }
    }
}

#Preview {
    ChampionProfileView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 0/255, green: 255/255, blue: 255/255) : Color(red: 10/255, green: 86/255, blue: 142/255))
                .frame(width: 40, height: 20)
                .overlay(
                    Circle()
                        .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                        .frame(width: 15, height: 15)
                        .offset(x: configuration.isOn ? 8 : -8)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}
