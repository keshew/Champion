import SwiftUI

struct SimpleDropDownView: View {
    var hint: String
    var options: [(String, String)]
    var activityModels: [ActivityModel]
    @Binding var selection: String?
    @Binding var image: String?
    @State private var showOptions = false
    @State private var zIndex: Double = 1000

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Image(image ?? (showOptions ? "selectActivity2" : "selectActivity"))
                    .resizable()
                    .frame(width: 48, height: 48)

                Text(selection ?? hint)
                    .foregroundStyle(selection != nil ? .white : (showOptions ? .white : Color(red: 48/255, green: 66/255, blue: 87/255)))
                    .lineLimit(1)

                Spacer(minLength: 0)

                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 14, height: 8)
                    .foregroundStyle(selection != nil ? .white : (showOptions ? .white : Color(red: 48/255, green: 66/255, blue: 87/255)))
                    .rotationEffect(.init(degrees: showOptions ? -180 : 0))
                    .padding(.trailing, 5)
            }
            .padding(.horizontal, 15)
            .frame(height: 82)
            .background(Color(red: 0/255, green: 0/255, blue: 84/255))
            .contentShape(Rectangle())
            .zIndex(zIndex)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(getBorderColor(), lineWidth: 1)
                    .padding(.horizontal)
            }

            if showOptions {
                OptionsView()
                    .zIndex(zIndex + 1)
                    .padding(.top, 5)
                    .transition(.identity)
                    .animation(.easeInOut(duration: 0.3), value: showOptions)
                    .padding(.horizontal, 15)
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                showOptions.toggle()
                zIndex += 1
            }
        }
    }

    private func getBorderColor() -> Color {
        if let selectedKey = selection,
           let model = activityModels.first(where: { $0.label == selectedKey }) {
            return model.color
        } else if showOptions {
            return Color.white
        } else {
            return Color(red: 77/255, green: 77/255, blue: 136/255)
        }
    }

    @ViewBuilder
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.0) { key, value in
                HStack(spacing: 10) {
                    Image(value)
                        .resizable()
                        .frame(width: 48, height: 48)

                    Text(key)
                        .PopBold(size: 16)
                        .lineLimit(1)

                    Spacer(minLength: 0)
                }
                .foregroundStyle(selection == key ? Color.primary : Color.gray)
                .frame(height: 70)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selection = key
                        image = value
                        showOptions = false
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .background(Color(red: 46/255, green: 46/255, blue: 108/255))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}




struct CalendarDayOfWeekCell: View {
    let text: String
    var geometry: GeometryProxy
    var body: some View {
        Text(text)
            .Pop(size: 12, color: Color(red: 153/255, green: 153/255, blue: 186/255))
            .frame(height: geometry.size.width * 0.0945)
    }
}

struct FulledModelTask: View {
    let task: TaskModel?
    let time: String
    
    var body: some View {
        if let task = task {
            ZStack {
                HStack(spacing: -5) {
                    Rectangle()
                        .fill(getColor(for: task.typeActivity))
                        .frame(width: 5)
                        .zIndex(3)
                    
                    Rectangle()
                        .fill(getColor(for: task.typeActivity))
                        .brightness(-0.1)
                        .frame(height: 51.6)
                        .cornerRadius(8)
                        .padding(.trailing)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(getActivityName(for: task.typeActivity))
                            .PopBold(size: 16)
                        
                        Text(time)
                            .Pop(size: 14, color: Color(red: 153/255, green: 153/255, blue: 195/255))
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
            }
        } else {
            Rectangle()
                .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                .frame(height: 51.6)
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
    
    private func getColor(for type: TypeActivity) -> Color {
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



struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                .frame(height: 50)
                .cornerRadius(12)
                .padding(.horizontal, 15)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 17/255, green: 95/255, blue: 147/255))
                        .padding(.horizontal, 15)
                }
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .keyboardType(.numberPad)
                       .onChange(of: text) { newValue in
                           text = newValue.filter { $0.isNumber }
                       }
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Poppins-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -20) {
                Image(.phone)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 30)
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Pop(size: 16, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 26/255, green: 26/255, blue: 101/255))
                .frame(height: 50)
                .cornerRadius(12)
                .padding(.horizontal, 15)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 17/255, green: 95/255, blue: 147/255))
                        .padding(.horizontal, 15)
                }
            
            SecureField("", text: $text)
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Poppins-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -20) {
                Image(.password)
                    .resizable()
                    .frame(width: 14, height: 16)
                    .padding(.leading, 30)
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Pop(size: 16, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
        }
    }
}
