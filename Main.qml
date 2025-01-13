import QtQuick
import QtSensors

Window {
    id: mainWindow
    width: 320
    height: 480
    visible: true
    title: qsTr("42Hangouts")
    readonly property double radians_to_degrees: 180 / Math.PI

    Accelerometer {
        id: accel
        active: true
        dataRate: 200
        property real threshold: 0.01  // Lowered threshold for more sensitivity
        property real sensitivity: 10   // Scaled sensitivity for movement
        Component.onCompleted: {
            console.log("Accelerometer has been created and is active.");
        }

        onReadingChanged: {
            if (accel.reading) {
                let deltaX = accel.reading.x * sensitivity;
                let deltaY = accel.reading.y * sensitivity;

                if (Math.abs(deltaX) > threshold || Math.abs(deltaY) > threshold) {
                    // Updating position with scaling and smoothing
                    bubble.x = bubble.centerX + deltaX;
                    bubble.y = bubble.centerY + deltaY;
                }
            }
        }
    }

    function calcPitch(x, y, z) {
        return -Math.atan2(y, Math.hypot(x, z)) * mainWindow.radians_to_degrees;
    }

    function calcRoll(x, y, z) {
        return -Math.atan2(x, Math.hypot(y, z)) * mainWindow.radians_to_degrees;
    }

    Image {
        id: bubble
        source: "42_Logo.png"
        smooth: true
        width: 100
        height: 100

        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2

        x: centerX - width / 2
        y: centerY - height / 2

        Behavior on x {
            SmoothedAnimation {
                easing.type: Easing.InOutQuad
                duration: 50   // Shorter duration for more responsiveness
            }
        }
        Behavior on y {
            SmoothedAnimation {
                easing.type: Easing.InOutQuad
                duration: 50   // Shorter duration for more responsiveness
            }
        }
    }
}
