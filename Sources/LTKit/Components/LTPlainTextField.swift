import SwiftUI
import UIKit

/// Text field that hides the keyboard input assistant bar (predictive text / input switcher)
public struct LTPlainTextField: UIViewRepresentable {
    let placeholder: String
    @Binding var text: String
    var font: UIFont = .systemFont(ofSize: 16, weight: .regular)

    public init(placeholder: String, text: Binding<String>, font: UIFont = .systemFont(ofSize: 16, weight: .regular)) {
        self.placeholder = placeholder
        self._text = text
        self.font = font
    }

    public func makeUIView(context: Context) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = font
        tf.borderStyle = .none
        tf.textColor = .label
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.placeholderText]
        )
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textContentType = .none
        tf.addTarget(context.coordinator, action: #selector(Coordinator.textChanged), for: .editingChanged)
        // Hide the keyboard input assistant bar (predictive text / dropdown)
        tf.inputAssistantItem.leadingBarButtonGroups = []
        tf.inputAssistantItem.trailingBarButtonGroups = []
        return tf
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.placeholder = placeholder
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.placeholderText]
        )
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject {
        var parent: LTPlainTextField

        init(_ parent: LTPlainTextField) {
            self.parent = parent
        }

        @objc func textChanged(_ sender: UITextField) {
            parent.text = sender.text ?? ""
        }
    }
}
