import XVCoordinationRequest
import XVEntities

@testable import KPAnalyticsMocks
@testable import XVXXX

class MockCoordinatorType: CoordinationRequestInterface {
  var coordinationFromRequestCallsCount = 0
  var coordinationFromRequestCalled: Bool {
    return coordinationFromRequestCallsCount > 0
  }
  var coordinationFromRequestReceivedArguments: (from: CoordinatedFeature, request: CoordinationRequest)?
  var coordinationFromRequestReceivedInvocations: [(from: CoordinatedFeature, request: CoordinationRequest)] = []
  var coordinationFromRequestClosure: ((CoordinatedFeature, CoordinationRequest) -> Void)?
  func coordination(from: CoordinatedFeature, request: CoordinationRequest) {
    coordinationFromRequestCallsCount += 1
    coordinationFromRequestReceivedArguments = (from: from, request: request)
    coordinationFromRequestReceivedInvocations.append((from: from, request: request))
    coordinationFromRequestClosure?(from, request)
  }
}
