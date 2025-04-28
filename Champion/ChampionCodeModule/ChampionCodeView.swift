import SwiftUI
import QRCode

struct ChampionCodeView: View {
    @StateObject var championCodeModel =  ChampionCodeViewModel()
    @State var url = "https://example.com"
    @State private var isShareSheetShowing = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0/255, green: 0/255, blue: 84/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Your Digital Key")
                                    .PopBold(size: 28)
                                    .padding(.leading)
                            }
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        Text("Scan this QR code to access club facilities")
                            .Pop(size: 14, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                        
                        Spacer(minLength: 30)
                        
                        Rectangle()
                            .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 38/255, green: 37/255, blue: 109/255), lineWidth: 1)
                                    .overlay {
                                        VStack(spacing: 20) {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 10) {
                                                    Text("Artem")
                                                        .PopBold(size: 18)
                                                    
                                                    Text("Member #8742")
                                                        .Pop(size: 12, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                                }
                                                .padding(.leading)
                                                
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Text("Valid until: April 30, 2025")
                                                    .Pop(size: 12, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                                
                                                Spacer()
                                                
                                                Text("Last updated: Today")
                                                    .Pop(size: 12, color: Color(red: 153/255, green: 153/255, blue: 186/255))
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                            }
                            .frame(height: 122)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                        
                        Rectangle()
                            .fill(.white)
                            .frame(height: 272)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                            .overlay {
                                if let qrImage = generateQRCodeImage(url: url) {
                                    VStack {
                                        HStack {
                                            Image(.qr1)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 42, height: 42)
                                                .offset(x: 10, y: -10)
                                                .padding(.leading)
                                            
                                            Spacer()
                                            
                                            Image(.qr2)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 42, height: 42)
                                                .offset(x: -10, y: -10)
                                                .padding(.trailing)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    VStack(spacing: 10) {
                                        Image(decorative: qrImage, scale: 1.0)
                                            .resizable()
                                            .frame(width: 223, height: 220)
                                        
                                        
                                        Text("ELITE CLUB ACCESS")
                                            .PopBold(size: 14, color: Color(red: 7/255, green: 9/255, blue: 84/255))
                                    }
                                } else {
                                    Text("I cant make it")
                                        .foregroundColor(.white)
                                }
                            }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Circle()
                                .fill(Color(red: 8/255, green: 109/255, blue: 110/255))
                                .frame(width: 8, height: 8)
                            
                            Text("Active and ready to use")
                                .Pop(size: 14)
                        }
                        
                        Spacer(minLength: 30)
                        
                        HStack(spacing: -10) {
                            Button(action: {
                                url = UUID().uuidString
                            }) {
                                Rectangle()
                                    .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 38/255, green: 37/255, blue: 109/255), lineWidth: 2)
                                            .overlay {
                                                VStack(spacing: 5) {
                                                    Image(.refresh)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 18, height: 18)
                                                    
                                                    Text("Refresh Key")
                                                        .Pop(size: 14)
                                                }
                                            }
                                    }
                                    .frame(height: 68)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                            }
                            
                            Button(action: {
                                isShareSheetShowing = true
                            }) {
                                Rectangle()
                                    .fill(Color(red: 13/255, green: 13/255, blue: 93/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 38/255, green: 37/255, blue: 109/255), lineWidth: 2)
                                            .overlay {
                                                VStack(spacing: 5) {
                                                    Image(.share)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 15, height: 18)
                                                    
                                                    Text("Share Access")
                                                        .Pop(size: 14)
                                                }
                                            }
                                    }
                                    .frame(height: 68)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                            }
                        }
                        
                        Color(.clear)
                            .frame(height: 80)
                    }
                }
            }
            .sheet(isPresented: $isShareSheetShowing) {
                //MARK: - url
                ShareSheet(items: [""])
            }
        }
    }
    
    func generateQRCodeImage(url: String) -> CGImage? {
        do {
            let qrCode = try QRCode.Document(utf8String: url)
            return try qrCode.cgImage(dimension: 300)
        } catch {
            print("Ошибка создания QR-кода: \(error.localizedDescription)")
            return nil
        }
    }
}

#Preview {
    ChampionCodeView()
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
