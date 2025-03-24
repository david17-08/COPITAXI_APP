plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    flavorDimensions "role"
    productFlavors {
        usuario {
            dimension "role"
            applicationId "com.copitaxi.usuario"
        }
        conductor {
            dimension "role"
            applicationId "com.copitaxi.conductor"
        }
        admin {
            dimension "role"
            applicationId "com.copitaxi.admin"
        }
    }
}

flutter {
    source = "../.."
}
