import QtQuick 2.0
import QtQuick.Controls 1.0 as QQC1
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kcoreaddons 1.0 as KCoreAddons

import ".." as BatteryTime
import "../lib" as Lib

Lib.ConfigPage {
	id: page
	showAppletVersion: true

	BatteryTime.AppletConfig { id: config }
	
	Lib.ConfigSection {
		label: i18n("Breeze Battery Icon")

		Lib.ConfigCheckBox {
			text: i18n("Enabled")
			configKey: 'showBatteryIcon'
		}

		Lib.ConfigColor {
			label: i18n("Normal")
			configKey: 'normalColor'
			defaultColor: config.defaultNormalColor
		}

		Lib.ConfigColor {
			label: i18n("Charging")
			configKey: 'chargingColor'
			defaultColor: config.defaultChargingColor
		}
		RowLayout {
			Lib.ConfigSpinBox {
				before: i18n("Low Battery")
				suffix: '%'
				configKey: 'lowBatteryPercent'
				minimumValue: 0
				maximumValue: 100
			}
			Lib.ConfigColor {
				label: ''
				configKey: 'lowBatteryColor'
				defaultColor: config.defaultLowBatteryColor
			}
		}
	}

	Lib.ConfigSection {
		label: i18n("Percentage")

		Lib.ConfigCheckBox {
			text: i18n("Enabled")
			configKey: 'showPercentage'
		}
	}

	QQC1.ExclusiveGroup { id: timeLeftFormatGroup }
	Lib.ConfigSection {
		label: i18n("Time Left")

		Lib.ConfigCheckBox {
			text: i18n("Enabled")
			configKey: 'showTimeLeft'
		}

		QQC1.RadioButton {
			text: KCoreAddons.Format.formatDuration(69 * 1000, KCoreAddons.FormatTypes.HideSeconds)
			exclusiveGroup: timeLeftFormatGroup
			// checked: false
			// enabled: false
			checked: config.timeLeftUseLocaleFormat
			onClicked: plasmoid.configuration.timeLeftFormat = ''
		}
		QQC1.RadioButton {
			text: i18n("69m")
			exclusiveGroup: timeLeftFormatGroup
			// checked: true
			// enabled: false
			checked: !config.timeLeftUseLocaleFormat
			onClicked: plasmoid.configuration.timeLeftFormat = '69m'
		}
	}
}
