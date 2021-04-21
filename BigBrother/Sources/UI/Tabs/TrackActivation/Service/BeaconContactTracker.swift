import Foundation
import CoreLocation
import CoreBluetooth

// MARK: - Protocols

protocol ContactTracker: AnyObject {

    func startTracking()
    func stopTracking()

}

protocol ContactTrackerDelegate: AnyObject {

    func contactDidOccur(contact: Contact)
    func trackingErrorDidOccur()

}

// MARK: - Implementation

final class BeaconContactTracker: NSObject, ContactTracker {

    // MARK: - Private types

    private enum Constants {

        static var defaultProximityUUID: UUID {
            return UUID(uuidString: "cd75a35d-6837-443c-87da-6e6391a65c85")!
        }

        static var defaultMajorValue: Int {
            return 1
        }

        static var beaconRegionIdentifier: String {
            return "com.bigBrother.beaconRegion"
        }

        static var deviceBeaconIdentifier: String {
            return "com.bigBrother.deviceBeacon"
        }

    }

    // MARK: - Private properties

    private weak var delegate: ContactTrackerDelegate?
    private let beaconRegion: CLBeaconRegion
    private let deviceBeacon: CLBeaconRegion

    private let locationManager = CLLocationManager()
    private let peripheralManager = CBPeripheralManager()

    // MARK: - Init

    init(uuid: UUID = Constants.defaultProximityUUID,
         majorValue: Int = Constants.defaultMajorValue,
         delegate: ContactTrackerDelegate? = nil) {

        self.delegate = delegate
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid,
                                           major: CLBeaconMajorValue(majorValue),
                                           identifier: Constants.beaconRegionIdentifier)

        self.deviceBeacon = CLBeaconRegion(proximityUUID: uuid,
                                           major: CLBeaconMajorValue(majorValue),
                                           minor: 3,
                                           identifier: Constants.deviceBeaconIdentifier)
        super.init()
        locationManager.delegate = self
        peripheralManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.requestAlwaysAuthorization()
    }

    // MARK: - Internal properties

    func startTracking() {
        locationManager.startRangingBeacons(in: beaconRegion)
        locationManager.startUpdatingLocation()

        guard peripheralManager.state == .poweredOn else {
            delegate?.trackingErrorDidOccur()
            return
        }

        let peripheralData = deviceBeacon.peripheralData(withMeasuredPower: nil) as NSDictionary
        peripheralManager.startAdvertising((peripheralData as! [String : Any]))
    }

    func stopTracking() {
        locationManager.stopRangingBeacons(in: beaconRegion)
        locationManager.stopUpdatingLocation()
        peripheralManager.stopAdvertising()
    }

}

// MARK: - Protocol CLLocationManagerDelegate

extension BeaconContactTracker: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         monitoringDidFailFor region: CLRegion?,
                         withError error: Error) {

        delegate?.trackingErrorDidOccur()
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {

        delegate?.trackingErrorDidOccur()
    }

    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                         in region: CLBeaconRegion) {

        let date = Date()
        for beacon in beacons
        where beacon.proximity == .near || beacon.proximity == .immediate {
            let contact: Contact = Contact(secondContacteeId: Int(truncating: beacon.minor),
                                           dateOfContact: date)
            delegate?.contactDidOccur(contact: contact)
        }
    }

}

// MARK: - Protocol CBPeripheralManagerDelegate

extension BeaconContactTracker: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        guard peripheral.state == .poweredOn else {
            delegate?.trackingErrorDidOccur()
            return
        }
    }

}
