using System;
using System.Interop;

namespace GLFW {
	extension Glfw {
#if BF_PLATFORM_WINDOWS
		[CRepr]
		public struct HGLRC {}

		[CLink]
		private static extern c_char* glfwGetWin32Adapter(GlfwMonitor* monitor);
		/// Returns the adapter device name of the specified monitor.
		public static void GetWin32Adapter(GlfwMonitor* monitor, String buffer) => buffer.Append(glfwGetWin32Adapter(monitor));

		[CLink]
		private static extern c_char* glfwGetWin32Monitor(GlfwMonitor* monitor);
		/// Returns the display device name of the specified monitor.
		public static void GetWin32Monitor(GlfwMonitor* monitor, String buffer) => buffer.Append(glfwGetWin32Monitor(monitor));

		[LinkName("glfwGetWin32Window")]
		/// Returns the HWND of the specified window.
		public static extern Windows.HWnd* GetWin32Window(GlfwWindow* window);

		[LinkName("glfwGetWGLContext")]
		/// Returns the HGLRC of the specified window.
		public static extern HGLRC GetWGLContext(GlfwWindow* window);
#endif

#if BF_PLATFORM_MACOS
		public typealias CGDirectDisplayID = uint32;
		public typealias NSWindow = uint32;
		public typealias NSOpenGLContext = uint32;

		[LinkName("glfwGetCocoaMonitor")]
		/// Returns the CGDirectDisplayID of the specified monitor.
		public static extern CGDirectDisplayID GetCocoaMonitor(GlfwMonitor* monitor);

		[LinkName("glfwGetCocoaWindow")]
		/// Returns the NSWindow of the specified window.
		public static extern NSWindow GetCocoaWindow(GlfwWindow* window);

		[LinkName("glfwGetNSGLContext")]
		/// Returns the NSOpenGLContext of the specified window.
		public static extern NSOpenGLContext GetNSGLContext(GlfwWindow* window);
#endif

#if BF_PLATFORM_LINUX
		[CRepr]
		public struct XDisplay {}

		public typealias RRCrtc = c_ulong;
		public typealias RROutput = c_ulong;
		public typealias XWindow = c_ulong;

		[CRepr]
		public struct GLXContext {}

		public typealias GLXWindow = c_ulong;

		[LinkName("glfwGetX11Display")]
		/// Returns the Display used by GLFW.
		public static extern XDisplay* GetX11Display();

		[LinkName("glfwGetX11Adapter")]
		/// Returns the RRCrtc of the specified monitor.
		public static extern RRCrtc GetX11Adapter(GlfwMonitor* monitor);

		[LinkName("glfwGetX11Monitor")]
		/// Returns the RROutput of the specified monitor.
		public static extern RROutput GetX11Monitor(GlfwMonitor* monitor);

		[LinkName("glfwGetX11Window")]
		/// Returns the Window of the specified window.
		public static extern XWindow GetX11Window(GlfwWindow* window);

		[CLink]
		private static extern void glfwSetX11SelectionString(c_char* string);
		/// Sets the current primary selection to the specified string.
		public static void SetX11SelectionString(StringView string) => glfwSetX11SelectionString(string.ToScopeCStr!());

		[CLink]
		private static extern c_char* glfwGetX11SelectionString();
		/// Returns the contents of the current primary selection as a string.
		public static void GetX11SelectionString(String buffer) => buffer.Append(glfwGetX11SelectionString());

		[LinkName("glfwGetGLXContext")]
		/// Returns the GLXContext of the specified window.
		public static extern GLXContext GetGLXContext(GlfwWindow* window);

		[LinkName("glfwGetGLXWindow")]
		/// Returns the GLXWindow of the specified window.
		public static extern GLXWindow GetGLXWindow(GlfwWindow* window);
#endif
	}
}
