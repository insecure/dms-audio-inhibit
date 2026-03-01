import QtQuick
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    property bool inhibitWasDisabled: true
    property bool selfChangedInhibitor: false

    Component.onCompleted: {
        root.inhibitWasDisabled = IdleService.mediaPlaying ? true : !SessionService.idleInhibited;
    }

    Connections {
        target: SessionService

        function onInhibitorChanged() {
            if (root.selfChangedInhibitor) {
                root.selfChangedInhibitor = false;
                return;
            }
            if (!IdleService.mediaPlaying) {
                root.inhibitWasDisabled = !SessionService.idleInhibited;
                return;
            }
        }
    }

    Connections {
        target: MprisController.activePlayer

        function onIsPlayingChanged() {
            if (IdleService.mediaPlaying) {
                // selfChangedInhibitor is a simple hack to detect if the
                // inhibitor was changed by ourselves or by someone else. It's
                // not very reliable though.
                root.selfChangedInhibitor = true;
                SessionService.enableIdleInhibit();
            } else {
                if (root.inhibitWasDisabled) {
                    root.selfChangedInhibitor = true;
                    SessionService.disableIdleInhibit();
                    return;
                }
            }
        }
    }
}
