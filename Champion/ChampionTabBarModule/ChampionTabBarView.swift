import SwiftUI

struct ChampionTabBarView: View {
    @StateObject var championTabBarModel =  ChampionTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Calendar
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Calendar {
                    ChampionCalendarView()
                } else if selectedTab == .Tasks {
                    ChampionActivityView()
                } else if selectedTab == .Profile {
                    ChampionProfileView()
                } else if selectedTab == .Code {
                    ChampionCodeView()
                }  else if selectedTab == .News {
                    ChampionNewsView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChampionTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Calendar
        case News
        case Tasks
        case Code
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Rectangle()
                    .fill(Color(red: 0/255, green: 0/255, blue: 84/255))
                    .frame(height: 100)
                    .cornerRadius(30)
                    .edgesIgnoringSafeArea(.bottom)
                
                    .offset(y: 35)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(red: 239/255, green: 240/255, blue: 244/225),
                                    lineWidth: 1)
                            .offset(y: 35)
                    )
                
                Rectangle()
                    .fill(Color(red: 0/255, green: 0/255, blue: 84/255))
                    .frame(height: 50)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: 110)
                    .shadow(color: Color.white.opacity(0.5), radius: 45, x: 0, y: -15)
            }
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Calendar, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .News, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Tasks, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Code, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab5", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, 5)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                if tab == CustomTabBar.TabType.Tasks {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .frame(width: 32, height: 26)
                        .opacity(selectedTab == tab ? 1 : 0.4)
                } else if tab == CustomTabBar.TabType.Code {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .opacity(selectedTab == tab ? 1 : 0.4)
                } else if tab == CustomTabBar.TabType.News {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .frame(width: 33, height: 28)
                        .opacity(selectedTab == tab ? 1 : 0.4)
                } else {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .frame(width: 24, height: 28)
                        .opacity(selectedTab == tab ? 1 : 0.4)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
