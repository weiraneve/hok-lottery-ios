import Foundation


protocol LotteryService {
    func fetchData(by keyword: String) -> String
}

final class LotteryServiceImpl: LotteryService {
    private let decoder: JSONDecoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData(by keyword: String) -> String {
        return keyword + " over"
    }
    
}
