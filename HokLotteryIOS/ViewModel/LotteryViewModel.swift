import Foundation
import Combine

extension LotteryView {
    @MainActor final class LotteryViewModel: ObservableObject {
        @Published var keyword: String = ""
        @Published var content: String = ""
        
        private let lotteryService: LotteryService
        private var cancellableSet: Set<AnyCancellable> = []
        
        init(lotteryService: LotteryService) {
            self.lotteryService = lotteryService
            observeData()
        }
        
        private func observeData() {
            let success = {(content: String) -> Void in
                self.content = content
            }
            
            $keyword
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .sink { keyword in
                    if keyword.isEmpty {
                        self.content = "void"
                    } else {
                        self.lotteryService.fetchData(by: keyword, success: success)
                    }
                }
                .store(in: &self.cancellableSet)
            
        }
    }
}
