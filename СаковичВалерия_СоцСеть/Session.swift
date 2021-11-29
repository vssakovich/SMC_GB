//
//  Session.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 21.11.21.
//

import Foundation

class Session {
    
    private init () {
    }
    
    static let instance = Session()
    
    var token: String = ""
    var userID: Int = 0
}
