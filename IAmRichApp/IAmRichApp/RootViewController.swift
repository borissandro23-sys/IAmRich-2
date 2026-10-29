import UIKit

/// Root controller matching the original Utility Application pattern.
/// Hosts the main view, the info button (UIButtonType.infoLight), and
/// performs the classic flip transition to the flipside.
class RootViewController: UIViewController {

    private var mainViewController: MainViewController!
    private var flipsideViewController: FlipsideViewController?
    private var infoButton: UIButton!
    private var isShowingFlipside = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        mainViewController = MainViewController()
        addChild(mainViewController)
        mainViewController.view.frame = view.bounds
        mainViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mainViewController.view)
        mainViewController.didMove(toParent: self)

        // Original: UIButtonType = 3 (InfoLight), ~18x19, center {283, 423.5} on 320x460
        infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoButton)

        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            infoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override var prefersStatusBarHidden: Bool { false }

    @objc func toggleView() {
        if isShowingFlipside {
            guard let flipside = flipsideViewController else { return }
            UIView.transition(with: view, duration: 0.75, options: .transitionFlipFromLeft, animations: {
                flipside.willMove(toParent: nil)
                flipside.view.removeFromSuperview()
                flipside.removeFromParent()
                self.addChild(self.mainViewController)
                self.mainViewController.view.frame = self.view.bounds
                self.view.insertSubview(self.mainViewController.view, belowSubview: self.infoButton)
                self.mainViewController.didMove(toParent: self)
                self.infoButton.isHidden = false
            }, completion: { _ in
                self.isShowingFlipside = false
            })
        } else {
            if flipsideViewController == nil {
                loadFlipsideViewController()
            }
            guard let flipside = flipsideViewController else { return }
            UIView.transition(with: view, duration: 0.75, options: .transitionFlipFromRight, animations: {
                self.mainViewController.willMove(toParent: nil)
                self.mainViewController.view.removeFromSuperview()
                self.mainViewController.removeFromParent()
                self.addChild(flipside)
                flipside.view.frame = self.view.bounds
                self.view.insertSubview(flipside.view, belowSubview: self.infoButton)
                flipside.didMove(toParent: self)
                self.infoButton.isHidden = true
            }, completion: { _ in
                self.isShowingFlipside = true
            })
        }
    }

    private func loadFlipsideViewController() {
        let flipside = FlipsideViewController()
        flipside.doneHandler = { [weak self] in self?.toggleView() }
        flipsideViewController = flipside
    }
}
