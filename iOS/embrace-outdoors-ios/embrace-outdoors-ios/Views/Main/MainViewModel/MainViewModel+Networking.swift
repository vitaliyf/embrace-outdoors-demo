//
//  MainViewModel+Networking.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import Foundation

extension MainViewModel {
    //MARK: Network Actions
    func makeMockEndpointCall() {
        postCallBackNSFMockEndPoint()
//        Task {
//            await postNSFMockEndPoint()
//        }
    }
    
    private func postNSFMockEndPoint() async {
        //This endpoint expects a header for NSF. Must be https
        let url = URL(string: "https://dash-api.embrace.io/mock/trace_forwarding")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let (_, _) = try await URLSession.shared.data(from: url)
        } catch {
            print("error with mock endpoint:\n \(error)")
        }
    }
    
    private func postCallBackNSFMockEndPoint() {
        //This endpoint expects a header for NSF. Must be https
        let url = URL(string: "https://dash-api.embrace.io/mock/trace_forwarding")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { d, r, e in
            guard let data = d else { return }
        }.resume()
    }
    
    func makeWorkingNetworkCall() {
        makeCallbackWorkingNetworkCall()
//        Task {
//            await fetchParkDataForSelectedState()
//        }
    }
    
    func makeCallbackWorkingNetworkCall() {
        //network request to test older, non-async networking
        let stateCode = StatesList.getAbbrevFrom(name: selectedState)
        let url = URL(
            string: "https://developer.nps.gov/api/v1/parks?stateCode=\(stateCode)&api_key=snTswDbB4TUdS3BjIh4TUoaJx56xXI0JKfU3kLZF"
        )!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(ParkRequestResult.self, from: data)
                DispatchQueue.main.async {
                    self.requestResult = decodedData
                    self.requestedState = self.selectedState
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private func fetchParkDataForSelectedState() async {
        let stateCode = StatesList.getAbbrevFrom(name: selectedState)
        let url = URL(
            string: "https://developer.nps.gov/api/v1/parks?stateCode=\(stateCode)&api_key=snTswDbB4TUdS3BjIh4TUoaJx56xXI0JKfU3kLZF"
        )!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(ParkRequestResult.self, from: data)
            requestResult = decodedData
            requestedState = selectedState
        } catch {
            print("error with working call:\n \(error)")
        }
    }
    
    func makeForbiddenCall() {
        makeCallbackForbiddenDataCall()
//        Task {
//            await fetchForbiddenData()
//        }
    }
    
    private func fetchForbiddenData() async {
        // No API Key - 403 error
        let url = URL(string: "https://developer.nps.gov/api/v1/lessonplans")!
        
        do {
            let (_, _) = try await URLSession.shared.data(from: url)
        } catch {
            print("error with forbidden call:\n \(error)")
        }
    }
    
    private func makeCallbackForbiddenDataCall() {
        //network request to test older, non-async networking
        let url = URL(string: "https://developer.nps.gov/api/v1/lessonplans")!
        
        URLSession.shared.dataTask(with: url) { d, r, e in
            guard let data = d else { return }
            print(data)
        }.resume()
    }
    
    func makeTimeoutCall() {
        makeCallbackTimeoutCall()
//        Task {
//            await fetchTimeout()
//        }
    }
    
    private func fetchTimeout() async {
        //Build impossible timeout into URLSession
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 0.01
        sessionConfig.timeoutIntervalForResource = 0.01
        let session = URLSession(configuration: sessionConfig)
        
        let url = URL(
            string: "https://developer.nps.gov/api/v1/lessonplans?api_key=snTswDbB4TUdS3BjIh4TUoaJx56xXI0JKfU3kLZF"
        )!
        
        do {
            let (_, _) = try await session.data(from: url)
        } catch {
            print("error with timeout call:\n \(error)")
        }
    }
    
    private func makeCallbackTimeoutCall() {
        //network request to test older, non-async networking
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 0.01
        sessionConfig.timeoutIntervalForResource = 0.01
        let session = URLSession(configuration: sessionConfig)
        
        let url = URL(
            string: "https://developer.nps.gov/api/v1/lessonplans?api_key=snTswDbB4TUdS3BjIh4TUoaJx56xXI0JKfU3kLZF"
        )!
        session.dataTask(
            with: url,
            completionHandler: { d, r, e in
                guard let data = d else { return }
                print(data)
            }
        ).resume()
    }
}
