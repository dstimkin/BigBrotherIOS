import UIKit

final class DaysOfWeekCollectionView: UICollectionView {

    // MARK: - Private types

    private enum Constants {

        static var cellIdentifier: String {
            return "DaysOfWeekCollectionViewCell"
        }

        static var redColor: UIColor {
            return UIColor(named: "BBRedColor")!
        }

    }

    // MARK: - Private properties

    private var daysOfWeek = [Bool]()

    // MARK: - Init

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        super.init(frame: .zero, collectionViewLayout: layout)

        register(DaysOfWeekCollectionViewCell.self,
                 forCellWithReuseIdentifier: Constants.cellIdentifier)
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
        contentInset = .init(top: 0, left: 15, bottom: 0, right: 15)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    func configure(for daysOfWeek: [Bool]) {
        self.daysOfWeek = daysOfWeek
        reloadData()
    }

    // MARK: - Private methods

    private func weekdayNameFrom(_ weekdayNumber: Int) -> String {
        let calendar = Calendar.current
        let dayIndex = ((weekdayNumber - 1) + (calendar.firstWeekday - 1)) % 7
        return calendar.shortWeekdaySymbols[dayIndex]
    }

}

// MARK: - Protocol UICollectionViewDataSource

extension DaysOfWeekCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        daysOfWeek.filter{ $0 }.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var counter = 0
        var result = 0
        for (index, day) in daysOfWeek.enumerated() where day {
            if counter == indexPath.row {
                result = index
                break
            }
            counter += 1
        }

        let cell = dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier,
                                       for: indexPath) as! DaysOfWeekCollectionViewCell
        cell.configure(title: weekdayNameFrom(result + 1), backgroundColor: .systemGreen)
        cell.layer.cornerRadius = 15

        return cell
    }

}

// MARK: - Protocol UICollectionViewDelegateFlowLayout

extension DaysOfWeekCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 30)
    }

}
