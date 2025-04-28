import SwiftUI

struct NewsModel {
    var color: Color
    var label: String
    var date: String
    var text: String
    var desc: String
    var detail: DetailInfo
}

struct DetailInfo {
    var title: String
    var desc: String
    var images: [String]
    var text: [String]
}

struct ChampionNewsModel {
    let model = [NewsModel(color: Color(red: 0/255, green: 106/255, blue: 250/255),
                           label: "Facilities",
                           date: "April 15, 2025",
                           text: "New Swimming Pool Hours",
                           desc: "We're extending our swimming pool hours to accommodate early morning and late",
                           detail: DetailInfo(title: "New Swimming Pool Hours and Schedule Updates",
                                              desc: "We're excited to announce extended swimming pool hours to better serve our members' diverse schedules. Starting May 1st, 2025, we're implementing new operating hours to accommodate early morning and late evening swimmers.",
                                              images: [ChampionImageName.swim.rawValue,
                                                       ChampionImageName.edc.rawValue],
                                              text: ["Lap Swimming", "Swimming Classes"])),
                 NewsModel(color: Color(red: 255/255, green: 0/255, blue: 188/255),
                           label: "Event",
                           date: "April 22, 2025",
                           text: "Wellness Workshop Series",
                           desc: "Join our new wellness workshop series featuring nutrition experts and fitness",
                           detail: DetailInfo(title: "Wellness Workshop Series",
                                              desc: "Starting April 22, 2025, join our expert-led sessions featuring top nutrition specialists and fitness coaches. This initiative is designed to support your holistic well-being journey with practical advice and hands-on activities.",
                                              images: [ChampionImageName.edc.rawValue, ChampionImageName.sportic.rawValue],
                                              text: ["Nutrition education", "Fitness planning"])),
                 NewsModel(color: Color(red: 0/255, green: 106/255, blue: 250/255),
                           label: "Facilities",
                           date: "April 10, 2025",
                           text: "New Gym Equipment Arrived",
                           desc: "We've upgraded our gym with state-of-the-art equipment. Come try our new cardio and",
                           detail: DetailInfo(title: "New Gym Equipment Arrived",
                                              desc: "As of April 10, 2025, our facility is now equipped with state-of-the-art cardio and strength-training equipment, providing a superior workout experience for all fitness levels.",
                                              images: [ChampionImageName.sportic.rawValue, ChampionImageName.joga.rawValue],
                                              text: ["Enhanced free-weight zones", "Advanced treadmills and ellipticals"])),
                 NewsModel(color: Color(red: 61/255, green: 61/255, blue: 125/255),
                           label: "Membership",
                           date: "April 5, 2025",
                           text: "New Premium Tier Benefits",
                           desc: "We're introducing enhanced benefits for our premium tier members including priority",
                           detail: DetailInfo(title: "New Premium Tier Benefits",
                                              desc: "Starting April 5, 2025, premium members will enjoy expanded benefits, including priority booking, exclusive classes, and special offers, crafted to elevate your club experience.",
                                              images: [ChampionImageName.edc.rawValue, ChampionImageName.star.rawValue],
                                              text: ["Priority access to popular classes", "Special members-only events"])),
                 NewsModel(color: Color(red: 255/255, green: 0/255, blue: 188/255),
                           label: "Event",
                           date: "April 28, 2025",
                           text: "Family Day at Elite Club",
                           desc: "Bring your family for a day of fun activities, games, and special dining options at our",
                           detail: DetailInfo(title: "Family Day at Elite Club",
                                              desc: "Join us on April 28, 2025, for Family Day at Elite Club. Enjoy a variety of activities, games, and special dining experiences designed for all ages.",
                                              images: [ChampionImageName.joga.rawValue, ChampionImageName.sportic.rawValue],
                                              text: ["Kids' entertainment and activities", "Family-friendly games and challenges"]))]
}


