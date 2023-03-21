import SwiftUI
import OGAppSkeleton

struct ErrorView: View {
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      titleText()
      descriptionText()
      PrimaryButton
      
    }
  }
  
  @ViewBuilder
  func ImageView() -> some View {
    Text("welcomeScreen.label.title".localized)
      .fixedSize(horizontal: false, vertical: true) // Title gets truncated on small device
      .font(for: .headlineXXL)
      .foregroundColor(Colors.basicBasic0.color)
      .accessibilityIdentifier("welcome_title")
  }
  
  @ViewBuilder
  func titleText() -> some View {
    Text(viewModel.errorTitleText)
      .font(for: .headlineL)
      .foregroundColor(Colors.basicBasic100.color)
  }

  @ViewBuilder
  func descriptionText() -> some View {
    Text(viewModel.errorDescriptionText)
      .font(for: .copyM)
      .multilineTextAlignment(.center)
      .foregroundColor(Colors.basicBasic100.color)
  }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
      ErrorView(viewModel: ErrorView.ViewModel(errorTitleText: "test", errorDescriptionText: "342", errorIconImage: UIImage(systemName: "house")!, errorButtonText: "button", buttonAction: {
        print("pressed")
      }))
    }
}
