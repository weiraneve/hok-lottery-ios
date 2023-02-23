import Foundation

struct LotteryEntity: Decodable {
    let data: String
    let logs: [LogResponse]?
    let teamId: Int?
    let time: String
}

struct LogResponse: Decodable {
    let pickGroup: String
    let teamId: Int
    let time: String
}

protocol LotteryService {
    func fetchData(by keyword: String, success: @escaping (String) -> ())
}

final class LotteryServiceImpl: LotteryService {
    
    func fetchData(by keyword: String, success: @escaping (String) -> Void) {
        var result: String = ""
        let session = URLSession.shared
        let url = "http://steveay.com:8034"
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["encryptCode" : keyword]
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
                        let lotteryEntity: LotteryEntity? = try JSONDecoder().decode(LotteryEntity.self, from: data)
                        let pickData = "\(lotteryEntity!.data) "
                        print("result = \(result)")
                        var team: String = ""
                        if (lotteryEntity?.teamId != nil) {
                            team = "队伍: \(lotteryEntity?.teamId ?? 00) "
                        }
                        let time = "时间: \(lotteryEntity!.time) "
                        result += pickData + team + time
                        success(result)
                    } catch _ {
                        print ("OOps not good JSON formatted response")
                    }
                }
            })
            task.resume()
        } catch _ {
            print ("Oops something happened buddy")
        }
    }
}
