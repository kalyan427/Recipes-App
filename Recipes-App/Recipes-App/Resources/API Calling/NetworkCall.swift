

import Foundation

// MARK: - Protocol/Delegate for API Calling.

protocol apiCallingDelegate {
    func receivedData(data Content: Data)
}

class NetworkApiCall: NSObject {
     var delegate: apiCallingDelegate?
    
    func callAPI(urlString: String) {
        let jsonUrl = URL(string: urlString)! as URL
        var request = URLRequest(url: jsonUrl)
        request.httpMethod = "GET"
        request.timeoutInterval = 100
        print(request)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let raw = data else {
                print(String(describing: error))
                return
            }
            self.delegate?.receivedData(data: raw)
        }
        task.resume()
    }
}
