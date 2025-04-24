import Foundation

class URLProtocolMock: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    static var statusCode: Int = 200
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Simula un error si está definido
        if let error = URLProtocolMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
            return
        }
        // Crear respuesta http incluyo si no hay data
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: URLProtocolMock.statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        // Enviar data si existe
        
        if let data = URLProtocolMock.stubResponseData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
        
        
        
    }
    
    override func stopLoading() {
        //
    }
}
