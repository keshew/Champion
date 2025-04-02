import SwiftUI

struct ChampionCalendarView: View {
    @StateObject var championCalendarModel =  ChampionCalendarViewModel()
    var userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        GeometryReader { geometry in
            if championCalendarModel.isSecondCalendar {
                CalendarView(geometry: geometry,
                    championCalendarModel: championCalendarModel)
                .fullScreenCover(isPresented: $championCalendarModel.isAdd) {
                    ChampionCreateActivityView()
                }
                .onChange(of: championCalendarModel.isAdd) { _ in
                    championCalendarModel.loadTasksForDate()
                }
            } else {
                ZStack {
                    Color(red: 0/255, green: 0/255, blue: 84/255)
                        .ignoresSafeArea()
                    
                    GeometryReader { geometry in
                        VStack {
                            HStack {
                                Text("Calendar")
                                    .PopBold(size: 28)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(championCalendarModel.formattedDate)
                                        .PopBold(size: 18)
                                }
                                .padding(.leading, geometry.size.width * 0.05)
                                
                                Spacer()
                                
                                Button(action: {
                                    championCalendarModel.previousDay()
                                }) {
                                    Image(.leftArrow)
                                        .resizable()
                                        .frame(width: 10,
                                               height: 17)
                                }
                                .padding(.trailing)
                                
                                Button(action: {
                                    championCalendarModel.nextDay()
                                }) {
                                    Image(.rightArrow)
                                        .resizable()
                                        .frame(width: 10,
                                               height: 17)
                                }
                                .padding(.trailing, 30)
                                
                                Button(action: {
                                    championCalendarModel.isFirstCalendar = true
                                    championCalendarModel.isSecondCalendar = false
                                }) {
                                    Image(championCalendarModel.isFirstCalendar ? .calendar1Picked : .calendar1)
                                        .resizable()
                                        .frame(width: 30,
                                               height: 32)
                                }
                                
                                Button(action: {
                                    championCalendarModel.isFirstCalendar = false
                                    championCalendarModel.isSecondCalendar = true
                                }) {
                                    Image(championCalendarModel.isSecondCalendar ? .calendar2Picked : .calendar2)
                                        .resizable()
                                        .frame(width: 30,
                                               height: 32)
                                }
                                .padding(.trailing)
                            }
                            .padding(.top)
                            
                            ScrollView(showsIndicators: false) {
                                HStack {
                                    VStack(spacing: 40) {
                                        ForEach(championCalendarModel.contact.timeArray.indices,
                                                id: \.self) { index in
                                            Text(championCalendarModel.contact.timeArray[index])
                                                .Pop(size: 14,
                                                     color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                                .padding(.leading)
                                        }
                                    }
                                    
                                    VStack(spacing: 8.5) {
                                        ForEach(championCalendarModel.contact.timeArray.indices,
                                                id: \.self) { index in
                                            let tasks = championCalendarModel.tasks
                                                let task = tasks.first(where: { formatTime($0.time) == championCalendarModel.contact.timeArray[index] })
                                                if let task = task {
                                                    FulledModelTask(task: task, time: championCalendarModel.contact.timeArray[index])
                                                        .padding(.leading)
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
                                   height: geometry.size.height * 0.63)
                            .padding(.top, 20)
                        }
                    }
                    
                    Button(action: {
                        championCalendarModel.isAdd = true
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                                .frame(height: 56)
                                .cornerRadius(8)
                                .padding(.horizontal)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: -5)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: -5)
                                .shadow(color: Color(red: 0/255, green: 0/255, blue: 84/255),
                                        radius: 5, y: -5)
                            
                            HStack {
                                Image(.plus)
                                    .resizable()
                                    .frame(width: 14, height: 16)
                                
                                Text("Add Activity")
                                    .PopBold(size: 16, color: Color(red: 7/255, green: 9/255, blue: 84/255))
                            }
                        }
                    }
                    .disabled(userDefaultsManager.isGuest() ? true : false)
                    .opacity(userDefaultsManager.isGuest() ? 0.5 : 1)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.16)
                    
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
                    .position(getPosition(for: geometry.size.width, geometry: geometry))
                }
                .fullScreenCover(isPresented: $championCalendarModel.isAdd) {
                    ChampionCreateActivityView()
                }
                
                .onChange(of: championCalendarModel.isAdd) { _ in
                    championCalendarModel.loadTasksForDate()
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
            return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 9.7)
        } else if width > 650 {
            return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 7.99)
          } else if width > 400 {
              return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 6.1)
          } else if width < 380 {
              return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 4.7)
          } else {
              return CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 6.1)
          }
      }
}

#Preview {
    ChampionCalendarView()
}

struct CalendarView: View {
    var geometry: GeometryProxy
    var championCalendarModel = ChampionCalendarViewModel()
    var userDefaultsManager = UserDefaultsManager()
    var body: some View {
        ZStack {
            Color(red: 0/255, green: 0/255, blue: 84/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                HStack {
                    Text("Calendar")
                        .PopBold(size: 28)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(championCalendarModel.currentMonth + " " + championCalendarModel.currentYear)
                            .PopBold(size: 18)
                    }
                    .padding(.leading, geometry.size.width * 0.05)
                    
                    Spacer()
                    
                    Button(action: {
                        championCalendarModel.previousMonth()
                    }) {
                        Image(.leftArrow)
                            .resizable()
                            .frame(width: 10,
                                   height: 17)
                    }
                    .padding(.trailing)
                    
                    Button(action: {
                        championCalendarModel.nextMonth()
                    }) {
                        Image(.rightArrow)
                            .resizable()
                            .frame(width: 10,
                                   height: 17)
                    }
                    .padding(.trailing, 30)
                    
                    Button(action: {
                        championCalendarModel.isFirstCalendar = true
                        championCalendarModel.isSecondCalendar = false
                    }) {
                        Image(championCalendarModel.isFirstCalendar ? .calendar1Picked : .calendar1)
                            .resizable()
                            .frame(width: 30,
                                   height: 32)
                    }
                    
                    Button(action: {
                        championCalendarModel.isFirstCalendar = false
                        championCalendarModel.isSecondCalendar = true
                    }) {
                        Image(championCalendarModel.isSecondCalendar ? .calendar2Picked : .calendar2)
                            .resizable()
                            .frame(width: 30,
                                   height: 32)
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                
                HStack(spacing: geometry.size.width * 0.079) {
                    ForEach(0..<7, id: \.self) { i in
                        CalendarDayOfWeekCell(text: championCalendarModel.daysOfWeek[i], geometry: geometry)
                    }
                }
                
                ForEach(championCalendarModel.dates.indices, id: \.self) { weekIndex in
                    HStack(spacing: getSpacing(for: geometry.size.width)) {
                        ForEach(0..<7, id: \.self) { dayIndex in
                            if dayIndex < championCalendarModel.dates[weekIndex].count {
                                let date = championCalendarModel.dates[weekIndex][dayIndex]
                                let isCurrentMonth = Calendar.current.isDate(date, equalTo: championCalendarModel.currentDate, toGranularity: .month)
                                let isToday = championCalendarModel.isToday(date: date)
                                
                                CalendarDayCell(
                                    text: "\(Calendar.current.component(.day, from: date))",
                                    isCurrentMonth: isCurrentMonth,
                                    isToday: isToday,
                                    date: date,
                                    sportCalendarModel: championCalendarModel,
                                    geometry: geometry
                                )
                            } else {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 45,
                                           height: 33)
                                    .opacity(0)
                            }
                        }
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)
                    .padding(.bottom)
                }
                
                HStack {
                    Text("Today's Schedule")
                        .PopBold(size: 18)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                if let tasks = userDefaultsManager.loadTasks() {
                                  ForEach(tasks) { task in
                                      ZStack {
                                          Rectangle()
                                              .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                                              .frame(height: 56)
                                              .cornerRadius(8)
                                          
                                          HStack {
                                              Circle()
                                                  .fill(getColor(for: task.typeActivity))
                                                  .frame(width: 8, height: 8)
                                              
                                              Text(task.typeActivity.rawValue)
                                                  .PopBold(size: 16)
                                                  .padding(.leading, 5)
                                              
                                              Spacer()
                                              
                                              Text(formatTime(task.time))
                                                  .Pop(size: 14, color: Color(red: 77/255, green: 77/255, blue: 136/255))
                                                  .padding(.trailing)
                                          }
                                          .padding(.leading)
                                      }
                                      .padding(.horizontal)
                                  }
                              } else {
                                  Text("No tasks available")
                                      .PopBold(size: 20)
                                      .padding()
                              }
                
                Color(.clear)
                    .frame(height: 140)
            }
          
            Button(action: {
                championCalendarModel.isAdd = true
            }) {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                        .frame(height: 56)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(.plus)
                            .resizable()
                            .frame(width: 14, height: 16)
                        
                        Text("Add Activity")
                            .PopBold(size: 16, color: Color(red: 7/255, green: 9/255, blue: 84/255))
                    }
                }
            }
            .disabled(userDefaultsManager.isGuest() ? true : false)
            .opacity(userDefaultsManager.isGuest() ? 0.5 : 1)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.16)
        }
    }
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func getColor(for type: TypeActivity) -> Color {
        switch type {
        case .dev:
            return Color(red: 0/255, green: 32/255, blue: 134/255)
        case .dev1:
            return Color(red: 0/255, green: 77/255, blue: 135/255)
        case .dev2:
            return Color(red: 77/255, green: 0/255, blue: 116/255)
        case .dev3:
            return Color(red: 0/255, green: 32/255, blue: 134/255)
        case .dev4:
            return Color(red: 0/255, green: 77/255, blue: 135/255)
        case .dev5:
            return Color(red: 52/255, green: 0/255, blue: 135/255)
        case .dev6:
            return Color(red: 0/255, green: 32/255, blue: 134/255)
        case .dev7:
            return Color(red: 77/255, green: 0/255, blue: 116/255)
        case .dev8:
            return Color(red: 0/255, green: 77/255, blue: 135/255)
        case .dev9:
            return Color(red: 0/255, green: 77/255, blue: 135/255)
        }
    }
    
    func getSpacing(for width: CGFloat) -> CGFloat {
        if width > 850 {
            return 58
        } else if width > 650 {
            return 44
          } else if width > 400 {
              return 8
          } else if width < 380 {
              return 3
          } else {
              return 8
          }
      }
}
