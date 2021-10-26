using System;
using System.Collections;
using GLFW;

namespace Example {
	class Program {
		public static void Main() {
			// Initialize GLFW
			if (!Glfw.Init()) Console.WriteLine("Failed to initialize GLFW.");
			else {
				int major = 0;
				int minor = 0;
				int rev = 0;
				Glfw.GetVersion(ref major, ref minor, ref rev);


				Console.WriteLine("Initialized GLFW {}.{}.{}", major, minor, rev);
			}

			// Set error callback
			Glfw.SetErrorCallback(new (error, description) => Console.WriteLine("Error {}: {}", error, description));

			// Get monitors
			int monitorCount = 0;
			GlfwMonitor** monitors = Glfw.GetMonitors(ref monitorCount);

			for (int i < monitorCount) {
				String name = scope .();
				Glfw.GetMonitorName(monitors[i], name);

				GlfwVideoMode* videoMode = Glfw.GetVideoMode(monitors[i]);
				Console.WriteLine("Monitor {}: '{}' {}x{}", i, name, videoMode.width, videoMode.height);
			}

			// Set window hints and create window
			Glfw.WindowHint(.Visible, false);
			Glfw.WindowHint(.ClientApi, Glfw.ClientApi.OpenGlApi);
			Glfw.WindowHint(.ContextVersionMajor, 3);
			Glfw.WindowHint(.ContextVersionMinor, 3);

			GlfwWindow* window = Glfw.CreateWindow(1280, 720, "GLFW", null, null);

			Glfw.MakeContextCurrent(window);

			// Set key callback
			Glfw.SetKeyCallback(window, new (window, key, scancode, action, mods) => {
				if (key == .Escape && action == .Press) Glfw.SetWindowShouldClose(window, true);
			});

			// Show window
			Glfw.ShowWindow(window);

			// Main loop
			while (!Glfw.WindowShouldClose(window)) {
				Glfw.PollEvents();
				Glfw.SwapBuffers(window);
			}

			// Destroy window and terminate GLFW
			Glfw.DestroyWindow(window);
			Glfw.Terminate();
		}
	}
}