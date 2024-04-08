import XVEntities

@testable import XVXXX

class XVXXXFeatureServicesInterfaceMock: XVXXXFeatureServicesInterface {

  var authenticationStateCallCount = 0
  var authenticationStateCalled: Bool {
    return authenticationStateCallCount > 0
  }
  var authenticationStateReturnValue: XVAuthenticationStateEntity!
  func authenticationState() async -> XVAuthenticationStateEntity {
    authenticationStateCallCount += 1
    return authenticationStateReturnValue
  }
}
