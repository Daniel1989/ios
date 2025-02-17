import UIKit

protocol PlayResultViewDelegate: AnyObject {
    func didTapNewGameButton()
}

class PlayResultView: UIView {
    weak var delegate: PlayResultViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.text = "Game Results"
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        return stack
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let correctWordsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Game", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        [titleLabel, statsStackView, newGameButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        [timeLabel, correctWordsLabel].forEach { label in
            statsStackView.addArrangedSubview(label)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            statsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            statsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            newGameButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            newGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            newGameButton.widthAnchor.constraint(equalToConstant: 200),
            newGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        newGameButton.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
    }
    
    func updateStats(timeSpent: TimeInterval, correctWords: Int) {
        let minutes = Int(timeSpent) / 60
        let seconds = Int(timeSpent) % 60
        timeLabel.text = "Time: \(minutes)m \(seconds)s"
        correctWordsLabel.text = "Correct Words: \(correctWords)"
    }
    
    @objc private func newGameTapped() {
        delegate?.didTapNewGameButton()
    }
} 