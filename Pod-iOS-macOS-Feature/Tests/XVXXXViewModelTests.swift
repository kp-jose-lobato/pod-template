import SwiftUI
import XCTest
import XVCoordinationRequest
import XVEntities
import Combine

@testable import KPAnalyticsMocks
@testable import XVXXX

class XVXXXViewModelTests: XCTestCase {

  class Fixture {
    var analyticsMock = MockKPAnalyticsType()
    var coordinatorMock = MockCoordinatorType()
    var servicesMock = XVXXXFeatureServicesInterfaceMock()
  }

  var fixture: Fixture!
  var subject: XVXXXViewModel!

  override func setUp() {
    fixture = Fixture()
    subject = XVXXXViewModel(
      services: fixture.servicesMock,
      coordinator: fixture.coordinatorMock,
      analyticsReporter: fixture.analyticsMock
    )
  }
  
  // WARNING: Readability issue:
  //    These test are observing a @Publisher to get the result of the test (`structure`).
  //    The publisher has to be updated on Mainthread but the test can run on the background.
  //    So, we are using expectation with combine to do the test. Just notice that the
  //    GIVEN/WHEN/THEN are inverted, so they read GIVEN/THEN/WHEN.

  func testTextIntialValue() async {

    // GIVEN a valid user
    fixture.servicesMock.authenticationStateReturnValue = XVAuthenticationStateEntity(state: .activated)

    let expectation = XCTestExpectation(description: "Structure initial value")
    var cancellable: AnyCancellable?

    cancellable = subject.$structure
      .dropFirst()  // Dropping firt to avoid an event on subscription.
      .sink { newStructure in

        // THEN the label has the initialvalue
        XCTAssert(newStructure.labelText == "I do not know yet...")

        expectation.fulfill()
      }

    // WHEN The view is displayed
    await subject.onAppear()

    // Wait and clean up test.
    await fulfillment(of: [expectation], timeout: 2.0)
    cancellable?.cancel()
  }
  
  func testUpdateTextOnTab() async {

    // GIVEN a valid user
    fixture.servicesMock.authenticationStateReturnValue = XVAuthenticationStateEntity(state: .activated)

    let expectation = XCTestExpectation(description: "Structure initial value")
    var cancellable: AnyCancellable?

    cancellable = subject.$structure
      .dropFirst()  // Dropping firt to avoid an event on subscription.
      .sink { newStructure in

        // THEN the label has the initialvalue
        XCTAssert(newStructure.labelText == "This: activated")

        expectation.fulfill()
      }

    // WHEN The view is displayed
    await subject.onAction(.onSampleButtonTap)

    // Wait and clean up test.
    await fulfillment(of: [expectation], timeout: 2.0)
    cancellable?.cancel()
  }
}
