//import UIKit
//
//class WeatherInformationButtonView: UIView {
//    
//    weak var actionDelegate: WeatherReloadActionProtocol?
//    
//    private lazy var button: UIButton = {
//        let button = UIButton()
//        button.setTitle("Reload", for: .normal)
//        //button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
//        button.backgroundColor = .white
//        button.setTitleColor(.primaryColor, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        //button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 35, bottom: 10, right: 35)
//        return button
//    }()
//    
//    init(actionDelegate: WeatherReloadActionProtocol? = nil) {
//        super.init(frame: .zero)
//        self.actionDelegate = actionDelegate
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupView() {
//        setHierarchy()
//        setConstraints()
//    }
//    
//    private func setHierarchy() {
//        addSubview(button)
//    }
//    
//    private func setConstraints() {
//        NSLayoutConstraint.activate([
////            button.centerXAnchor.constraint(equalTo: centerXAnchor),
////            button.centerYAnchor.constraint(equalTo: centerYAnchor),
//            button.widthAnchor.constraint(equalToConstant: 100),
//            button.heightAnchor.constraint(equalToConstant: 50),
//        ])
//    }
//
//
//}
