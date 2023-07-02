import Foundation
import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("An error occurred:")
                .font(.headline)
            Text(error.localizedDescription)
                .foregroundColor(.red)
            
            Button(action: retryAction) {
                Text("Retry")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}
