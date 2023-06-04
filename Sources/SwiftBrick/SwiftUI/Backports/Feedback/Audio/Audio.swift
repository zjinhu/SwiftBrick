import SwiftUI
@available(iOS 14, *)
/// Represents an audio URL
public struct Audio: Identifiable, Hashable {
    public var id: String { url.path }
    public let url: URL

    init(url: URL) {
        self.url = url
    }

    init?(name: String, bundle: Bundle) {
        guard let url = bundle.url(forResource: name, withExtension: nil) else { return nil }
        self.url = url
    }

    /// Returns a new instance from the specified URL
    /// - Parameter url: The URL of the audio file
    public static func custom(url: URL) -> Self {
        .init(url: url)
    }

    /// Returns a new instance from a resource in the specified bundle
    /// - Parameters:
    ///   - name: The name of the resource
    ///   - bundle: The bundle where the resource is located
    public static func custom(named name: String, in bundle: Bundle = .main) -> Self? {
        .init(name: name, bundle: bundle)
    }
}
@available(iOS 14, *)
public extension Audio {
    static let busyToneANSI = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/busy_tone_ansi.caf")
    )
    
    static let busyToneCEPT = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/busy_tone_cept.caf")
    )
    
    static let callWaitingToneANSI = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/call_waiting_tone_ansi.caf")
    )
    
    static let callWaitingToneCEPT = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/call_waiting_tone_cept.caf")
    )
    
    static let ctCallWaiting = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ct-call-waiting.caf")
    )
    
    static let dtmf0 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-0.caf")
    )
    
    static let dtmf1 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-1.caf")
    )
    
    static let dtmf2 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-2.caf")
    )
    
    static let dtmf3 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-3.caf")
    )
    
    static let dtmf4 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-4.caf")
    )
    
    static let dtmf5 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-5.caf")
    )
    
    static let dtmf6 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-6.caf")
    )
    
    static let dtmf7 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-7.caf")
    )
    
    static let dtmf8 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-8.caf")
    )
    
    static let dtmf9 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-9.caf")
    )
    
    static let dtmfPound = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-pound.caf")
    )
    
    static let dtmfStar = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/dtmf-star.caf")
    )
    
    static let endCallToneCEPT = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/end_call_tone_cept.caf")
    )
    
    static let headphoneAudioExposureLimitExceeded = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/HeadphoneAudioExposureLimitExceeded.caf")
    )
    
    static let healthNotificationUrgent = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/HealthNotificationUrgent.caf")
    )
    
    static let mediaHandoff = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MediaHandoff.caf")
    )
    
    static let mediaPaused = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MediaPaused.caf")
    )
    
    static let micMute = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MicMute.caf")
    )
    
    static let micUnmute = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MicUnmute.caf")
    )
    
    static let micUnmuteFail = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MicUnmuteFail.caf")
    )
    
    static let multiwayJoin = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MultiwayJoin.caf")
    )
    
    static let multiwayLeave = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/MultiwayLeave.caf")
    )
    
    static let pushToTalkJoined = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/PushToTalkJoined.caf")
    )
    
    static let pushToTalkLeft = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/PushToTalkLeft.caf")
    )
    
    static let pushToTalkMute = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/PushToTalkMute.caf")
    )
    
    static let pushToTalkUnmute = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/PushToTalkUnmute.caf")
    )
    
    static let pushToTalkUnmuteFail = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/PushToTalkUnmuteFail.caf")
    )
    
    static let ringbackToneANSI = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ringback_tone_ansi.caf")
    )
    
    static let ringbackToneAUS = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ringback_tone_aus.caf")
    )
    
    static let ringbackToneCEPT = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ringback_tone_cept.caf")
    )
    
    static let ringbackToneHK = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ringback_tone_hk.caf")
    )
    
    static let ringbackToneUK = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ringback_tone_uk.caf")
    )
    
    static let screenCapture = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ScreenCapture.caf")
    )
    
    static let screenSharingStarted = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/ScreenSharingStarted.caf")
    )
    
    static let vcEnded = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/vc~ended.caf")
    )
    
    static let vcInvitationAccepted = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/vc~invitation-accepted.caf")
    )
    
    static let vcRinging = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/vc~ringing.caf")
    )
    
    static let vcRingingWatch = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/vc~ringing_watch.caf")
    )
    
    static let workoutCompleteAutodetect = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/WorkoutCompleteAutodetect.caf")
    )
    
    static let workoutPaceAbove = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/WorkoutPaceAbove.caf")
    )
    
    static let workoutPaceBelow = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/WorkoutPaceBelow.caf")
    )
    
    static let workoutPausedAutoDetect = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/WorkoutPausedAutoDetect.caf")
    )
    
    static let workoutResumedAutoDetect = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/WorkoutResumedAutoDetect.caf")
    )
    
    static let workoutStartAutodetect = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/WorkoutStartAutodetect.caf")
    )
    
    static let critical = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/3rd_party_critical.caf")
    )
    
    static let accessScanComplete = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/access_scan_complete.caf")
    )
    
    static let acknowledgmentReceived = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/acknowledgment_received.caf")
    )
    
    static let acknowledgmentSent = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/acknowledgment_sent.caf")
    )
    
    static let alarm = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/alarm.caf")
    )
    
    static let beginRecord = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/begin_record.caf")
    )
    
    static let cameraTimerCountdown = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/camera_timer_countdown.caf")
    )
    
    static let cameraTimerFinalSecond = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/camera_timer_final_second.caf")
    )
    
    static let connectPower = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/connect_power.caf")
    )
    
    static let ctBusy = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ct-busy.caf")
    )
    
    static let ctCongestion = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ct-congestion.caf")
    )
    
    static let ctError = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ct-error.caf")
    )
    
    static let ctKeytone2 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ct-keytone2.caf")
    )
    
    static let ctPathACK = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ct-path-ack.caf")
    )
    
    static let deviceShutdown = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/DeviceShutdown.caf")
    )
    
    static let doorbell = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Doorbell.caf")
    )
    
    static let endRecord = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/end_record.caf")
    )
    
    static let focusChangeAppIcon = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/focus_change_app_icon.caf")
    )
    
    static let focusChangeKeyboard = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/focus_change_keyboard.caf")
    )
    
    static let focusChangeLarge = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/focus_change_large.caf")
    )
    
    static let focusChangeSmall = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/focus_change_small.caf")
    )
    
    static let gotoSleepAlert = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/go_to_sleep_alert.caf")
    )
    
    static let healthNotification = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/health_notification.caf")
    )
    
    static let jblAmbiguous = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_ambiguous.caf")
    )
    
    static let jblBegin = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_begin.caf")
    )
    
    static let jblBeginShort = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_begin_short.caf")
    )
    
    static let jblBeginShortCarplay = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_begin_short_carplay.caf")
    )
    
    static let jblCancel = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_cancel.caf")
    )
    
    static let jblConfirm = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_confirm.caf")
    )
    
    static let jblNoMatch = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/jbl_no_match.caf")
    )
    
    static let keyPressClick = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/key_press_click.caf")
    )
    
    static let keyPressDelete = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/key_press_delete.caf")
    )
    
    static let keyPressModifier = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/key_press_modifier.caf")
    )
    
    static let keyboardPressClear = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/keyboard_press_clear.caf")
    )
    
    static let keyboardPressDelete = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/keyboard_press_delete.caf")
    )
    
    static let keyboardPressNormal = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/keyboard_press_normal.caf")
    )
    
    static let lock = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/lock.caf")
    )
    
    static let longLowShortHigh = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/long_low_short_high.caf")
    )
    
    static let lowPower = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/low_power.caf")
    )
    
    static let mailSent = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/mail-sent.caf")
    )
    
    static let middle9ShortDoubleLow = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/middle_9_short_double_low.caf")
    )
    
    static let multiwayInvitation = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/multiway_invitation.caf")
    )
    
    static let navigationPop = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/navigation_pop.caf")
    )
    
    static let navigationPush = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/navigation_push.caf")
    )
    
    static let navigationGenericManeuver = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/NavigationGenericManeuver.caf")
    )
    
    static let newMail = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/new-mail.caf")
    )
    
    static let nfcScanComplete = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nfc_scan_complete.caf")
    )
    
    static let nfcScanFailure = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/nfc_scan_failure.caf")
    )
    
    static let paymentFailure = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/payment_failure.caf")
    )
    
    static let paymentSuccess = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/payment_success.caf")
    )
    
    static let paymentReceived = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PaymentReceived.caf")
    )
    
    static let paymentReceivedFailure = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PaymentReceivedFailure.caf")
    )
    
    static let photoShutter = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/photoShutter.caf")
    )
    
    static let pinDelete = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PINDelete.caf")
    )
    
    static let pinDeleteAX = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PINDelete_AX.caf")
    )
    
    static let pinEnterDigit = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PINEnterDigit.caf")
    )
    
    static let pinEnterDigitAX = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PINEnterDigit_AX.caf")
    )
    
    static let pinSubmitAX = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PINSubmit_AX.caf")
    )
    
    static let pinUnexpected = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/PINUnexpected.caf")
    )
    
    static let receivedMessage = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ReceivedMessage.caf")
    )
    
    static let ringerChanged = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/RingerChanged.caf")
    )
    
    static let sentMessage = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/SentMessage.caf")
    )
    
    static let shake = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/shake.caf")
    )
    
    static let shortDoubleHigh = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/short_double_high.caf")
    )
    
    static let shortDoubleLow = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/short_double_low.caf")
    )
    
    static let shortLowHigh = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/short_low_high.caf")
    )
    
    static let simToolkitCallDropped = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/SIMToolkitCallDropped.caf")
    )
    
    static let simToolkitGeneralBeep = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/SIMToolkitGeneralBeep.caf")
    )
    
    static let simToolkitNegativeACK = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/SIMToolkitNegativeACK.caf")
    )
    
    static let simToolkitPositiveACK = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/SIMToolkitPositiveACK.caf")
    )
    
    static let simToolkitSMS = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/SIMToolkitSMS.caf")
    )
    
    static let smsReceived1 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received1.caf")
    )
    
    static let smsReceived2 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received2.caf")
    )
    
    static let smsReceived3 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received3.caf")
    )
    
    static let smsReceived4 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received4.caf")
    )
    
    static let smsReceived5 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received5.caf")
    )
    
    static let smsReceived6 = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received6.caf")
    )
    
    static let swish = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Swish.caf")
    )
    
    static let tink = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Tink.caf")
    )
    
    static let tock = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Tock.caf")
    )
    
    static let tweetSent = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/tweet_sent.caf")
    )
    
    static let ussd = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/ussd.caf")
    )
    
    static let warsaw = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/warsaw.caf")
    )
    
    static let webcamStart = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/WebcamStart.caf")
    )
    
    static let wheelsOfTime = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/wheels_of_time.caf")
    )
    
    static let anticipate = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Anticipate.caf")
    )
    
    static let bloom = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Bloom.caf")
    )
    
    static let calypso = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Calypso.caf")
    )
    
    static let chooChoo = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Choo_Choo.caf")
    )
    
    static let descent = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Descent.caf")
    )
    
    static let fanfare = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Fanfare.caf")
    )
    
    static let ladder = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Ladder.caf")
    )
    
    static let minuet = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Minuet.caf")
    )
    
    static let newsFlash = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/News_Flash.caf")
    )
    
    static let noir = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Noir.caf")
    )
    
    static let sherwoodForest = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Sherwood_Forest.caf")
    )
    
    static let spell = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Spell.caf")
    )
    
    static let suspense = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Suspense.caf")
    )
    
    static let telegraph = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Telegraph.caf")
    )
    
    static let tiptoes = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Tiptoes.caf")
    )
    
    static let typewriters = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Typewriters.caf")
    )
    
    static let update = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/New/Update.caf")
    )
    
    static let cameraShutterBurst = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf")
    )
    
    static let cameraShutterBurstBegin = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf")
    )
    
    static let cameraShutterBurstEnd = Self(
        url: URL(fileURLWithPath: "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf")
    )
}
