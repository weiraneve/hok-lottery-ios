import SwiftUI

struct LotteryView: View {
    @StateObject private var lotteryViewModel: LotteryViewModel
    
    init(lotteryService: LotteryService) {
        _lotteryViewModel = StateObject(wrappedValue: LotteryViewModel(lotteryService: lotteryService))
    }
    
    var body: some View {
        VStack {
            TextField("Keyword", text: $lotteryViewModel.keyword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            Text(lotteryViewModel.content)
                .padding()
        }.padding()
    }
}

struct LotteryView_Previews: PreviewProvider {
    
    final class FakeLotteryService: LotteryService {
        func fetchData(by keyword: String, completion: @escaping (Result<String, Error>) -> Void) {}
    }
    
    static var previews: some View {
        let lotteryService = FakeLotteryService()
        LotteryView(lotteryService: lotteryService)
    }
}
