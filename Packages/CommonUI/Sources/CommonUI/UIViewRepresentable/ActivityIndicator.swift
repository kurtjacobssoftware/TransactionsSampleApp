import SwiftUI
import UIKit

public struct ActivityIndicator: UIViewRepresentable {

    public init(isAnimating: Bool) {
        self.isAnimating = isAnimating
    }

    public typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    private var configuration = { (_: UIView) in }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        uiView.color = .systemBlue
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}
