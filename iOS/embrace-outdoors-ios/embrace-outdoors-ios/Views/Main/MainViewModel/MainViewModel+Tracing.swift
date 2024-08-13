//
//  MainViewModel+Tracing.swift
//  embrace-outdoors-ios
//
//  Created by David Rifkin on 8/13/24.
//

import Foundation
import EmbraceIO

extension MainViewModel {
    //MARK: Tracing Actions
    
    func buildNestedSpans() {
        //this trace has a series of nested spans that form a tree-like structure
        
        guard let client = Embrace.client else {return}
        
        let parentStartTime = Date.now
        let traceRootSpan = client
            .buildSpan(
                name: "Live Updates Trace",
                type: .ux
            ).markAsKeySpan()
            .setStartTime(time: parentStartTime)
            .startSpan()
        
        let loadingStartTime = parentStartTime.advanced(by: .mockShortTimeInterval)
        let loadingScreenSpan = client
            .buildSpan(
                name: "Show Loading screen",
                type: .performance
            )
            .setStartTime(time: loadingStartTime)
            .setParent(traceRootSpan)
            .startSpan()
        
        let loadingEndTime = loadingStartTime.advanced(by: .mockMediumTimeInterval)
        loadingScreenSpan.end(time: loadingEndTime)
        
        let openWebSocketStartTime = loadingStartTime.advanced(by: .mockShortTimeInterval)
        let websocketSpan = client
            .buildSpan(
                name: "Open Websocket",
                attributes: ["service-type" : "websocket"]
            )
            .setStartTime(time: openWebSocketStartTime)
            .setParent(traceRootSpan)
            .startSpan()
        
        let receiveStreamingInfoStartTime = openWebSocketStartTime.advanced(by: .mockShortTimeInterval)
        let receivingWebsocketInfoSpan = client
            .buildSpan(name: "Receive Streaming Information")
            .setStartTime(time: receiveStreamingInfoStartTime)
            .setParent(websocketSpan)
            .startSpan()
        
        let updateUIStartTime = receiveStreamingInfoStartTime.advanced(by: .mockShortTimeInterval)
        let updatingUISpan = client
            .buildSpan(
                name: "Update UI",
                type: .ux
            )
            .setStartTime(time: updateUIStartTime)
            .setParent(traceRootSpan)
            .startSpan()
        
        receivingWebsocketInfoSpan.addEvent(
            name: "Received streamed data",
            attributes: ["data-batch" : .int(1)],
            timestamp: receiveStreamingInfoStartTime.advanced(by: .mockShortTimeInterval)
        )
        
        receivingWebsocketInfoSpan.addEvent(
            name: "Received streamed data",
            attributes: ["data-batch" : .int(2)],
            timestamp: receiveStreamingInfoStartTime.advanced(by: .mockShortTimeInterval)
        )
        
        let streamingDataCloseNoticeTime = receiveStreamingInfoStartTime.advanced(by: .mockMediumTimeInterval)
        websocketSpan.addEvent(
            name: "Received close notice",
            timestamp: streamingDataCloseNoticeTime
        )
        
        receivingWebsocketInfoSpan.end(time: streamingDataCloseNoticeTime)
        websocketSpan.end(time: streamingDataCloseNoticeTime)
        
        let updateUIEndTime = streamingDataCloseNoticeTime.advanced(by: .mockShortTimeInterval)
        updatingUISpan.end(time: updateUIEndTime)
        traceRootSpan.end(time: updateUIEndTime)
    }
    
    func buildSpanWithConcurrentNetworkRequest() {
        //this trace has a network request that occurs during its duration
        
        guard let client = Embrace.client else {return}
        
        let parentStartTime = Date.now
        let traceRootSpan = client
            .buildSpan(
                name: "Concurrent Network Request Trace",
                type: .ux
            ).markAsKeySpan()
            .setStartTime(time: parentStartTime)
            .startSpan()
        
        for _ in 1...3 {
            traceRootSpan.addEvent(name: "making async network call")
            self.makeWorkingNetworkCall()
            
            traceRootSpan.addEvent(name: "making old-style network call")
            self.makeQuietCallbackNetworkCall()
            
            sleep(1)
        }
        
        traceRootSpan.end()
        
    }
}
