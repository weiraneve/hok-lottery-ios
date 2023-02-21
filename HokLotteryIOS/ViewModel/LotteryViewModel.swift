import Foundation

extension LotteryView {
    @MainActor final class LotteryViewModel: ObservableObject {
        @Published var keyword: String = ""
        @Published var content: String = ""
        
        private let lotteryService: LotteryService
        
        init(lotteryService: LotteryService) {
            self.lotteryService = lotteryService
            observeData()
        }
        
        private func observeData() {
            print("invoke observeData method")
            if keyword != "" {
                content = lotteryService.fetchData(by: keyword)
            }
        }
    }
}
