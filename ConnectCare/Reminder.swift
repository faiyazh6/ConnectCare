//
//  Reminder.swift
//  ConnectCare
//
//  Created by Lincoln Takudzwa Nyarambi on 12/3/24.
//

import Foundation

struct Reminder: Identifiable, Codable {
    var id = UUID()
    var title: String
    var time: Date
    var role: String // Add this property
}
