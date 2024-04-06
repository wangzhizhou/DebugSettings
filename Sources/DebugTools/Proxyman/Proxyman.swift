//
//  Proxyman.swift
//  DebugSettings
//
//  Created by joker on 2024/4/6.
//

import Atlantis

@objc(DSProxyman)
@objcMembers
public final class Proxyman: NSObject {

    public static func start() {
        Atlantis.start()
    }

    public static func stop() {
        Atlantis.stop()
    }

    public static func manualReport(request: URLRequest, response: HTTPURLResponse, responseData: Data?, error: Error?) {
        if responseData == nil, let error = error {
            Atlantis.add(request: request, error: error)
        } else {
            Atlantis.add(request: request, response: response, responseBody: responseData)
        }
    }

    public static func testReport() {
        // Init Request and Response
#if DEBUG
        let header = Header(key: "X-Data", value: "Atlantis")
        let jsonType = Header(key: "Content-Type", value: "application/json")
        let jsonObj: [String: Any] = ["country": "Singapore"]
        let data = try! JSONSerialization.data(withJSONObject: jsonObj, options: [])
        let request = Request(url: "https://proxyman.io/get/data/debug/tool/test", method: "GET", headers: [header, jsonType], body: data)
        let response = Response(statusCode: 200, headers: [Header(key: "X-Response", value: "Internal Error server"), jsonType])
        let responseObj: [String: Any] = ["message": "success"]
        let responseData = try! JSONSerialization.data(withJSONObject: responseObj, options: [])

        // Add to Atlantis and show it on Proxyman app
        Atlantis.add(request: request, response: response, responseBody: responseData)
#endif
    }
}
