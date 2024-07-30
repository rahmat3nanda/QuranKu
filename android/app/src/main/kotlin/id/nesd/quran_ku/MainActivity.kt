package id.nesd.quranku

import id.nesd.quran_ku.BiometricHandler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "id.nesd.quranku.channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "checkFingerprint") {
                if (!BiometricHandler.isBiometricAvailable(context)) {
                    result.error("1", "Biometric Not Available", null)
                    return@setMethodCallHandler
                }

                result.success(true)
                return@setMethodCallHandler
            }
            if (call.method == "authFingerprint") {
                if (!BiometricHandler.isBiometricAvailable(context)) {
                    result.error("2", "Biometric Not Available", null)
                    return@setMethodCallHandler
                }

                BiometricHandler.showBiometricPrompt(context) { success, message ->
                    if (success) {
                        result.success(true)
                    } else {
                        result.error("3", message, null)
                    }
                }

                return@setMethodCallHandler
            }

            result.notImplemented()
        }
    }
}
