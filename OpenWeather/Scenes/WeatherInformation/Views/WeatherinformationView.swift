import Foundation
import UIKit

extension WeatherinformationView.Layout {
    static let spacingBottom10: CGFloat = -10
    static let spacingTrailing35: CGFloat = -35
    static let spacing20: CGFloat = 20
    static let spacing35: CGFloat = 35
    static let spacing60: CGFloat = 60
    static let spacing170: CGFloat = 170
}

class WeatherinformationView: UIViewController {
    fileprivate enum Layout {}
    
    // MARK: Properties
    var delegate: WeatherReloadActionProtocol?
    var cityName: String?
    var tempeture: Int?
    var icon: String?
    var unit: Unit?
    var date = 0
    
    // MARK: CustomViews
    // Using my header view as a custom view, so that this ViewController does not get to crowded
    private lazy var headerView = WeatherInformationHeaderView(
        cityLabelText: cityName ?? "",
        tempetureLabelText: tempeture ?? 0,
        image: icon ?? "",
        unit: unit ?? .metric
    )

    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var buttonView: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.primaryColor, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(
        cityName: String = "",
        tempeture: Double = 0.00,
        icon: String = "",
        unit: Unit,
        date: Int = 0,
        delegate: WeatherReloadActionProtocol? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        self.cityName = cityName
        self.tempeture = Int(tempeture)
        self.icon = icon
        self.unit = unit
        self.date = date
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
        configureViews()
    }
    
    private func setHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(buttonView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.spacing35),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.spacingTrailing35),
            headerView.heightAnchor.constraint(equalToConstant: Layout.spacing170)
        ])
        
        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Layout.spacingBottom10),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.spacing35),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.spacingTrailing35),
            buttonView.heightAnchor.constraint(equalToConstant: Layout.spacing60)
        ])
    }
    
    private func configureViews() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = Layout.spacing20

        if date.isDayTime() {
            backgroundView.image = UIImage(named: "backgroundDay")
        } else {
            backgroundView.image = UIImage(named: "backgroundNight")
        }
    }
    
    //Passing the button action via protocol/delegate
    @objc func reloadButtonTapped() {
        delegate?.didTapReloadButton()
    }
}
