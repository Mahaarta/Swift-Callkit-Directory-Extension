//
//  CallManager.swift
//  bena phonecall
//
//  Created by Minata on 24/10/2024.
//

import Foundation
import CallKit

final class CallManager: NSObject {
    //MARK: Static properties
    static let shared = CallManager()
    
    //MARK: Private properties
    private var provider: CXProvider
    
    private override init() {
        let configuration = CXProviderConfiguration()
        configuration.ringtoneSound = "audio.mp3"
        configuration.supportsVideo = true
        configuration.includesCallsInRecents = true
        self.provider = CXProvider(configuration: configuration)
        super.init()
        self.provider.setDelegate(self, queue: nil)
    }
    
    func processForIncomingCall(sender: String, uuid: UUID) {
        let handler = CXHandle(type: .generic, value: sender)
        let callupdate = CXCallUpdate()
        callupdate.remoteHandle = handler
        self.provider.reportNewIncomingCall(with: uuid, update: callupdate) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}

extension CallManager: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) { }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fail()
    }
}
