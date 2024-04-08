// MARK: - Mocks generated from file: XVXXX/XVXXX/Sources/Interface/XVXXXBuilder.swift at 2024-04-08 14:56:02 +0000


import Cuckoo
@testable import XVXXX

import KPAnalyticsInterface
import SwiftUI
import XVAsset
import XVCoordinationRequest

// MARK: - Mocks generated from file: XVXXX/XVXXX/Sources/Interface/XVXXXServicesInterface.swift at 2024-04-08 14:56:02 +0000


import Cuckoo
@testable import XVXXX

import Foundation
import XVEntities






public class MockXVXXXFeatureServicesInterface: XVXXXFeatureServicesInterface, Cuckoo.ProtocolMock {
    
    public typealias MocksType = XVXXXFeatureServicesInterface
    
    public typealias Stubbing = __StubbingProxy_XVXXXFeatureServicesInterface
    public typealias Verification = __VerificationProxy_XVXXXFeatureServicesInterface

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: XVXXXFeatureServicesInterface?

    public func enableDefaultImplementation(_ stub: XVXXXFeatureServicesInterface) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func authenticationState() async -> XVAuthenticationStateEntity {
        
    return await cuckoo_manager.call(
    """
    authenticationState() async -> XVAuthenticationStateEntity
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.authenticationState())
        
    }
    
    

    public struct __StubbingProxy_XVXXXFeatureServicesInterface: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func authenticationState() -> Cuckoo.ProtocolStubFunction<(), XVAuthenticationStateEntity> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockXVXXXFeatureServicesInterface.self, method:
    """
    authenticationState() async -> XVAuthenticationStateEntity
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_XVXXXFeatureServicesInterface: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func authenticationState() -> Cuckoo.__DoNotUse<(), XVAuthenticationStateEntity> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    authenticationState() async -> XVAuthenticationStateEntity
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class XVXXXFeatureServicesInterfaceStub: XVXXXFeatureServicesInterface {
    

    

    
    
    
    
    public func authenticationState() async -> XVAuthenticationStateEntity  {
        return DefaultValueRegistry.defaultValue(for: (XVAuthenticationStateEntity).self)
    }
    
    
}





// MARK: - Mocks generated from file: XVXXX/XVXXX/Sources/Internal/XVXXXViewModel.swift at 2024-04-08 14:56:02 +0000


import Cuckoo
@testable import XVXXX

import KPAnalyticsInterface
import SwiftUI
import XVCoordinationRequest
import XVEntities






 class MockXVXXXViewModel: XVXXXViewModel, Cuckoo.ClassMock {
    
     typealias MocksType = XVXXXViewModel
    
     typealias Stubbing = __StubbingProxy_XVXXXViewModel
     typealias Verification = __VerificationProxy_XVXXXViewModel

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: XVXXXViewModel?

     func enableDefaultImplementation(_ stub: XVXXXViewModel) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     override var structure: XVXXXViewStructure {
        get {
            return cuckoo_manager.getter("structure",
                superclassCall:
                    
                                    super.structure
                    ,
                defaultCall:  __defaultImplStub!.structure)
        }
        
        set {
            cuckoo_manager.setter("structure",
                value: newValue,
                superclassCall:
                    
                    super.structure = newValue
                    ,
                defaultCall: __defaultImplStub!.structure = newValue)
        }
        
    }
    
    

    

    
    
    
    
     override func onAction(_ action: Action) async {
        
    return await cuckoo_manager.call(
    """
    onAction(_: Action) async
    """,
            parameters: (action),
            escapingParameters: (action),
            superclassCall:
                
                await super.onAction(action)
                ,
            defaultCall: await __defaultImplStub!.onAction(action))
        
    }
    
    
    
    
    
     override func onSampleButtonTap() async {
        
    return await cuckoo_manager.call(
    """
    onSampleButtonTap() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.onSampleButtonTap()
                ,
            defaultCall: await __defaultImplStub!.onSampleButtonTap())
        
    }
    
    
    
    
    
     override func onAppear() async {
        
    return await cuckoo_manager.call(
    """
    onAppear() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                await super.onAppear()
                ,
            defaultCall: await __defaultImplStub!.onAppear())
        
    }
    
    

     struct __StubbingProxy_XVXXXViewModel: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var structure: Cuckoo.ClassToBeStubbedProperty<MockXVXXXViewModel, XVXXXViewStructure> {
            return .init(manager: cuckoo_manager, name: "structure")
        }
        
        
        
        
        
        func onAction<M1: Cuckoo.Matchable>(_ action: M1) -> Cuckoo.ClassStubNoReturnFunction<(Action)> where M1.MatchedType == Action {
            let matchers: [Cuckoo.ParameterMatcher<(Action)>] = [wrap(matchable: action) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockXVXXXViewModel.self, method:
    """
    onAction(_: Action) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func onSampleButtonTap() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockXVXXXViewModel.self, method:
    """
    onSampleButtonTap() async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func onAppear() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockXVXXXViewModel.self, method:
    """
    onAppear() async
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_XVXXXViewModel: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var structure: Cuckoo.VerifyProperty<XVXXXViewStructure> {
            return .init(manager: cuckoo_manager, name: "structure", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func onAction<M1: Cuckoo.Matchable>(_ action: M1) -> Cuckoo.__DoNotUse<(Action), Void> where M1.MatchedType == Action {
            let matchers: [Cuckoo.ParameterMatcher<(Action)>] = [wrap(matchable: action) { $0 }]
            return cuckoo_manager.verify(
    """
    onAction(_: Action) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func onSampleButtonTap() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    onSampleButtonTap() async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func onAppear() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    onAppear() async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class XVXXXViewModelStub: XVXXXViewModel {
    
    
    
    
     override var structure: XVXXXViewStructure {
        get {
            return DefaultValueRegistry.defaultValue(for: (XVXXXViewStructure).self)
        }
        
        set { }
        
    }
    
    

    

    
    
    
    
     override func onAction(_ action: Action) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func onSampleButtonTap() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func onAppear() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: XVXXX/XVXXX/Sources/View/XVXXXView.swift at 2024-04-08 14:56:02 +0000


import Cuckoo
@testable import XVXXX

import SwiftUI
import UIFramework
import XVAsset
