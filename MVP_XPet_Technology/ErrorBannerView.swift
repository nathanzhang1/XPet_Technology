import SwiftUI

// A reusable banner for displaying error messages with a fixed width and left-aligned text.
struct ErrorBannerView: View {
    let message: String
    // Fixed width matching input fields and buttons
    private let bannerWidth: CGFloat = 300

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.white)
            Text(message)
                .foregroundColor(.white)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(width: bannerWidth, alignment: .leading)
        .background(Color.red)
        .cornerRadius(8)
    }
}

struct ErrorBannerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ErrorBannerView(message: "Short error")
            ErrorBannerView(message: "A much longer error message that still fits within the fixed width and left aligns correctly.")
        }
        .previewLayout(.sizeThatFits)
    }
}
