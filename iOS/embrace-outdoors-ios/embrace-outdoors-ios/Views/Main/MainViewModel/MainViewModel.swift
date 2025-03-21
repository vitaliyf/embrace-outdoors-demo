//
//  MainViewModel.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import Foundation
import EmbraceIO

@Observable
class MainViewModel {
    //MARK: Data
    var selectedState = "USA"
    var requestedState = ""
    let pickerValues: [String] = ["USA"] + StatesList.allNames
    
    var requestResult: ParkRequestResult? = nil
    
    var parksFromResult: [ParkRequestResult.Park] {
        requestResult?.data ?? []
    }
    
    //MARK: UI Values
    let titleText = "Embrace Outdoors!"
    let tracesSectionHeaderText = "Try these traces!"
    let networkingSectionHeaderText = "Try these actions!"
    let pickerText = "Select a state:"
    let nsfRequestLabelText = "Make a request that uses Network Span Forwarding"
    let unauthorizedRequestLabelText = "Make an unauthorized request"
    let timeoutRequestLabelText = "Make a request that times out"
    let crashLabelText = "Crash!"
    
    let nestedTraceLabelText = "Create a trace with child spans"
    let traceWithRequestLabelText = "Create a trace with concurrent Parks request"
    let mockAuthLabelText = "Create a mock authorization trace"
    let mockSearchLabelText = "Create a mock search trace"
    let mockCheckoutLabelText = "Create a mock checkout trace"
    let mockPermissionsLabelText = "Create a mock app location permissions trace"
    let mockNetworkingMiddlewareLabelText = "Create a mock networking middleware trace"
    
    var resultSectionHeaderText: String {
        parksFromResult.count.description + " parks in " + requestedState
    }
    
    var parkRequestLabelText: String {
        "Find National Parks in " + selectedState
    }
    
    var versionAndBuildInfo: String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "No version info available"
        }
        
        return "Version: \(version) Build: \(build)"
    }
    
    var requestResultsExist: Bool {
        requestResult != nil
    }
    
    //MARK: Log Actions
    func logViewAppeared() {
        Embrace.client?.log("Main View Appeared", severity: .info)
    }
    
    func logRandomAction() {
        let randomAction = [
            "User tapped a button",
            "User swiped left",
            "User swiped right",
            "User tapped a cell"
        ].randomElement() ?? "User did something"
            
        let attributes = ["action": randomAction]
        
        Embrace.client?.log(
            "user action",
            severity: .warn,
            attributes: attributes
        )
    }

    
    func forceEmbraceCrash() {
        // This method will force a crash in the app
        // It will also send the crash event to Embrace
        // with the provided severity and any additional attributes
        let randomExperiment = ["A", "B", "C", "D"].randomElement() ?? "A"
        let attributes = ["experiment": randomExperiment]

        Embrace.client?.log(
            "Forcing a crash",
            severity: .error,
            attributes: attributes
        )

        Embrace.client?.crash()
    }
}
