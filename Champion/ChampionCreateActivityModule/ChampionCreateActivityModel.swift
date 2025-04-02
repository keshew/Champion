import SwiftUI

struct TaskModel: Identifiable, Codable {
    var id = UUID().uuidString
    var typeActivity: TypeActivity
    var date: Date
    var time: Date
}

enum TypeActivity: String, Codable {
    case dev = "Soccer Court"
    case dev1 = "Swimming Pool"
    case dev2 = "Sports Massage"
    case dev3 = "Gym Access"
    case dev4 = "Healthy Restaurant"
    case dev5 = "Yoga"
    case dev6 = "Cycling"
    case dev7 = "Golf"
    case dev8 = "Running"
    case dev9 = "Other"
}

struct ChampionCreateActivityModel {
    let dayOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let arrayModel = [ActivityModel(image: "div", label: "Soccer Court", text: "Indoor playground", color: Color(red: 0/255, green: 32/255, blue: 134/255)),
                      ActivityModel(image: "div2", label: "Swimming Pool", text: "50 m swimming pool", color: Color(red: 0/255, green: 77/255, blue: 135/255)),
                      ActivityModel(image: "div3", label: "Sports Massage", text: "Experienced craftsmen", color: Color(red: 77/255, green: 0/255, blue: 116/255)),
                      ActivityModel(image: "div4", label: "Gym Access", text: "Open 24/7", color: Color(red: 0/255, green: 32/255, blue: 134/255)),
                      ActivityModel(image: "div5", label: "Healthy Restaurant", text: "Fresh food", color: Color(red: 0/255, green: 77/255, blue: 135/255)),
                      ActivityModel(image: "div6", label: "Yoga", text: "Fresh food", color: Color(red: 52/255, green: 0/255, blue: 135/255)),
                      ActivityModel(image: "div7", label: "Cycling", text: "Fresh food", color: Color(red: 0/255, green: 32/255, blue: 134/255)),
                      ActivityModel(image: "div8", label: "Golf", text: "50 m swimming pool", color: Color(red: 77/255, green: 0/255, blue: 116/255)),
                      ActivityModel(image: "div9", label: "Running", text: "Open 24/7", color: Color(red: 0/255, green: 77/255, blue: 135/255)),
    ]
}


