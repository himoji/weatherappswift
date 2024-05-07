//
//  Environment.swift
//  TestApp
//
//  Created by Lyaka on 03.05.2024.
//

import Foundation


// MARK: - Environment setup
public enum Environment{
    enum Keys{
        static let apiKey = "API_KEY"
    }

    // Trying to get the Info.plist file
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("failed to get plist file")
        }
        return dict
    }()
    
    // Trying to get the api key from the Info.plist

    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API KEY isn't in plist file")
        }
        return apiKeyString
    }()
}
