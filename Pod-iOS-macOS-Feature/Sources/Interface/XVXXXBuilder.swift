import KPAnalyticsInterface
import SwiftUI
import XVAsset
import XVCoordinationRequest

/// The Builder provides the tools to build the module returning a View (or UIViewController)
/// to be set directly on Screen.
public struct XVXXXFeatureBuilder {

#if canImport(UIKit)
  /// Build View Controller for the module.
  /// NOTE: The UIViewController is used to allow using the module on the legacy application.
  /// - Parameters:
  ///   - services: Implementation of the services interface needed by the module.
  ///   - coordinator: Coordinator interface for the module to request coordination.
  ///   - analyticsReporter: Analytics reporter interface for the module to report analytics.
  /// - Returns: A UIViewController representing the module.
    public static func buildViewController(
      services: XVXXXFeatureServicesInterface,
      coordinator: CoordinationRequestInterface,
      analyticsReporter: AnalyticsEventReporter
    ) -> some UIViewController {

      let view = XVXXXFeatureBuilder.build(
        services: services,
        coordinator: coordinator,
        analyticsReporter: analyticsReporter
      )
      let viewController = UIHostingController(rootView: view)
      
      // TODO: Set the title of the Navigation bar.
      // viewController.title = BundleUtil.localizedString(key: "...", comment: "...")
      
      return viewController
    }
  #endif

  /// Build SwiftUI View for the module.
  /// - Parameters:
  ///   - services: Implementation of the services interface needed by the module.
  ///   - coordinator: Coordinator interface for the module to request coordination.
  ///   - analyticsReporter: Analytics reporter interface for the module to report analytics.
  /// - Returns: A UIViewController representing the module.
  public static func build(
    services: XVXXXFeatureServicesInterface,
    coordinator: CoordinationRequestInterface,
    analyticsReporter: AnalyticsEventReporter
  ) -> some View {

    let viewModel = XVXXXViewModel(
      services: services,
      coordinator: coordinator,
      analyticsReporter: analyticsReporter
    )
    return XVXXXView(viewModel: viewModel)
  }
}
