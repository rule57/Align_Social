//
//  KeychainHelper.swift
//  Align
//
//  Created by William Rule on 6/21/24.
//

import Security
import Foundation

struct KeychainHelper {
    static func save(key: String, data: Data) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query) // Delete any existing item
        let status = SecItemAdd(query, nil)
        return status == errSecSuccess
    }
    
    static func load(key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        return status == errSecSuccess ? dataTypeRef as? Data : nil
    }
    
    static func delete(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
