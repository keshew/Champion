import SwiftUI

class ChampionCreateActivityViewModel: ObservableObject {
    let contact = ChampionCreateActivityModel()
    @Published var selection: String?
    @Published var image: String?
    @Published var selectedDate: Date? = nil
    @Published var dates: [[Date]] = []
    @Published var week: [Date] = []
    @Published var showIncompleteSelectionAlert = false
    @Published var selectedTime: String = ""
    init() {
        generateWeek()
    }
    
    let dayOfWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let calendar = Calendar.current
    @Published var currentDate = Date()
    
    func generateWeek() {
        let today = calendar.startOfDay(for: currentDate)
        guard let weekDay = calendar.dateComponents([.weekday], from: today).weekday else { return }
        
        let daysToSubtract = weekDay - calendar.firstWeekday
        guard let startOfWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: today) else { return }
        
        week = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }
    
    func previousWeek() {
        currentDate = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        generateWeek()
    }
    
    func nextWeek() {
        currentDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        generateWeek()
    }
    
    func getMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    func getActivityType() -> TypeActivity {
        guard let index = contact.arrayModel.firstIndex(where: { $0.label == selection }) else {
            return .dev9
        }
        
        switch index {
        case 0:
            return .dev
        case 1:
            return .dev1
        case 2:
            return .dev2
        case 3:
            return .dev3
        case 4:
            return .dev4
        case 5:
            return .dev5
        case 6:
            return .dev6
        case 7:
            return .dev7
        case 8:
            return .dev8
        default:
            return .dev9
        }
    }
      
      func getTime() -> Date {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "HH:mm"
          
          if let date = dateFormatter.date(from: selectedTime) {
              return date
          } else {
              return Date()
          }
      }
}
