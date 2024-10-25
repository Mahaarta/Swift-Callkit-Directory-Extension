//
//  ViewController.swift
//  bena phonecall
//
//  Created by Minata on 24/10/2024.
//

import UIKit
import Contacts
import CallKit

class ViewController: UIViewController {
    
    private let callManager = CallManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.reportAnIncomingCall()
        //requestContactsAccess()
        
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "mahaarta.bena-phonecall1.CallDirectoryHandler") { error in
            if let error = error {
                print("Failed to reload extension: \(error.localizedDescription)")
            } else {
                print("Successfully reloaded extension")
            }
        }
    }
    
    private func reportAnIncomingCall() {
        callManager.processForIncomingCall(sender: "Benawo", uuid: UUID())
    }
    
    func requestContactsAccess() {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                print("Access granted")
                self.fetchContacts()
            } else {
                print("Access denied")
            }
        }
    }
    
    private func fetchContacts() {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                print("Name: \(contact.givenName) \(contact.familyName)")
            }
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
    
}

