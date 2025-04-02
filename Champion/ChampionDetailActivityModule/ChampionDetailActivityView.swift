import SwiftUI

struct ChampionDetailActivityView: View {
    @StateObject var championDetailActivityModel = ChampionDetailActivityViewModel()
    @Environment(\.presentationMode) var presentationMode
    let selectedActivity: ActivityModel
    var userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.leftArrow3)
                                .resizable()
                                .frame(width: 17, height: 20)
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                        
                        Text(selectedActivity.label)
                            .PopBold(size: 20,
                                     color: Color(red: 0/255, green: 255/255, blue: 255/255))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.trailing, 40)
                        Spacer()
                    }
                    .padding(.top)
                    
                    ZStack {
                        Color(red: 0/255, green: 0/255, blue: 84/255)
                            .ignoresSafeArea()
                        
                        GeometryReader { geometry in
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(championDetailActivityModel.formattedDate)
                                            .PopBold(size: 18)
                                    }
                                    .padding(.leading, geometry.size.width * 0.05)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        championDetailActivityModel.previousDay()
                                    }) {
                                        Image(.leftArrow)
                                            .resizable()
                                            .frame(width: 10,
                                                   height: 17)
                                    }
                                    .padding(.trailing)
                                    
                                    Button(action: {
                                        championDetailActivityModel.nextDay()
                                    }) {
                                        Image(.rightArrow)
                                            .resizable()
                                            .frame(width: 10,
                                                   height: 17)
                                    }
                                    .padding(.trailing, 30)
                                }
                                
                                ScrollView(showsIndicators: false) {
                                    HStack {
                                        VStack(spacing: 40) {
                                            ForEach(championDetailActivityModel.contact.timeArray.indices,
                                                    id: \.self) { index in
                                                Text(championDetailActivityModel.contact.timeArray[index])
                                                    .Pop(size: 14,
                                                         color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                                    .padding(.leading)
                                            }
                                        }
                                        
                                        VStack(spacing: 8.5) {
                                            ForEach(championDetailActivityModel.contact.timeArray.indices,
                                                    id: \.self) { index in
                                                if let tasks = userDefaultsManager.loadTasks() {
                                                    let task = tasks.first(where: {
                                                        Calendar.current.isDate($0.date, inSameDayAs: championDetailActivityModel.currentDate) &&
                                                        formatTime($0.time) == championDetailActivityModel.contact.timeArray[index] &&
                                                        getActivityName(for: $0.typeActivity) == selectedActivity.label
                                                    })
                                                    if let task = task {
                                                        FulledModelTask(task: task, time: championDetailActivityModel.contact.timeArray[index])
                                                            .padding(.leading)
                                                    } else {
                                                        Rectangle()
                                                            .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                                                            .frame(height: 51.6)
                                                            .cornerRadius(8)
                                                            .padding(.horizontal)
                                                    }
                                                } else {
                                                    Rectangle()
                                                        .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                                                        .frame(height: 51.6)
                                                        .cornerRadius(8)
                                                        .padding(.horizontal)
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height * 0.83)
                                .padding(.top)
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 0/255, blue: 84/255))
                                .frame(height: 16)
                                .cornerRadius(8)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: 5)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: 5)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: 5)
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 22)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 0/255, blue: 84/255))
                                .frame(height: 56)
                                .cornerRadius(8)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: -5)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: -5)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: -5)
                        }
                        .position(getPosition(for: geometry.size.width, geometry: geometry))
                    }
                }
            }
        }
    }
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func getPosition(for width: CGFloat, geometry: GeometryProxy) -> CGPoint {
        if width > 850 {
            return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 1.14)
        } else if width > 650 {
            return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 1.13)
          } else if width > 400 {
              return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 1.12)
          } else if width < 380 {
              return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 1.12)
          } else {
              return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 1.12)
          }
      }
    
    private func getActivityName(for type: TypeActivity) -> String {
        switch type {
        case .dev:
            return "Soccer Court"
        case .dev1:
            return "Swimming Pool"
        case .dev2:
            return "Sports Massage"
        case .dev3:
            return "Gym Access"
        case .dev4:
            return "Healthy Restaurant"
        case .dev5:
            return "Yoga"
        case .dev6:
            return "Cycling"
        case .dev7:
            return "Golf"
        case .dev8:
            return "Running"
        case .dev9:
            return "Other"
        }
    }
}


#Preview {
    let activ = ActivityModel(image: "", label: "", text: "", color: .white)
    return ChampionDetailActivityView(selectedActivity: activ)
}



