import ReactiveSwift
import UserNotifications

@available(iOS 10.0, *)
extension Reactive where Base == UNUserNotificationCenter {
	public var add: BindingTarget<UNNotificationRequest> {
		return makeBindingTarget { $0.add($1) }
	}
}
