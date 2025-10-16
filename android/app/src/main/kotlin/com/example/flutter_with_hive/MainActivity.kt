package com.example.flutter_with_hive

import android.os.Bundle
import android.webkit.WebView
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		// Disable WebView remote debugging to reduce Chromium console logs from ad creatives
		// This prevents repeated "I/chromium" console messages being printed during development.
		WebView.setWebContentsDebuggingEnabled(false)
	}
}
