import SwiftUI

struct LotteryView: View {
    @StateObject private var lotteryViewModel: LotteryViewModel
    
    init(lotteryService: LotteryService) {
        _lotteryViewModel = StateObject(wrappedValue: LotteryViewModel(lotteryService: lotteryService))
    }
    
    var body: some View {
//        ZStack {
//            Image(uiImage: UIImage(named: "all_hero")!)
//                .resizable()
//                .scaledToFit()
//            VStack {
//                TextField("Keyword", text: $lotteryViewModel.keyword)
//                Text(lotteryViewModel.content)
//            }
//        }
        List {
            TextField("Keyword", text: $lotteryViewModel.keyword)
                            Text(lotteryViewModel.content)
        }
    }
}

struct LotteryView_Previews: PreviewProvider {
    
    final class FakeLotteryService: LotteryService {
        func fetchData(by keyword: String, success: @escaping (String) -> Void) {}
    }
    
    static var previews: some View {
        let lotteryService = FakeLotteryService()
        LotteryView(lotteryService: lotteryService)
    }
}
