import Foundation
import XVEntities

/// The service interface should provide all data needed by the Module to function (IN), as well as
/// attend to possible requests by the module (OUT).
///
/// Notice that inversion of dependency here. Using this protocol the module declares "what
/// it needs to work" depending only on Entities (sending and receiving entities). It is
/// the host duty (the app) to implement this protocol or connect it to the right
/// source or destination.
public protocol XVXXXFeatureServicesInterface {

  /// Request the current authentication state of the users.
  /// - Returns: The current authentication state of the users
  func authenticationState() async -> XVAuthenticationStateEntity
}
