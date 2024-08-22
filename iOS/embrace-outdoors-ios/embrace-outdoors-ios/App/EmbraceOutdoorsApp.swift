//
//  embrace_outdoors_iosApp.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import SwiftUI
import EmbraceIO

@main
struct EmbraceOutdoorsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    init() {
        do {
            try Embrace.setup(
                options: Embrace.Options(
                    appId: "84eN2",
                    platform: .default,
                    export: nil
                )
            )
            .start()
            
        } catch let e {
            print("Couldn't initialize Embrace SDK: \(e.localizedDescription)")
        }
    }
}
