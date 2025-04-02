import SwiftUI

struct ChampionSignInView: View {
    @StateObject var championSignInModel =  ChampionSignInViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer(minLength: 80)
                        
                        Image(.champLabel)
                            .resizable()
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
                                
                                CustomTextFiled(text: $championSignInModel.phone,
                                                geometry: geometry,
                                                placeholder: "Enter your email")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Password")
                                        .Pop(size: 14,
                                             color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                CustomSecureFiled(text: $championSignInModel.password,
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
                                if championSignInModel.register() {
                                    championSignInModel.isLog = true
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                                        .frame(height: 56)
                                        .cornerRadius(8)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Sign up")
                                            .PopBold(size: 16, color: .black)
                                        
                                        Image(.arrowRight)
                                            .resizable()
                                            .frame(width: 14, height: 16)
                                    }
                                }
                            }
                            
                            Button(action: {
                                UserDefaultsManager().enterAsGuest()
                                if UserDefaultsManager().isFirstLaunch() {
                                    championSignInModel.isOnb = true
                                } else {
                                    championSignInModel.isTab = true
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 56)
                                        .cornerRadius(8)
                                        .padding(.horizontal, 20)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 1)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    Text("Guest mode")
                                        .PopBold(size: 16, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                }
                            }
                        }
                        
                        Spacer(minLength: 25)
                        
                        HStack {
                            Text("Have account?")
                                .Pop(size: 15,
                                     color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                .padding(.leading)
                            
                            Button(action: {
                                championSignInModel.isLog = true
                            }) {
                                Text("Log in")
                                    .PopBold(size: 15,
                                         color: Color(red: 153/255, green: 153/255, blue: 186/255))
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $championSignInModel.isLog, content: {
                ChampionLoginView()
            })
            
            .fullScreenCover(isPresented: $championSignInModel.isTab, content: {
                ChampionTabBarView()
            })
            
            .fullScreenCover(isPresented: $championSignInModel.isOnb, content: {
                ChampionOnboardingView()
            })
            
            .alert(isPresented: $championSignInModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(championSignInModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    ChampionSignInView()
}


