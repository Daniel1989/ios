import UIKit

protocol ResultViewDelegate: AnyObject {
    func didTapPlayAgainButton()
}

class ResultView: UIView {
    weak var delegate: ResultViewDelegate?
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.text = "Your Score: 0"
        return label
    }()
    
    private let playAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Again", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
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
        
        [scoreLabel, playAgainButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            
            playAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playAgainButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 30),
            playAgainButton.widthAnchor.constraint(equalToConstant: 200),
            playAgainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        playAgainButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
    }
    
    func updateScore(_ score: Int) {
        scoreLabel.text = "Your Score: \(score)"
    }
    
    @objc private func playAgainTapped() {
        delegate?.didTapPlayAgainButton()
    }
} 