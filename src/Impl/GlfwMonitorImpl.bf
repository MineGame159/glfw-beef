using System;
using System.Interop;

namespace GLFW {
	extension Glfw {
		// Callbacks

		private function void RawMonitorCallback(GlfwMonitor* monitor, c_int event);
		/// The delegate type for monitor configuration callbacks.
		public delegate void MonitorCallback(GlfwMonitor* monitor, GlfwMonitor.Event event);
		private static MonitorCallback monitorCallback ~ delete _;

		// Functions

		[CLink]
		private static extern GlfwMonitor** glfwGetMonitors(c_intptr* count);
		/// Returns the currently connected monitors.
		public static GlfwMonitor** GetMonitors(ref int count) => glfwGetMonitors(&count);

		[LinkName("glfwGetPrimaryMonitor")]
		/// Returns the primary monitor.
		public static extern GlfwMonitor* GetPrimaryMonitor();

		[CLink]
		private static extern void glfwGetMonitorPos(GlfwMonitor* monitor, c_intptr* x, c_intptr* y);
		/// Returns the position of the monitor's viewport on the virtual screen.
		public static void GetMonitorPos(GlfwMonitor* monitor, ref int x, ref int y) => glfwGetMonitorPos(monitor, &x, &y);

		[CLink]
		private static extern void glfwGetMonitorWorkarea(GlfwMonitor* monitor, c_intptr* x, c_intptr* y, c_intptr* width, c_intptr* height);
		/// Retrieves the work area of the monitor.
		public static void GetMonitorWorkarea(GlfwMonitor* monitor, ref int x, ref int y, ref int width, ref int height) => glfwGetMonitorWorkarea(monitor, &x, &y, &width, &height);

		[CLink]
		private static extern void glfwGetMonitorPhysicalSize(GlfwMonitor* monitor, c_intptr* width, c_intptr* height);
		/// Returns the physical size of the monitor.
		public static void GetMonitorPhysicalSize(GlfwMonitor* monitor, ref int width, ref int height) => glfwGetMonitorPhysicalSize(monitor, &width, &height);

		[CLink]
		private static extern void glfwGetMonitorContentScale(GlfwMonitor* monitor, float* xScale, float* yScale);
		/// Retrieves the content scale for the specified monitor.
		public static void GetMonitorContentScale(GlfwMonitor* monitor, ref float xScale, ref float yScale) => glfwGetMonitorContentScale(monitor, &xScale, &yScale);

		[CLink]
		private static extern c_char* glfwGetMonitorName(GlfwMonitor* monitor);
		/// Returns the name of the specified monitor.
		public  static void GetMonitorName(GlfwMonitor* monitor, String buffer) {
			c_char* name = glfwGetMonitorName(monitor);
			buffer.Append(name);
		}

		[LinkName("glfwSetMonitorUserPointer")]
		/// Sets the user pointer of the specified monitor.
		public static extern void SetMonitorUserPointer(GlfwMonitor* monitor, void* ptr);

		[LinkName("glfwGetMonitorUserPointer")]
		/// Returns the user pointer of the specified monitor.
		public static extern void* GetMonitorUserPointer(GlfwMonitor* monitor);

		[CLink]
		private static extern RawMonitorCallback glfwSetMonitorCallback(RawMonitorCallback callback);
		/// Sets the monitor configuration callback.
		public static MonitorCallback SetMonitorCallback(MonitorCallback callback, bool deletePrevCallback = true) {
			MonitorCallback prevCallback = monitorCallback;

			if (monitorCallback != null && deletePrevCallback) delete monitorCallback;
			monitorCallback = callback;

			if (callback != null) glfwSetMonitorCallback((monitor, event) => monitorCallback(monitor, (GlfwMonitor.Event) event));
			else {
				glfwSetMonitorCallback((monitor, event) => {});
				monitorCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern GlfwVideoMode* glfwGetVideoModes(GlfwMonitor* monitor, c_intptr* count);
		/// Returns the available video modes for the specified monitor.
		public static GlfwVideoMode* GetVideoModes(GlfwMonitor* monitor, ref int count) => glfwGetVideoModes(monitor, &count);

		[LinkName("glfwGetVideoMode")]
		/// Returns the current mode of the specified monitor.
		public static extern GlfwVideoMode* GetVideoMode(GlfwMonitor* monitor);

		[LinkName("glfwSetGamma")]
		/// Generates a gamma ramp and sets it for the specified monitor.
		public static extern void SetGamma(GlfwMonitor* monitor, float gamma);

		[LinkName("glfwGetGammaRamp")]
		/// Returns the current gamma ramp for the specified monitor.
		public static extern GlfwGammaRamp* GetGammaRamp(GlfwMonitor* monitor);

		[LinkName("glfwSetGammRamp")]
		/// Sets the current gamma ramp for the specified monitor.
		public static extern void SetGammRamp(GlfwMonitor* monitor, GlfwGammaRamp* gammaRamp);
	}
}
