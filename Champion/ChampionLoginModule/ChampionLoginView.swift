import SwiftUI

struct ChampionLoginView: View {
    @StateObject var championLoginModel =  ChampionLoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer(minLength: 80)
                        
                        VStack(spacing: 30) {
                            Image(.anotherStar)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 121, height: 110)
                            
                            Text("ChampClub")
                                .PopBold(size: 27)
                        }
                        .frame(width: 179, height: 201)
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 20) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Phone Number")
                                        .Pop(size: 14,
                                             color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                CustomTextFiled(text: $championLoginModel.phone,
                                                geometry: geometry,
                                                placeholder: "Enter your phone number")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Password")
                                        .Pop(size: 14,
                                             color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                CustomSecureFiled(text: $championLoginModel.password,
                                                geometry: geometry,
                                                placeholder: "Enter your pre-generated password")
                            }
                        }
                        
                        HStack {
                            Text("This is your pre-generated password and cannot be\nchanged")
                                .Pop(size: 12,
                                     color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 20) {
                            Button(action: {
                                championLoginModel.login { success in
                                        if success {
                                            UserDefaultsManager().saveCurrentEmail(championLoginModel.phone)
                                            UserDefaultsManager().savePassword(championLoginModel.password)
                                            UserDefaultsManager().saveLoginStatus(true)
                                            
                                            if UserDefaultsManager().isFirstLaunch() {
                                                DispatchQueue.main.async {
                                                    self.championLoginModel.isOnb = true
                                                }
                                            } else {
                                                DispatchQueue.main.async {
                                                    self.championLoginModel.isTab = true
                                                }
                                            }
                                        }
                                    }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                                        .frame(height: 56)
                                        .cornerRadius(8)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Log In")
                                            .PopBold(size: 16, color: .black)
                                        
                                        Image(.arrowRight)
                                            .resizable()
                                            .frame(width: 14, height: 16)
                                    }
                                }
                            }
                            
                            Button(action: {
                                championLoginModel.isNew = true
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                        }
                                        .frame(height: 56)
                                        .cornerRadius(8)
                                        .padding(.horizontal, 20)
                                       
                                    
                                    Text("Club news")
                                        .PopBold(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                }
                            }
                        }
                        
                        Spacer(minLength: 25)
                        
                        HStack {
                            Text("Don't have an account?")
                                .Pop(size: 15,
                                     color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                .padding(.leading)
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Sign in")
                                    .PopBold(size: 15,
                                         color: Color(red: 153/255, green: 153/255, blue: 186/255))
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $championLoginModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(championLoginModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .fullScreenCover(isPresented: $championLoginModel.isOnb) {
                ChampionOnboardingView()
            }
            .fullScreenCover(isPresented: $championLoginModel.isTab) {
                ChampionTabBarView()
            }
            
            .fullScreenCover(isPresented: $championLoginModel.isNew) {
                ChampionNewsView()
            }
        }
    }
}

#Preview {
    ChampionLoginView()
}

