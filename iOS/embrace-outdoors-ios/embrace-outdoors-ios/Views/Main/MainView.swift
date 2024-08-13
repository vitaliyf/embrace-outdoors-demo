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
                
                // Sample traces
                Section {
                    Button {
                        viewModel.buildNestedSpans()
                    } label: { Text(viewModel.nestedTraceLabelText) }
                    
                    Button {
                        viewModel.buildSpanWithConcurrentNetworkRequest()
                    } label: { Text(viewModel.traceWithRequestLabelText) }
                    
                    Button {
                        viewModel.buildMockAuthSpans()
                    } label: { Text(viewModel.mockAuthLabelText) }
                    
                    Button {
                        viewModel.buildMockSearchSpans()
                    } label: { Text(viewModel.mockSearchLabelText) }
                    
                    Button {
                        viewModel.buildMockCheckoutSpans()
                    } label: { Text(viewModel.mockCheckoutLabelText) }
                    
                    Button {
                        viewModel.buildMockPermissionsSpans()
                    } label: { Text(viewModel.mockPermissionsLabelText) }
                    
                    Button {
                        viewModel.buildMockMiddlewareNetworkingSpans()
                    } label: { Text(viewModel.mockNetworkingMiddlewareLabelText) }
                    
                } header: {
                    Text(viewModel.tracesSectionHeaderText)
                }
                
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
                
                // List of park items after request
                if viewModel.requestResultsExist {
                    Section {
                        ForEach(viewModel.parksFromResult, id: \.fullName ) { park in
                            NavigationLink {
                                DetailView(park: park)
                            } label: {
                                Text(park.parkName)
                            }
                        }
                    } header: {
                        Text(viewModel.resultSectionHeaderText)
                    }
                }
            }
            .navigationTitle(Text(viewModel.titleText))
        } detail: {}
    }
}

#Preview {
    MainView()
}
