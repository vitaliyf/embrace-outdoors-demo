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
                    appId: "Xa2Ch",
                    platform: .default,
                    endpoints: Embrace.Endpoints(
                      baseURL: "https://a-84eN2.config.emb-api.com",
                      developmentBaseURL: "https://a-84eN2.data.eu1.emb-api.com",
                      configBaseURL: "https://a-84eN2.data.eu1.emb-api.com"
                    )
                )
            )
            .start()
            
        } catch let e {
            print("Couldn't initialize Embrace SDK: \(e.localizedDescription)")
        }
    }
}
