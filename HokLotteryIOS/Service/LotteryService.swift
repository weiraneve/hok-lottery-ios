import Foundation

struct LotteryEntity: Decodable {
    let data: String
    let teamId: String
    let time: Date
    let logs: [LogResponse]
}

struct LogResponse: Decodable {
    let teamId: Int
    let pickGroup: String
    let time: Date
}

protocol LotteryService {
    func fetchData(by keyword: String) -> String
}

final class LotteryServiceImpl: LotteryService {
    
    func fetchData(by keyword: String) -> String {
        lazy var result: LotteryEntity = LotteryEntity(data: "", teamId: "", time: Date(), logs: [])
        let session = URLSession.shared
        let url = "http://steveay.com:8034"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var params = ["encryptCode" : "asd"]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do {
//                        let data = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        result = try JSONDecoder().decode(LotteryEntity.self, from: data)
                        print ("data = \(result)")
                    } catch _ {
                        print ("OOps not good JSON formatted response")
                    }
                }
            })
            task.resume()
        } catch _ {
            print ("Oops something happened buddy")
        }
        return result.data
    }
    
}
