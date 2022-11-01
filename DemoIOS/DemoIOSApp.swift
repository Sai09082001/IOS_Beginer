//
//  DemoIOSApp.swift
//  DemoIOS
//
//  Created by imobi - macmini on 10/25/22.
//

import SwiftUI

@main
struct DemoIOSApp: App {
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(order)
        }
    }
}
