import KPAnalyticsInterface
import XVEntities
import SwiftUI
import XVCoordinationRequest

// The `ViewStructure` publisher is a data representation of the view.
// It is used by the view model to telecontrol the view.
// TODO: Declare you own view structure
struct XVXXXViewStructure {
  var buttonTitle: String
  var labelText: String
  
  // Default values or initial values of the structure
  static var `default`: XVXXXViewStructure {
    XVXXXViewStructure(buttonTitle: "What is the activation state?",
                       labelText: "I do not know yet...")
  }
}

class XVXXXViewModel: ObservableObject {

  private let coordinator: CoordinationRequestInterface
  private let analytics: AnalyticsEventReporter
  private let services: XVXXXFeatureServicesInterface

  // We communicate with the view modifying this publisher.
  // The main actor annotation is to help us remember to update them  with:
  // ```
  // await MainActor.run { [result] in
  //    structure = result
  // }
  // ```
  @MainActor @Published var structure: XVXXXViewStructure = XVXXXViewStructure.default
  // Internal copy of the structure.
  private var internalStructure: XVXXXViewStructure = XVXXXViewStructure.default

  init(
    services: XVXXXFeatureServicesInterface,
    coordinator: CoordinationRequestInterface,
    analyticsReporter: AnalyticsEventReporter
  ) {

    self.services = services
    self.coordinator = coordinator
    self.analytics = analyticsReporter
  }

  // MARK: - Update the View.

  private func renderStructure() async {

    // Request the rendering
    await MainActor.run { [internalStructure] in
      structure = internalStructure
    }
  }

  // MARK: - Handling View Actions

  // The `Action` type enumerate the actions that this view model can receive from
  // the associated view.
  // TODO: Declare you own view Actions
  enum Action {

    // On use when sampleButton receives a single tap.
    case onSampleButtonTap

    // On use when the view appears on screen.
    case onAppear
  }

  /// Dispatching the actions from the view
  /// - Parameter action: received action.
  func onAction(_ action: Action) async {
    switch action {

    case .onSampleButtonTap: await onSampleButtonTap()
    case .onAppear: await onAppear()
    }
  }

  func onSampleButtonTap() async {

    let activationState = await services.authenticationState()
    internalStructure.labelText = "This: \(activationState.state)"
    await renderStructure()
  }

  func onAppear() async {

    await renderStructure()
  }
}
