import SwiftUI

extension Text {
    func Pop(size: CGFloat,
             color: Color = .white ) -> some View {
        self.font(.custom("Poppins-Regular", size: size))
            .foregroundColor(color)
    }
    
    func PopBold(size: CGFloat,
                 color: Color = .white) -> some View {
        self.font(.custom("Poppins-Bold", size: size))
            .foregroundColor(color)
    }
}
