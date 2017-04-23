import Quick
import Nimble
import ReactiveSwift
import ReactiveCocoa
import Result
import UserNotifications

// Cannot test since Bundle Identifier is missing. See http://www.openradar.me/27286490
@available(iOS 10.0, *)
class UNUserNotificationCenterSpec: QuickSpec {
	override func spec() {
		
		var userNotificationCenter: UNUserNotificationCenter!
		
		beforeEach {
			userNotificationCenter = .current()
		}
		
		afterEach {
			userNotificationCenter = nil
		}

		it("should add Notification requests to the queue") {
			let (pipeSignal, observer) = Signal<UNNotificationRequest, NoError>.pipe()
			userNotificationCenter.reactive.add <~ pipeSignal
			
			let content = UNNotificationContent()
			let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
			let request = UNNotificationRequest(identifier: "someIdentifier", content: content, trigger: notificationTrigger)
			observer.send(value: request)
			
			userNotificationCenter.getPendingNotificationRequests {
				expect($0).to(contain(request))
			}
			
		}
	}
}
