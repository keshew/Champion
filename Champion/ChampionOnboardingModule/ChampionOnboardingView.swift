import SwiftUI

struct ChampionOnboardingView: View {
    @StateObject var championOnboardingModel =  ChampionOnboardingViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image(.champLabel2)
                            .resizable()
                            .frame(width: 67, height: 114)
                        
                        Spacer(minLength: 30)
                        
                        Image(championOnboardingModel.contact.arrayImage[championOnboardingModel.currentIndex])
                            .resizable()
                            .frame(width: 133, height: 288)
                        
                        Spacer(minLength: 30)
                        
                        Text(championOnboardingModel.contact.labelArray[championOnboardingModel.currentIndex])
                            .PopBold(size: 24)
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 10)
                        
                        Text(championOnboardingModel.contact.labelArray2[championOnboardingModel.currentIndex])
                            .Pop(size: 16,
                                 color: Color(red: 153/255, green: 153/255, blue: 186/255))
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: championOnboardingModel.currentIndex == 0 ? 20 : 31)

                        HStack {
                            Button(action: {
                                if championOnboardingModel.currentIndex > 0 {
                                    championOnboardingModel.currentIndex -= 1
                                }
                            }) {
                                Image(.leftArrow)
                                    .resizable()
                                    .frame(width: 13, height: 20)
                                    .padding(.leading, 30)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Circle()
                                    .fill(championOnboardingModel.currentIndex == 0 ? Color(red: 0/255, green: 255/255, blue: 255/255) : Color(red: 51/255, green: 51/255, blue: 117/255))
                                    .frame(width: 8, height: 8)
                                
                                Circle()
                                    .fill(championOnboardingModel.currentIndex == 1 ? Color(red: 0/255, green: 255/255, blue: 255/255) : Color(red: 51/255, green: 51/255, blue: 117/255))
                                    .frame(width: 8, height: 8)
                                
                                Circle()
                                    .fill(championOnboardingModel.currentIndex == 2 ? Color(red: 0/255, green: 255/255, blue: 255/255) : Color(red: 51/255, green: 51/255, blue: 117/255))
                                    .frame(width: 8, height: 8)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                if championOnboardingModel.currentIndex < 2 {
                                    championOnboardingModel.currentIndex += 1
                                }
                            }) {
                                Image(.rightArrow)
                                    .resizable()
                                    .frame(width: 13, height: 20)
                                    .padding(.trailing, 30)
                            }
                        }
                        
                        Spacer(minLength: 50)
                        
                        Button(action: {
                            championOnboardingModel.isGetStarted = true
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 178/255, green: 0/255, blue: 255/255))
                                    .frame(height: 56)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Get Started")
                                        .PopBold(size: 16, color: Color(red: 0/255, green: 0/255, blue: 84/255))
                                    
                                    Image(.arrowRight)
                                        .resizable()
                                        .frame(width: 14, height: 14)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $championOnboardingModel.isGetStarted) {
                ChampionTabBarView()
            }
        }
    }
}

#Preview {
    ChampionOnboardingView()
}

