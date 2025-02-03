//
//  WebService.swift
//  AstroDay
//
//  Created by Edwy Lugo on 31/01/25.
//

import Foundation
import Alamofire

protocol WsDelegate: AnyObject {
    func wsFinishedWithSuccess(sender: NSDictionary, status: WsStatus)
    func wsFinishedWithError(sender: NSDictionary, error: String, status: WsStatus, code: Int)
}

class WebService: NSObject, URLSessionDelegate {
    weak var delegate: WsDelegate?
    var identifier: String = ""
    private let timeout: TimeInterval = kWsTimeOut
    private var params = [String]()
    private var values = [String]()
    private var data = [String]()
    private var dataValue = [NSData]()
    private var dataFormat = [String]()
    private var header = [String]()
    private var headerValue = [String]()
    var lastMethod = ""
    var lastUrl = ""
    private var status = -1
    private var json: NSDictionary?
    var restoreCacheIfNeeded = true
    
    override init() {
        super.init()
    }
    
    // MARK: - Request
    private func request(httpMethod: String, url: String) {
        lastMethod = httpMethod
        lastUrl = url
        
        let requestURLString = "\(kWsBaseUrl)?api_key=\(kWsApiKey)\(url)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let requestURL = URL(string: requestURLString) else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod
        request.timeoutInterval = timeout
        
        debugPrint("#######################################################")
        debugPrint("☎️ - REQUEST:")
        debugPrint("🚀 METHOD: \(httpMethod)")
        debugPrint("🌐 URL: \(kWsBaseUrl)?api_key=\(kWsApiKey)\(url)")
        
        if self.header.count > 0 {
            debugPrint("🎯 HEADERS: ")
            for headerIndex in 0 ..< self.header.count {
                print("\(self.header[headerIndex]) : \(self.headerValue[headerIndex])")
                request.addValue(self.headerValue[headerIndex], forHTTPHeaderField: self.header[headerIndex])
            }
        }
        
        debugPrint("📝 - RESPONSE:")
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            URLCache.shared.removeAllCachedResponses()
            self.handleResponse(data: data, response: response, error: error)
        }
        task.resume()
    }
    
    // MARK: - Response Handling
    func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let httpResponse = response as? HTTPURLResponse {
            status = httpResponse.statusCode
        }
        
        DispatchQueue.main.async {
            if let error = error {
                self.handleError(error: error, response: response)
                return
            }
            
            guard let data = data else {
                self.delegate?.wsFinishedWithError(sender: NSDictionary(), error: "No data received", status: .noData, code: -1)
                return
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                    if let theJSONData = try? JSONSerialization.data(
                        withJSONObject: jsonResult,
                        options: .prettyPrinted) {
                        if let jsonText = String(data: theJSONData,
                                                 encoding: .ascii) {
                            DispatchQueue.main.async {
                                print(jsonText)
                            }
                        } else {
                            DispatchQueue.main.async {
                                print(jsonResult)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            print(jsonResult)
                        }
                    }
                    self.handleSuccess(jsonResult: jsonResult)
                } else if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSMutableArray {
                    let dict = NSMutableDictionary()
                    dict.setValue(jsonArray, forKey: "result")
                    DispatchQueue.main.async {
                        if let jsonString = try? JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted) {
                            if let theJSONText = String(data: jsonString, encoding: .ascii) {
                                print(theJSONText)
                            }
                        }
                        if let dictJsonString = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                            if let dictJsonText = String(data: dictJsonString, encoding: .utf8) {
                                print(dictJsonText)
                            }
                        }
                        self.handleSuccess(jsonResult: dict)
                    }
                }
            } catch {
                self.handleError(error: error, response: response)
            }
        }
    }
    
    func handleSuccess(jsonResult: NSDictionary) {
        if getStatus() != .success {
            debugPrint("❌ - Finished With Error")
            if let apiErrorResponse = parseAPIError(from: jsonResult) {
                debugPrint("Código: \(apiErrorResponse.error.code), Mensagem: \(apiErrorResponse.error.message)")
                delegate?.wsFinishedWithError(sender: jsonResult, error: "\(apiErrorResponse.error.message)", status: .badRequest, code: Int(apiErrorResponse.error.code) ?? -1)
            } else {
                delegate?.wsFinishedWithError(sender: jsonResult, error: "😭 Tente novamente mais tarde", status: .badRequest, code: 400)
            }
        } else {
            debugPrint("✅  - Finished With Success")
            delegate?.wsFinishedWithSuccess(sender: jsonResult, status: getStatus())
        }
    }
    
    func handleError(error: Error, response: URLResponse?) {
        let statusCode = getStatus()
        let errorMessage = (error as NSError).code == NSURLErrorNotConnectedToInternet ? "No internet connection" : error.localizedDescription
        debugPrint("❌ - Finished With Error")
        delegate?.wsFinishedWithError(sender: NSDictionary(), error: errorMessage, status: statusCode, code: getCode(statusCode))
    }
    
    // MARK: - Request Methods
    func get(url: String) { start(httpMethod: "GET", url: url) }
    func post(url: String) { start(httpMethod: "POST", url: url) }
    func put(url: String) { start(httpMethod: "PUT", url: url) }
    func delete(url: String) { start(httpMethod: "DELETE", url: url) }
    func patch(url: String) { start(httpMethod: "PATCH", url: url) }
    
    private func start(httpMethod: String, url: String) {
        if Connectivity.isConnectedToInternet() {
            request(httpMethod: httpMethod, url: url)
        } else {
            delegate?.wsFinishedWithError(sender: NSDictionary(), error: "No internet connection", status: .noInternet, code: -1)
        }
    }
    
    // MARK: - Error when status != success
    func parseAPIError(from jsonResult: NSDictionary) -> APIErrorResponse? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonResult, options: [])
            let decoder = JSONDecoder()
            return try decoder.decode(APIErrorResponse.self, from: data)
        } catch {
            debugPrint("Erro ao decodificar JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Status Helpers
    private func getStatus() -> WsStatus {
        let statusMap: [Int: WsStatus] = [
            200: .success,
            201: .created,
            202: .accepted,
            204: .noContent,
            304: .notModified,
            400: .badRequest,
            401: .unauthorized,
            403: .forbidden,
            404: .notFound,
            405: .methodNotAllowed,
            408: .requestTimeOut,
            409: .conflict,
            429: .tooManyRequests,
            500: .internalServerError,
            550: .noData
        ]
        return statusMap[self.status] ?? .undefined
    }
    
    private func getCode(_ status: WsStatus) -> Int {
        let codeMap: [WsStatus: Int] = [
            .success: 200,
            .created: 201,
            .accepted: 202,
            .noContent: 204,
            .notModified: 304,
            .badRequest: 400,
            .unauthorized: 401,
            .forbidden: 403,
            .notFound: 404,
            .methodNotAllowed: 405,
            .requestTimeOut: 408,
            .conflict: 409,
            .tooManyRequests: 429,
            .internalServerError: 500,
            .noData: 550,
            .noInternet: -1,
            .undefined: 99
        ]
        return codeMap[status] ?? 99
    }
}

extension WebService {
    func addParam(name: String, value: String) {
        params.append(name)
        values.append(value)
    }
    func addData(name: String, data: NSData, format: String) {
        self.data.append(name)
        dataValue.append(data)
        dataFormat.append(format)
    }
    func addHeader(name: String, value: String) {
        self.header.append(name)
        self.headerValue.append(value)
    }
}
