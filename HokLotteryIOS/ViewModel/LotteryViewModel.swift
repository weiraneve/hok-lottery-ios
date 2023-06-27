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
            $keyword
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .sink { keyword in
                    if keyword.isEmpty {
                        self.content = "void"
                    } else {
                        self.lotteryService.fetchData(by: keyword) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let content):
                                    self.content = content
                                case .failure(let error):
                                    self.content = "Error: \(error.localizedDescription)"
                                }
                            }
                        }
                    }
                }
                .store(in: &self.cancellableSet)
        }
    }
}
