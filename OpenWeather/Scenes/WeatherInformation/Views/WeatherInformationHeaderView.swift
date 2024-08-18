import UIKit

extension WeatherInformationHeaderView.Layout {
    static let spacingTrailing15: CGFloat = -15
    static let spacingTrailing26: CGFloat = -26
    static let spacing8: CGFloat = 8
    static let spacing15: CGFloat = 15
    static let spacing18: CGFloat = 18
    static let spacing20: CGFloat = 20
    static let spacing24: CGFloat = 24
    static let spacing60:CGFloat = 60
    static let spacing86: CGFloat = 86
}

class WeatherInformationHeaderView: UIView {
    fileprivate enum Layout {}
    
    //Properties
    private lazy var image = UIImage()
    private var cityName: String?
    private var tempeture: Int?
    private var unit: Unit?
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Layout.spacing20
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Layout.spacing20)
        label.textColor = .primaryColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tempetureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Layout.spacing60, weight: .bold)
        label.textColor = .primaryColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(cityLabelText: String, tempetureLabelText: Int, image: String, unit: Unit) {
        super.init(frame: .zero)
        self.cityName = cityLabelText
        self.tempeture = tempetureLabelText
        self.unit = unit
        self.image = UIImage(named: image) ?? UIImage()
        setupView()
    }

    private func setupView() {
        headerView.backgroundColor = .white
        setHierarchy()
        setConstraints()
        configureViews()
    }
    
    private func setHierarchy() {
        addSubview(headerView)
        headerView.addSubview(cityLabel)
        headerView.addSubview(tempetureLabel)
        headerView.addSubview(weatherImageView) 
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Layout.spacing15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Layout.spacing15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: Layout.spacingTrailing15),
            cityLabel.heightAnchor.constraint(equalToConstant: Layout.spacing24)
        ])
        
        NSLayoutConstraint.activate([
            tempetureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: Layout.spacing20),
            tempetureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Layout.spacing18)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: Layout.spacing86),
            weatherImageView.heightAnchor.constraint(equalToConstant: Layout.spacing86),
            weatherImageView.leadingAnchor.constraint(equalTo: tempetureLabel.trailingAnchor, constant: Layout.spacing8),
            weatherImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: Layout.spacingTrailing26),
            weatherImageView.centerYAnchor.constraint(equalTo: tempetureLabel.centerYAnchor)
        ])
    }
    
    private func configureViews() {
        confirgureLabels()
        weatherImageView.image = self.image
    }
    
    private func confirgureLabels() {
        cityLabel.text = cityName
        tempetureLabel.text = "\(tempeture ?? 0)\(setupTempeture())"
    }
    
    private func setupTempeture() -> String {
        switch unit {
        case .imperial:
            return "°F"
        default:
            return "°C"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
