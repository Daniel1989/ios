import UIKit

class GameToolbarView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private let buttons: [UIButton] = [
        createToolbarButton(image: "lightbulb", title: "Hint"),
        createToolbarButton(image: "checkmark", title: "Check"),
        createToolbarButton(image: "pencil", title: "Notes"),
        createToolbarButton(image: "arrow.clockwise", title: "Reset"),
        createToolbarButton(image: "pause", title: "Pause")
    ]
    
    private static func createToolbarButton(image: String, title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: image), for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 24, left: -20, bottom: 0, right: 0)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttons.forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
} 