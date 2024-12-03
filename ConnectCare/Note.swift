//
//  Note.swift
//  ConnectCare
//
//  Created by Lincoln Takudzwa Nyarambi on 12/3/24.
//

import Foundation

struct Note: Identifiable, Codable {
    let id = UUID()
    var content: String
    var createdDate: Date
}
