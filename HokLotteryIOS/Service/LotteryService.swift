import Foundation

protocol LotteryService {
    func fetchData(by keyword: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class LotteryServiceImpl: LotteryService {
    
    func fetchData(by keyword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        let url = "http://steveay.com:8034"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["encryptCode": keyword]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            completion(.failure(error))
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: ["reason": "No data received"])))
                return
            }

            do {
                let lotteryEntity = try JSONDecoder().decode(LotteryEntity.self, from: data)
                var result = "{选取内容: \(lotteryEntity.data) "
                if let teamId = lotteryEntity.teamId {
                    result += "队伍: \(teamId) "
                }
                result += "时间: \(lotteryEntity.time)}\n历史记录: "
                lotteryEntity.logs?.forEach { log in
                    result += "{选取内容: \(log.pickGroup) 队伍: \(log.teamId) 时间: \(log.time)}"
                }
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
