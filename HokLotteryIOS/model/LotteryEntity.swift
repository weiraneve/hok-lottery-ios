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
