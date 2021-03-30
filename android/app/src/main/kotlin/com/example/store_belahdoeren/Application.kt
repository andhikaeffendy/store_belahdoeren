package com.example.store_belahdoeren

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin

import io.flutter.view.FlutterMain

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterMain.startInitialization(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"))
    }
}