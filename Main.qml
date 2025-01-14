import someclass 1.0
import QtQuick
import QtSensors
import QtQuick.Controls
import QtQuick.Layouts


/*Being a strongly typed language, C++ is best suited for an application's business logic.
Typically, such code performs tasks such as complex calculations or data processing, which are faster in C++ than QML.
Qt offers various approaches to integrate QML and C++ code in an application.
A typical use case is displaying a list of data in a user interface. If the data set is static, simple, and/or small, a model written in QML can be sufficient.
Use C++ for dynamic data sets that are large or frequently modified.*/
Window {
    id: mainWindow
    width: 320
    height: 480
    visible: true
    title: qsTr("42Hangouts")
    readonly property double radians_to_degrees: 180 / Math.PI

    SomeClass {
        id: myClass
    }

    Connections {
        target: myClass
        function onSomeVarChanged() {
            myLabel.text = myClass.someVar
        }
    }

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("Log in- test")
            /* contacts would go here*/
        }
        TabButton {
            text: qsTr("Discover")
        }
        TabButton {
            text: qsTr("Accelerometer")
        }

        onCurrentIndexChanged: {
            console.log("currentIndex changed to", currentIndex)
        }
    }

    StackLayout {
        width: parent.width
        currentIndex: bar.currentIndex
        Item {
            id: loginTab
        }
        Item {
            id: discoverTab
        }
        Item {
            id: accelerometerTab
        }
    }

    Item {
        id: loginForm
        visible: bar.currentIndex === 0 // Show only when "Log in- test" tab is selected
        anchors.centerIn: parent
        ColumnLayout {
            spacing: 20

            Text {
                text: qsTr("Log in")
                font.bold: true
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextField {
                id: usernameInput
                placeholderText: qsTr("Username")
                width: parent.width * 0.8
                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                id: passwordInput
                placeholderText: qsTr("Password")
                width: parent.width * 0.8
                echoMode: TextInput.Password
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: qsTr("Log in")
                width: parent.width * 0.8
                Layout.alignment: Qt.AlignHCenter

                onClicked: {
                    // Here you can handle the login logic (authentication, etc.)
                    console.log("Logging in with", usernameInput.text,
                                passwordInput.text)
                    myClass.handleLogin(usernameInput.text, passwordInput.text)
                }
            }
        }
    }

    Accelerometer {
        id: accel
        active: bar.currentIndex === 2 // Only active in the "Accelerometer" tab
        dataRate: 200
        property real threshold: 0.01
        property real sensitivity: 10

        Component.onCompleted: {
            console.log("Accelerometer initialized.")
        }

        onReadingChanged: {
            if (accel.reading && bar.currentIndex === 2) {
                // Only update in the "Accelerometer" tab
                let deltaX = accel.reading.x * sensitivity
                let deltaY = accel.reading.y * sensitivity

                if (Math.abs(deltaX) > threshold || Math.abs(
                            deltaY) > threshold) {
                    bubble.x = bubble.centerX + deltaX
                    bubble.y = bubble.centerY + deltaY
                }
            }
        }
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
        visible: bar.currentIndex === 2 // Only visible in the "Accelerometer" tab

        Behavior on x {
            SmoothedAnimation {
                easing.type: Easing.InOutQuad
                duration: 50
            }
        }
        Behavior on y {
            SmoothedAnimation {
                easing.type: Easing.InOutQuad
                duration: 50
            }
        }
    }
}
