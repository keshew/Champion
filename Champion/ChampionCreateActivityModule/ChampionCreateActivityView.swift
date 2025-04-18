import SwiftUI

extension Notification.Name {
    static let didSaveTask = Notification.Name("didSaveTask")
}

struct ChampionCreateActivityView: View {
    @StateObject var championCreateActivityModel = ChampionCreateActivityViewModel()
    @Environment(\.presentationMode) var presentationMode
    var userDefaultsManager = UserDefaultsManager()
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

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
                            
                            Text("Book Activity")
                                .PopBold(size: 20, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                            
                            Spacer(minLength: 135)
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Text("Select Activity Type")
                                .Pop(size: 14)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        SimpleDropDownView(
                            hint: "Select activity",
                            options: [
                                ("Soccer Court", "div"),
                                ("Swimming Pool", "div2"),
                                ("Sports Massage", "div3"),
                                ("Gym Access", "div4"),
                                ("Healthy Restaurant", "div5"),
                                ("Yoga", "div6"),
                                ("Cycling", "div7"),
                                ("Golf", "div8"),
                                ("Running", "div9")
                            ],
                            activityModels: championCreateActivityModel.contact.arrayModel,
                            selection: $championCreateActivityModel.selection,
                            image: $championCreateActivityModel.image
                        )
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Text("Select Date")
                                .Pop(size: 14)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                                .frame(height: getPosition(for: geometry.size.width,
                                                           geometry: geometry))
                                .cornerRadius(8)
                            
                            VStack {
                                HStack {
                                    Button(action: championCreateActivityModel.previousWeek) {
                                        Image(.leftArrow4)
                                            .resizable()
                                            .frame(width: 10, height: 16)
                                    }
                                    .padding(.leading, 20)
                                    
                                    Spacer()
                                    
                                    Text(championCreateActivityModel.getMonthYear())
                                        .Pop(size: 16)
                                    
                                    Spacer()
                                    
                                    Button(action: championCreateActivityModel.nextWeek) {
                                        Image(.rightArrow4)
                                            .resizable()
                                            .frame(width: 10, height: 16)
                                    }
                                    .padding(.trailing, 20)
                                }
                                .padding(.top)
                                
                                HStack(spacing: geometry.size.width * 0.065) {
                                    ForEach(0..<7, id: \.self) { i in
                                        CalendarDayOfWeekCell(text: championCreateActivityModel.dayOfWeek[i],
                                                              geometry: geometry)
                                    }
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 8) {
                                    ForEach(championCreateActivityModel.week, id: \.self) { date in
                                        let day = Calendar.current.component(.day, from: date)
                                        WeekCalendarDayCell(
                                            text: "\(day)",
                                            isToday: Calendar.current.isDateInToday(date),
                                            isSelected: date == championCreateActivityModel.selectedDate,
                                            geometry: geometry,
                                            onSelect: {
                                                championCreateActivityModel.selectedDate = date
                                                championCreateActivityModel.dates = [[date]]
                                            },
                                            date: date
                                        )
                                        .padding(.horizontal, -8)
                                        .frame(height: 40)
                                    }
                                }
                                .padding(.bottom)
                                .frame(height: 40)
                            }
                        }
                        .padding(.horizontal, 15)
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Text("Select Time")
                                .Pop(size: 14)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Button(action: {
                                        championCreateActivityModel.selectedTime = "\(hour):00"
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .fill(championCreateActivityModel.selectedTime == "\(hour):00"
                                                      ? Color(red: 0/255, green: 255/255, blue: 255/255)
                                                      : Color(red: 26/255, green: 26/255, blue: 101/255))
                                                .cornerRadius(8)
                                                .frame(width: 106, height: 40)
                                            
                                            Text("\(hour):00")
                                                .Pop(size: 16, color: championCreateActivityModel.selectedTime == "\(hour):00" ? .black : .white)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 40)
                        
                        Button(action: {
                            if championCreateActivityModel.selection == "" || championCreateActivityModel.selectedDate == Date.distantPast || championCreateActivityModel.selectedTime == "" {
                                
                                championCreateActivityModel.showIncompleteSelectionAlert = true
                            } else {
                                let task = TaskModel(
                                    typeActivity: championCreateActivityModel.getActivityType(),
                                    date: championCreateActivityModel.selectedDate ?? Date(),
                                    time: championCreateActivityModel.getTime()
                                )
                                
                                let dateFormatter = ISO8601DateFormatter()
                                let selectedDateTime = Calendar.current.date(bySettingHour: Int(championCreateActivityModel.selectedTime.components(separatedBy: ":").first ?? "0") ?? 0, minute: 0, second: 0, of: championCreateActivityModel.selectedDate ?? Date())!
                                let isoDateString = dateFormatter.string(from: selectedDateTime)
                                
                                NotificationManager.shared.scheduleNotificationEvent(event: task)
                                userDefaultsManager.appendTask(task)
                                NetworkService().saveTask(phone: userDefaultsManager.getEmail() ?? "",
                                                          password: userDefaultsManager.getPassword() ?? "",
                                                          date: isoDateString,
                                                          typeactivity: championCreateActivityModel.getActivityType().rawValue) { response, error in
                                    if let error = error {
                                        errorMessage = "Failed to save task: \(error.localizedDescription)"
                                        showErrorAlert = true
                                        return
                                    }
                                    
                                    if let response = response, let _ = response.message {
                                        let task = TaskModel(
                                            typeActivity: championCreateActivityModel.getActivityType(),
                                            date: championCreateActivityModel.selectedDate ?? Date(),
                                            time: championCreateActivityModel.getTime()
                                        )
                                        NotificationCenter.default.post(name: .didSaveTask, object: nil)
                                        NotificationManager.shared.scheduleNotificationEvent(event: task)
                                    } else if let response = response, let error = response.error {
                                        errorMessage = "Failed to save task: \(error)"
                                        showErrorAlert = true
                                    } else {
                                        errorMessage = "Unknown error occurred while saving the task."
                                        showErrorAlert = true
                                    }
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                                    .frame(height: 56)
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                
                                HStack {
                                    Text("Confirm Booking")
                                        .PopBold(size: 16, color: Color(red: 7/255, green: 9/255, blue: 84/255))
                                    
                                    Image(.checkmarkCustom)
                                        .resizable()
                                        .frame(width: 14, height: 16)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .alert(isPresented: $championCreateActivityModel.showIncompleteSelectionAlert) {
                Alert(title: Text("All fields must be pciked"), message: Text("Please, select type of activity, date and time"), dismissButton: .default(Text("ОК")))
            }
        }
    }
    func getPosition(for width: CGFloat, geometry: GeometryProxy) -> CGFloat {
        if width > 850 {
            return 198
        } else if width > 650 {
            return 178
          } else if width > 400 {
              return 138
          } else if width < 380 {
              return 138
          } else {
              return 138
          }
      }
}

struct WeekCalendarDayCell: View {
    let text: String
    let isToday: Bool
    let isSelected: Bool
    let geometry: GeometryProxy
    let onSelect: () -> Void
    let date: Date
    var body: some View {
        Button(action: onSelect) {
            VStack {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color(red: 0/255, green: 255/255, blue: 255/255))
                            .frame(width: 30, height: 30)
                    }
                    
                    Text(text)
                        .Pop(size: 14, color: isSelected ? .black : getColor())
                }
            }
            .padding(.vertical, 8)
            .frame(width: geometry.size.width * 0.14)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled())
    }
    
    private func getColor() -> Color {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let cellDate = calendar.startOfDay(for: date)
        
        if calendar.compare(cellDate, to: today, toGranularity: .day) == .orderedAscending {
            return Color(red: 95/255, green: 95/255, blue: 148/255)
        } else {
            return .white
        }
    }
    
    private func isDisabled() -> Bool {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let cellDate = calendar.startOfDay(for: date)
            
            return calendar.compare(cellDate, to: today, toGranularity: .day) == .orderedAscending
        }
}

#Preview {
    ChampionCreateActivityView()
}
