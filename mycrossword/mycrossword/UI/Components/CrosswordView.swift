import UIKit

class CrosswordView: UIView {
    private let gridView = CrosswordGridView()
    private let cluesView = CluesView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [gridView, cluesView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            gridView.topAnchor.constraint(equalTo: topAnchor),
            gridView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gridView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cluesView.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 24),
            cluesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cluesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cluesView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
} 