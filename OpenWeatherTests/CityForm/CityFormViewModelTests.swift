import XCTest
import SwiftUI
@testable import OpenWeather

class CityFormViewModelTests: XCTestCase {
    
    var viewModel: CityFormViewModel?
    
    override func setUp() {
        super.setUp()
        viewModel = CityFormViewModel(service: MockWeatherInformationService())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, "An unknown error occurred.")
        XCTAssertFalse(viewModel.showForecast)
        XCTAssertNil(viewModel.model)
        XCTAssertNil(viewModel.unit)
    }

    func testSwitchUnitToMetric() {
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.system = 0
        let unit = viewModel.switchUnit()
        XCTAssertEqual(unit, "metric")
        XCTAssertEqual(viewModel.unit, .metric)
    }
    
    func testSwitchUnitToImperial() {
        guard let viewModel = viewModel else {
            XCTFail("viewModel should not be nil")
            return
        }
        
        viewModel.system = 1
        let unit = viewModel.switchUnit()
        XCTAssertEqual(unit, "imperial")
        XCTAssertEqual(viewModel.unit, .imperial)
    }

    func testGetForecastSuccess() {
        let mockService = MockWeatherInformationService()
        viewModel = CityFormViewModel(service: mockService)
        
        let expectedCity = "London"
        
        viewModel?.getForecast(city: expectedCity)
        
        let expectation = XCTestExpectation(description: "Get forecast completes")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let viewModel = self.viewModel else {
                XCTFail("viewModel should not be nil")
                return
            }

            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.showForecast)
            XCTAssertNotNil(viewModel.model)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

    func testGetForecastFailure() {
        let mockService = MockWeatherInformationService(shouldFail: true)
        viewModel = CityFormViewModel(service: mockService)
        
        let expectedCity = "InvalidCity"

        viewModel?.getForecast(city: expectedCity)

        let expectation = XCTestExpectation(description: "Get forecast completes")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let viewModel = self.viewModel else {
                XCTFail("viewModel should not be nil")
                return
            }

            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.showErrorAlert)
            XCTAssertEqual(viewModel.errorMessage, "Invalid City")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}

class MockWeatherInformationService: CityWeatherInformationProtocol {
    var shouldFail: Bool

    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func getTemp(city: String, metric: String,_ completion: @escaping (Result<CityWeatherInformationModel, ApiError>) -> Void) {
        if shouldFail {
            completion(.failure(.invalidURL))
        } else {
            let mockModel = CityWeatherInformationModel(
                weather: [
                    .init(
                        id: 801,
                        main: "Clouds",
                        description: "few clouds",
                        icon: "02n"
                    )
                ],
                main: .init(temp: 26.84),
                name: "Miami",
                dt: 1723968314,
                id: 2009435
            )
            completion(.success(mockModel))
        }
    }
}
