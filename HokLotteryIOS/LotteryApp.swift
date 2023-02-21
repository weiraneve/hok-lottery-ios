import SwiftUI

@main
struct LotteryApp: App {
    let lotteryService: LotteryService = LotteryServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            LotteryView(lotteryService: lotteryService)
        }
    }
}
