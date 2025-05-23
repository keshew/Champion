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
                                
                                CustomTextFiled(text: $championSignInModel.phone,
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
                                championSignInModel.isNew = true
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
            
            .fullScreenCover(isPresented: $championSignInModel.isNew) {
                ChampionNewsView()
            }
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


