import Foundation

extension Int {
    func isDayTime() -> Bool {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let calendar = Calendar.current

        let hour = calendar.component(.hour, from: date)

        let dayStartHour = 6
        let dayEndHour = 18

        return hour >= dayStartHour && hour < dayEndHour
    }
}
