import UIKit

/// Flipside matching FlipsideView.nib + original navigation bar with Done button.
class FlipsideViewController: UIViewController {
    var doneHandler: (() -> Void)?

    override func loadView() {
        view = FlipsideView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        let navBar = UINavigationBar()
        navBar.barStyle = .black
        navBar.isTranslucent = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "")
        navItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )
        navBar.setItems([navItem], animated: false)

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func doneTapped() {
        doneHandler?()
    }
}

/// Custom view matching FlipsideView.nib:
/// - Primary: IamRichBack1.png
/// - Secondary semi-transparent: Default.png (alpha ≈ 0.47)
class FlipsideView: UIView {
    private let backImageView = UIImageView()
    private let overlayImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .black
        isOpaque = true

        backImageView.image = UIImage(named: "IamRichBack1")
        backImageView.contentMode = .scaleAspectFit
        backImageView.clipsToBounds = true
        backImageView.isUserInteractionEnabled = false
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backImageView)

        overlayImageView.image = UIImage(named: "Default")
        overlayImageView.contentMode = .scaleAspectFill
        overlayImageView.alpha = 0.47
        overlayImageView.clipsToBounds = true
        overlayImageView.isUserInteractionEnabled = false
        overlayImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overlayImageView)

        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayImageView.topAnchor.constraint(equalTo: topAnchor),
            overlayImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
