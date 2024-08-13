//
//  ContentView.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import SwiftUI

struct MainView: View {
    @State private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationSplitView {
            List {
                
                // Sampling of Embrace actions
                Section {
                    Picker(viewModel.pickerText,
                           selection: $viewModel.selectedState) {
                        ForEach(
                            viewModel.pickerValues,
                            id:\.self
                        ) { Text($0) }
                    }
                    
                    Button {
                        viewModel.makeWorkingNetworkCall()
                    } label: { Text(viewModel.parkRequestLabelText) }
                    
                    Button {
                        viewModel.makeMockEndpointCall()
                    } label: { Text(viewModel.nsfRequestLabelText) }
                    
                    Button {
                        viewModel.makeForbiddenCall()
                    } label: { Text(viewModel.unauthorizedRequestLabelText) }
                    
                    Button {
                        viewModel.makeTimeoutCall()
                    } label: { Text(viewModel.timeoutRequestLabelText) }
                    
                    Button {
                        viewModel.forceEmbraceCrash()
                    } label: { Text(viewModel.crashLabelText) }
                    
                    Text(viewModel.versionAndBuildInfo)
                    
                } header: {
                    Text(viewModel.networkingSectionHeaderText)
                }
                
            }
            .navigationTitle(Text(viewModel.titleText))
        } detail: {}
    }
}

#Preview {
    MainView()
}
