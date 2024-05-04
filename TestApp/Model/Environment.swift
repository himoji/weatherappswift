//
//  Environment.swift
//  TestApp
//
//  Created by Lyaka on 03.05.2024.
//

import Foundation

public enum Environment{
    enum Keys{
        static let apiKey = "API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("failed to get plist file")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API KEY isn't in plist file")
        }
        return apiKeyString
    }()
}
