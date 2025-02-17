import UIKit

class PuzzleCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGreen
        label.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [containerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        [difficultyLabel, titleLabel, categoryLabel, durationLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            difficultyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            difficultyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            difficultyLabel.widthAnchor.constraint(equalToConstant: 60),
            difficultyLabel.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            categoryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            categoryLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            durationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            durationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(title: String, category: String, difficulty: String, duration: String) {
        titleLabel.text = title
        categoryLabel.text = category
        difficultyLabel.text = difficulty
        durationLabel.text = duration
        
        switch difficulty.lowercased() {
        case "easy":
            difficultyLabel.textColor = .systemGreen
            difficultyLabel.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        case "medium":
            difficultyLabel.textColor = .systemYellow
            difficultyLabel.backgroundColor = .systemYellow.withAlphaComponent(0.1)
        case "hard":
            difficultyLabel.textColor = .systemRed
            difficultyLabel.backgroundColor = .systemRed.withAlphaComponent(0.1)
        default:
            break
        }
    }
} 