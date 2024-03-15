import Foundation

@MainActor
final class TortureTimer: ObservableObject {
    struct Torturer: Identifiable {
        let fakeName: String
        var isCompleted: Bool
        let id = UUID()
    }
    
    @Published var activeTorturer = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    private(set) var torturers: [Torturer] = []

    private(set) var lengthInMinutes: Int
    var torturerChangedAction: (() -> Void)?

    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var tortureSecondsPerTorturer: Int {
        (lengthInMinutes * 60) / torturers.count
    }
    private var secondsElapsedForTorturer: Int = 0
    private var torturerIndex: Int = 0
    private var torturerText: String {
        return "Torturer \(torturerIndex + 1): " + torturers[torturerIndex].fakeName
    }
    private var startDate: Date?
    
    /**
     Initialize a new timer. Initializing a time with no arguments creates a ScrumTimer with no attendees and zero length.
     Use `startScrum()` to start the timer.
     
     - Parameters:
        - lengthInMinutes: The meeting length.
        -  attendees: A list of attendees for the meeting.
     */
    init(lengthInMinutes: Int = 0, victims: [DailyMadness.Victim] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.torturers = victims.asTorturers
        secondsRemaining = lengthInSeconds
        activeTorturer = torturerText
    }
    
    func startTorture() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToTorturer(at: 0)
    }
    
    func stopMadness() {
        timer?.invalidate()
        timerStopped = true
    }
    
    nonisolated func skipTorturer() {
        Task { @MainActor in
            changeToTorturer(at: torturerIndex + 1)
        }
    }
    
    private func changeToTorturer(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            torturers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForTorturer = 0
        guard index < torturers.count else { return }
        torturerIndex = index
        activeTorturer = torturerText

        secondsElapsed = index * tortureSecondsPerTorturer
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
    }


    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate,
                  !timerStopped else { return }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForTorturer = secondsElapsed
            self.secondsElapsed = tortureSecondsPerTorturer * torturerIndex + secondsElapsedForTorturer
            guard secondsElapsed <= tortureSecondsPerTorturer else {
                return
            }
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

            if secondsElapsedForTorturer >= tortureSecondsPerTorturer {
                changeToTorturer(at: torturerIndex + 1)
                torturerChangedAction?()
            }
        }
    }
    
    func reset(lengthInMinutes: Int, victims: [DailyMadness.Victim]) {
        self.lengthInMinutes = lengthInMinutes
        self.torturers = victims.asTorturers
        secondsRemaining = lengthInSeconds
        activeTorturer = torturerText
    }
}

extension Array<DailyMadness.Victim> {
    var asTorturers: [TortureTimer.Torturer] {
        if isEmpty {
            return [TortureTimer.Torturer(fakeName: "Speaker 1", isCompleted: false)]
        } else {
            return map { TortureTimer.Torturer(fakeName: $0.denomination, isCompleted: false) }
        }
    }
}
