import SwiftUI
import UIFramework
import XVAsset

// MARK: - Container View

struct XVXXXView: View {

  @ObservedObject var viewModel: XVXXXViewModel

  init(viewModel: XVXXXViewModel) {

    self.viewModel = viewModel
  }

  var body: some View {
    XVXXXViewInternal(
      strutcture: viewModel.structure,
      selectionAction: request(action:)
    )
    .onAppear { request(action: .onAppear) }
  }

  @MainActor
  func request(action: XVXXXViewModel.Action) {

    // DevNote: With this method we more the async work to the view so allowing the `onSelection`
    // module to be `async` and freely.
    // As a side effect, the ViewModel can be tested more easily. In other words we prevent the
    // view model to be packed with `Task` sections.
    Task {
      await viewModel.onAction(action)
    }
  }
}

// MARK: - Internal View

struct XVXXXViewInternal: View {
  let strutcture: XVXXXViewStructure
  let selectionAction: (XVXXXViewModel.Action) -> Void

  var body: some View {

    // Creating a list (to benefit of the scrolling in small devices).
    ScrollView {
      VStack {
        
        sectionTitle("Sample View:")
        
        Button {
          selectionAction(.onSampleButtonTap)
        } label: {
          Text(strutcture.buttonTitle)
        }
        
        Text(strutcture.labelText)

        Spacer()
      }  // VStack
      .padding()
      .background(Color.kp_background)
    }  // zstack
    .background(Color.kp_background)
  }  // body

  /// Generates the view for a list section.
  /// - Parameter title: Title of the section
  /// - Returns: Configured view to use in a section of a list.
  private func sectionTitle(_ title: String) -> some View {
    VStack {
      HStack {
        Text(title)
          .kp_headlineFont()
          .foregroundStyle(Color.kp_onSurface)
          .background(Color.kp_background)

        Spacer()
      }
    }
    .padding(.bottom, 20)
    .padding(.top, 40)
  }
}
