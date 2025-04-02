import SwiftUI

class ChampionDetailActivityViewModel: ObservableObject {
    let contact = ChampionDetailActivityModel()
    @Published var currentDate = Date()
    @Published var dates: [[Date]] = []
    @Published var isFirstCalendar = true
    @Published var isSecondCalendar = false
    @Published var isAdd = false
    
    init() {
        generateDates()
    }
    
    private let calendar = Calendar.current

    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    var currentMonth: String {
        monthFormatter.string(from: currentDate)
    }
    
    private var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    var currentYear: String {
        yearFormatter.string(from: currentDate)
    }
    
    var daysOfWeek: [String] {
        contact.dayOfWeek
    }
    
    func generateDates() {
        dates = getWeeks()
    }
    
    func isDateInPast(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        return date < startOfToday
    }
    
    func previousMonth() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        let month = components.month!
        if month == 2 {
            let day = calendar.component(.day, from: currentDate)
            if day <= 14 {
                currentDate = calendar.date(byAdding: .day, value: -14, to: currentDate)!
            } else {
                currentDate = calendar.date(byAdding: .day, value: -14, to: currentDate)!
            }
        } else {
            let day = calendar.component(.day, from: currentDate)
            if day <= 15 {
                currentDate = calendar.date(byAdding: .day, value: -15, to: currentDate)!
            } else {
                currentDate = calendar.date(byAdding: .day, value: -16, to: currentDate)!
            }
        }
        
        generateDates()
    }

    func nextMonth() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        let month = components.month!
        
        if month == 2 {
            let day = calendar.component(.day, from: currentDate)
            if day <= 14 {
                currentDate = calendar.date(byAdding: .day, value: 14, to: currentDate)!
            } else {
                currentDate = calendar.date(byAdding: .day, value: 14, to: currentDate)!
            }
        } else {
            let day = calendar.component(.day, from: currentDate)
            if day <= 15 {
                currentDate = calendar.date(byAdding: .day, value: 15, to: currentDate)!
            } else {
                currentDate = calendar.date(byAdding: .day, value: 15, to: currentDate)!
            }
        }
        
        generateDates()
    }
    
    func isToday(date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
    
    private func getWeeks() -> [[Date]] {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 0
        
        let startDay: Int
        let endDay: Int
        
        if day <= 15 {
            startDay = 1
            endDay = min(15, daysInMonth)
        } else {
            startDay = 16
            endDay = daysInMonth
        }
        
        var dates: [Date] = []
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        for dayNumber in startDay...endDay {
            guard let date = calendar.date(from: DateComponents(
                year: components.year!,
                month: components.month!,
                day: dayNumber
            )) else { continue }
            dates.append(date)
        }
        
        return dates.chunked(into: 7)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: currentDate)
    }

    func previousDay() {
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        generateDates()
    }

    func nextDay() {
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        generateDates()
    }
}
