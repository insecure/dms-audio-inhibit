# Audio Inhibit

A DankMaterialShell(DMS) daemon plugin that enables the idle inhibitor when audio is playing.

## Technical Details

When loading, the plugin stores the current idleInhibitor state so it can be restored when audio stops. It also tries to monitor changes to the idle inhibitor and update this state.
There are basically three situations when this "restore-state" is updated:

* Audio is already playing when plugin loads - assume inhibitor was disabled before playing
* Inhibitor is changed while playing audio - the restore-state is not updated
* Inhibitor is changed while NOT playing audio - the restore-state is updated accordingly

## Known Bugs

Detecting and restoring the inhibitor state before starting audio is not very reliable. Changing the inhibitor state several times too fast 

**Workaround**: Wait some seconds when changing the inhibitor state before changing it again.

## Installation

The recommended way of installing this plugin is via the DMS plugin manager.

### Manual Installation

1. Copy or symlink this plugin to the DMS plugins directory, e.g. `ln -s /path/to/dms-audio-inhibit ~/.config/DankMaterialShell/plugins/dms-audio-inhibit`
2. Open DMS Settings
3. Go to Plugins tab
4. Click "Scan" if plugin is not already listed
5. Enable "Audio Inhibit"
