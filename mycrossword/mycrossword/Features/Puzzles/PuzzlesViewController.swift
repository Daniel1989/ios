import UIKit

class PuzzlesViewController: UIViewController {
    // MARK: - UI Components
    private let headerView = HeaderView()
    private let todaysPuzzlesLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Puzzles"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private let puzzleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let crosswordView = CrosswordView()
    private let bottomToolbar = GameToolbarView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        [headerView, todaysPuzzlesLabel, seeAllButton, 
         puzzleCollectionView, crosswordView, bottomToolbar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44),
            
            todaysPuzzlesLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            todaysPuzzlesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            seeAllButton.centerYAnchor.constraint(equalTo: todaysPuzzlesLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            puzzleCollectionView.topAnchor.constraint(equalTo: todaysPuzzlesLabel.bottomAnchor, constant: 16),
            puzzleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            puzzleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            puzzleCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            crosswordView.topAnchor.constraint(equalTo: puzzleCollectionView.bottomAnchor, constant: 24),
            crosswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            crosswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomToolbar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupCollectionView() {
        puzzleCollectionView.delegate = self
        puzzleCollectionView.dataSource = self
        puzzleCollectionView.register(PuzzleCell.self, forCellWithReuseIdentifier: "PuzzleCell")
        puzzleCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        puzzleCollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource
extension PuzzlesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // For now, just showing 2 puzzles
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PuzzleCell", for: indexPath) as! PuzzleCell
        // Configure cell based on indexPath
        if indexPath.item == 0 {
            cell.configure(title: "Morning Coffee", category: "Food & Drinks", difficulty: "Easy", duration: "15 min")
        } else {
            cell.configure(title: "World Capitals", category: "Geography", difficulty: "Medium", duration: "15 min")
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PuzzlesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.7, height: collectionView.bounds.height)
    }
} 