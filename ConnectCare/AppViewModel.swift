//
//  AppViewModel.swift
//  ConnectCare
//
//  Created by Lincoln Takudzwa Nyarambi on 12/3/24.
//

import SwiftUI
import CoreLocation

class AppViewModel: ObservableObject {
    @AppStorage("userRole") var userRole: String = ""
}
