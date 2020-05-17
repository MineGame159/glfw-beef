using System;

namespace glfw_beef {
	class Glfw {
		// Constants

		public const int DONT_CARE = -1;
		public const int TRUE = 1;
		public const int FALSE = 0;

		// Enums

		public enum ClientApi {
			OpenGlApi = 0x00030001,
			OpenGlEsApi = 0x00030002,
			NoApi = 0
		}

		public enum ContextCreationApi {
			NativeApi = 0x00036001,
			EglApi = 0x00036002,
			OsmesaApi = 0x00036003
		}

		public enum OpenGlProfile {
			CoreProfile = 0x00032001,
			CompatProfile = 0x00032002,
			AnyProfile = 0
		}

		public enum ContextRobustness {
			NoResetNotification = 0x00031001,
			LoseContextOnReset = 0x00031002,
			NoRobustness = 0
		}

		public enum ContextReleaseBehavior {
			Any = 0,
			Flush = 0x00035001,
			None = 0x00035002
		}

		public enum Error {
			NoError = 0,
			NotInitialized = 0x00010001,
			NoCurrentContext = 0x00010002,
			InvalidEnum = 0x00010003,
			InvalidValue = 0x00010004,
			OutOfMemory = 0x00010005,
			ApiUnavailable = 0x00010006,
			VersionUnavailable = 0x00010007,
			PlatformError = 0x00010008,
			FormatUnavailable = 0x00010009,
			NoWindowContext = 0x0001000A
		}

		public enum InitHint {
			JoystickHatButtons = 0x00050001,
			CocoaChdirResources = 0x00051001,
			CocoaMenuBar = 0x00051002
		}

		// Callbacks

		private function void RawErrorCallback(int error, char8** description);
		public delegate void ErrorCallback(Error error);
		private static ErrorCallback errorCallback ~ delete _;

		private function void RawWindowPosCallback(GlfwWindow* window, int x, int y);
		public delegate void WindowPosCallback(GlfwWindow* window, int x, int y);
		private static WindowPosCallback windowPosCallback ~ delete _;

		private function void RawWindowSizeCallback(GlfwWindow* window, int width, int height);
		public delegate void WindowSizeCallback(GlfwWindow* window, int width, int height);
		private static WindowSizeCallback windowSizeCallback ~ delete _;

		private function void RawWindowCloseCallback(GlfwWindow* window);
		public delegate void WindowCloseCallback(GlfwWindow* window);
		private static WindowCloseCallback windowCloseCallback ~ delete _;

		private function void RawWindowRefreshCallback(GlfwWindow* window);
		public delegate void WindowRefreshCallback(GlfwWindow* window);
		private static WindowRefreshCallback windowRefreshCallback ~ delete _;

		private function void RawWindowFocusCallback(GlfwWindow* window, int focus);
		public delegate void WindowFocusCallback(GlfwWindow* window, bool focus);
		private static  WindowFocusCallback windowFocusCallback ~ delete _;

		private function void RawWindowIconifyCallback(GlfwWindow* window, int iconify);
		public delegate void WindowIconifyCallback(GlfwWindow* window, bool iconify);
		private static WindowIconifyCallback windowIconifyCallback ~ delete _;

		private function void RawWindowMaximizeCallback(GlfwWindow* window, int maximize);
		public delegate void WindowMaximizeCallback(GlfwWindow* window, bool maximize);
		private static WindowMaximizeCallback windowMaximizeCallback ~ delete _;

		private function void RawFramebufferSizeCallback(GlfwWindow* window, int width, int height);
		public delegate void FramebufferSizeCallback(GlfwWindow* window, int width, int height);
		private static FramebufferSizeCallback framebufferSizeCallback ~ delete _;

		private function void RawWindowContentsScaleCallback(GlfwWindow* window, int xScale, int yScale);
		public delegate void WindowContentsScaleCallback(GlfwWindow* window, int xScale, int yScale);
		private static WindowContentsScaleCallback windowContentsScaleCallback ~ delete _;

		private function void RawMonitorCallback(GlfwMonitor* monitor, int event);
		public delegate void MonitorCallback(GlfwMonitor* monitor, GlfwMonitor.Event event);
		private static MonitorCallback monitorCallback ~ delete _;

		private function void RawKeyCallback(GlfwWindow* monitor, int key, int scancode, int action, int mods);
		public delegate void KeyCallback(GlfwWindow* window, GlfwInput.Key key, int scancode, GlfwInput.Action action, int mods);
		private static KeyCallback keyCallback ~ delete _;

		private function void RawCharCallback(GlfwWindow* window, uint char);
		public delegate void CharCallback(GlfwWindow* window, uint char);
		private static CharCallback charCallback ~ delete _;

		private function void RawCharModsCallback(GlfwWindow* window, uint char, int mods);
		public delegate void CharModsCallback(GlfwWindow* window, uint char, int mods);
		private static CharModsCallback charModsCallback ~ delete _;

		private function void RawMouseButtonCallback(GlfwWindow* window, int button, int action, int mods);
		public delegate void MouseButtonCallback(GlfwWindow* window, GlfwInput.MouseButton button, GlfwInput.Action action, int mods);
		private static MouseButtonCallback mouseButtonCallback ~ delete _;

		private function void RawCursorPosCallback(GlfwWindow* window, double x, double y);
		public delegate void CursorPosCallback(GlfwWindow* window, double x, double y);
		private static CursorPosCallback cursorPosCallback ~ delete _;

		private function void RawCursorEnterCallback(GlfwWindow* window, int entered);
		public delegate void CursorEnterCallback(GlfwWindow* window, bool entered);
		private static CursorEnterCallback cursorEnterCallback ~ delete _;

		private function void RawScrollCallback(GlfwWindow* window, double xOffset, double yOffset);
		public delegate void ScrollCallback(GlfwWindow* window, double xOffset, double yOffset);
		private static ScrollCallback scrollCallback ~ delete _;

		private function void RawDropCallback(GlfwWindow* window, int count, char8*[] paths);
		public delegate void DropCallback(GlfwWindow* window, int count, char8*[] paths);
		private static DropCallback dropCallback ~ delete _;

		private function void RawJoystickCallback(int id, int event);
		public delegate void JoystickCallback(int id, GlfwInput.JoystickEvent event);
		private static JoystickCallback joystickCallback ~ delete _;

		// Initialization, version and error reference
		
		[CLink]
		private static extern int glfwInit();
		public static bool Init() {
			return glfwInit() == 1;
		}

		[CLink]
		private static extern void glfwTerminate();
		public static void Terminate() {
			glfwTerminate();
		}

		[CLink]
		private static extern void glfwInitHint(int hint, int value);
		public static void InitHint(InitHint hint, bool value) {
			glfwInitHint(hint.Underlying, value == true ? TRUE : FALSE);
		}

		[CLink]
		private static extern void glfwGetVersion(int* major, int* minor, int* rev);
		public static void GetVersion(ref int major, ref int minor, ref int rev) {
			glfwGetVersion(&major, &minor, &rev);
		}

		[CLink]
		private static extern char8* glfwGetVersionString();
		public static void GetVersionString(String buffer) {
			buffer.Append(glfwGetVersionString());
		}

		[CLink]
		private static extern int glfwGetError(char8** description6);
		public static Error GetError(String buffer) {
			char8* chars = scope .;
			int err = glfwGetError(&chars);

			if (chars != null) buffer.Append(chars);
			return (Error) err;
		}

		[CLink]
		private static extern RawErrorCallback glfwSetErrorCallback(RawErrorCallback callback);
		public static void SetErrorCallback(ErrorCallback callback) {
			if (errorCallback != null) delete errorCallback;
			errorCallback = callback;

			if (callback != null) glfwSetErrorCallback((error, description) => errorCallback((Error) error));
	 		else glfwSetErrorCallback((error, description) => {});
		}

		// Window reference

		[CLink]
		private static extern void glfwDefaultWindowHints();
		public static void DefaultWindowHints() {
			glfwDefaultWindowHints();
		}

		[CLink]
		private static extern void glfwWindowHint(int hint, int value);
		public static void WindowHint(GlfwWindow.Hint hint, int value) {
			glfwWindowHint(hint.Underlying, value);
		}
		public static void WindowHint(GlfwWindow.Hint hint, bool value) {
			glfwWindowHint(hint.Underlying, value == true ? TRUE : FALSE);
		}
		public static void WindowHint(GlfwWindow.Hint hint, ClientApi api) {
			glfwWindowHint(hint.Underlying, api.Underlying);
		}
		public static void WindowHint(GlfwWindow.Hint hint, OpenGlProfile profile) {
			glfwWindowHint(hint.Underlying, profile.Underlying);
		}
		public static void WindowHint(GlfwWindow.Hint hint, ContextRobustness robustness) {
			glfwWindowHint(hint.Underlying, robustness.Underlying);
		}
		public static void WindowHint(GlfwWindow.Hint hint, ContextReleaseBehavior behavior) {
			glfwWindowHint(hint.Underlying, behavior.Underlying);
		}

		[CLink]
		private static extern void glfwWindowHintString(int hint, char8* value);
		public static void WindowHintString(GlfwWindow.Hint hint, StringView value) {
			glfwWindowHintString(hint.Underlying, value.ToScopeCStr!());
		}

		[CLink]
		private static extern GlfwWindow* glfwCreateWindow(int width, int height, char8* title, GlfwMonitor* monitor, GlfwWindow* share);
		public static GlfwWindow* CreateWindow(int width, int height, StringView title, GlfwMonitor* monitor, GlfwWindow* share) {
			return glfwCreateWindow(width, height, title.ToScopeCStr!(), monitor, share);					   
		}

		[CLink]
		private static extern void glfwDestroyWindow(GlfwWindow* window);
		public static void DestroyWindow(GlfwWindow* window) {
			glfwDestroyWindow(window);
		}

		[CLink]
		private static extern int glfwWindowShouldClose(GlfwWindow* window);
		public static bool WindowShouldClose(GlfwWindow* window) {
			return glfwWindowShouldClose(window) == 1;
		}

		[CLink]
		private static extern void glfwSetWindowShouldClose(GlfwWindow* window, int value);
		public static void SetWindowShouldClose(GlfwWindow* window, bool value) {
			glfwSetWindowShouldClose(window, value == true ? TRUE : FALSE);
		}

		[CLink]
		private static extern void glfwSetWindowTitle(GlfwWindow* window, char8* title);
		public static void SetWindowTitle(GlfwWindow* window, StringView title) {
			glfwSetWindowTitle(window, title.ToScopeCStr!());
		}

		[CLink]
		private static extern void glfwSetWindowIcon(GlfwWindow* window, int count, GlfwImage* images);
		public static void SetWindowIcon(GlfwWindow* window, int count, GlfwImage* images) {
			glfwSetWindowIcon(window, count, images);
		}

		[CLink]
		private static extern void glfwGetWindowPos(GlfwWindow* window, int* x, int* y);
		public static void GetWindowPos(GlfwWindow* window, ref int x, ref int y) {
			glfwGetWindowPos(window, &x, &y);
		}

		[CLink]
		private static extern void glfwSetWindowPos(GlfwWindow* window, int x, int y);
		public static void SetWindowPos(GlfwWindow* window, int x, int y) {
			glfwSetWindowPos(window, x, y);
		}

		[CLink]
		private static extern void glfwGetWindowSize(GlfwWindow* window, int* width, int* height);
		public static void GetWindowSize(GlfwWindow* window, ref int width, ref int height) {
			glfwGetWindowSize(window, &width, &height);
		}

		[CLink]
		private static extern void glfwSetWindowSizeLimits(GlfwWindow* window, int minWidth, int minHeight, int maxWidth, int maxHeight);
		public static void SetWindowSizeLimits(GlfwWindow* window, int minWidth, int minHeight, int maxWidth, int maxHeight) {
			glfwSetWindowSizeLimits(window, minWidth, minHeight, maxWidth, maxHeight);
		}

		[CLink]
		private static extern void glfwSetWindowAspectRation(GlfwWindow* window, int numer, int denom);
		public static void SetWindowAspectRation(GlfwWindow* window, int numer, int denom) {
			glfwSetWindowAspectRation(window, numer, denom);
		}

		[CLink]
		private static extern void glfwSetWindowSize(GlfwWindow* window, int width, int height);
		public static void SetWindowSize(GlfwWindow* window, int width, int height) {
			glfwSetWindowSize(window, width, height);
		}

		[CLink]
		private static extern void glfwGetFramebufferSize(GlfwWindow* window, int* width, int* height);
		public static void GetFramebufferSIze(GlfwWindow* window, ref int width, ref int height) {
			glfwGetFramebufferSize(window, &width, &height);
		}

		[CLink]
		private static extern void glfwGetWindowFrameSize(GlfwWindow* window, int* top, int* left, int* right, int* bottom);
		public static void GetWindowSize(GlfwWindow* window, ref int top, ref int left, ref int  right, ref int bottom) {
			glfwGetWindowFrameSize(window, &top, &left, &right, &bottom);
		}

		[CLink]
		private static extern void glfwGetWindowContentScale(GlfwWindow* window, float* xScale, float* yScale);
		public static void GetWindowContentScale(GlfwWindow* window, ref float xScale, ref float yScale) {
			glfwGetWindowContentScale(window, &xScale, &yScale);
		}

		[CLink]
		private static extern float glfwGetWindowOpacity(GlfwWindow* window);
		public static float GetWindowOpacity(GlfwWindow* window) {
			return glfwGetWindowOpacity(window);
		}

		[CLink]
		private static extern void glfwSetWindowOpacity(GlfwWindow* window, float opacity);
		public static  void SetWindowOpacity(GlfwWindow* window, float opacity) {
			glfwSetWindowOpacity(window, opacity);
		}

		[CLink]
		private static extern void glfwIconifyWindow(GlfwWindow* window);
		public static void IconifyWindow(GlfwWindow* window) {
			glfwIconifyWindow(window);
		}

		[CLink]
		private static extern void glfwRestoreWindow(GlfwWindow* window);
		public static void RestoreWindow(GlfwWindow* window) {
			glfwRestoreWindow(window);
		}

		[CLink]
		private static extern void glfwMaximizeWindow(GlfwWindow* window);
		public static void MaximizeWindow(GlfwWindow* window) {
			glfwMaximizeWindow(window);
		}

		[CLink]
		private static extern void glfwShowWindow(GlfwWindow* window);
		public static void ShowWindow(GlfwWindow* window) {
			glfwShowWindow(window);
		}

		[CLink]
		private static extern void glfwHideWindow(GlfwWindow* window);
		public static void HideWindow(GlfwWindow* window) {
			glfwHideWindow(window);
		}

		[CLink]
		private static extern void glfwFocusWindow(GlfwWindow* window);
		public static void FocusWindow(GlfwWindow* window) {
			glfwFocusWindow(window);
		}

		[CLink]
		private static extern void glfwRequestWindowAttention(GlfwWindow* window);
		public static void RequestWindowAttention(GlfwWindow* window) {
			glfwRequestWindowAttention(window);
		}

		[CLink]
		private static extern GlfwMonitor* glfwGetWindowMonitor(GlfwWindow* window);
		public static GlfwMonitor* GetWindowMonitor(GlfwWindow* window) {
			return glfwGetWindowMonitor(window);
		}

		[CLink]
		private static extern void glfwSetWindowMonitor(GlfwWindow* window, GlfwMonitor* monitor, int x, int y, int width, int height, int refreshRate);
		public static void SetWindowMonitor(GlfwWindow* window, GlfwMonitor* monitor, int x, int y, int width, int height, int refreshRate) {
			glfwSetWindowMonitor(window, monitor, x, y, width, height, refreshRate);
		}

		[CLink]
		private static extern int glfwGetWindowAttrib(GlfwWindow* window, int attrib);
		public static int GetWindowAttrib(GlfwWindow* window, GlfwWindow.Attrib attrib) {
			return glfwGetWindowAttrib(window, attrib.Underlying);
		}

		[CLink]
		private static extern void glfwSetWindowAttrib(GlfwWindow* window, int attrib, int value);
		public static void glfwSetWindowAttrib(GlfwWindow* window, GlfwWindow.Attrib attrib, int value) {
			glfwSetWindowAttrib(window, attrib.Underlying, value);
		}
		public static void glfwSetWindowAttrib(GlfwWindow* window, GlfwWindow.Attrib attrib, bool value) {
			glfwSetWindowAttrib(window, attrib.Underlying, value == true ? TRUE : FALSE);
		}

		[CLink]
		private static extern void glfwSetWindowUserPointer(GlfwWindow* window, void* ptr);
		public static  void SetWindowUserPointer(GlfwWindow* window, void* ptr) {
			glfwSetWindowUserPointer(window, ptr);
		}

		[CLink]
		private static extern void* glfwGetWindowUserPointer(GlfwWindow* window);
		public static void* GetWindowUserPointer(GlfwWindow* window) {
			return glfwGetWindowUserPointer(window);
		}

		[CLink]
		private static extern RawWindowPosCallback glfwSetWindowPosCallback(RawWindowPosCallback callback);
		public static void SetWindowPosCallback(WindowPosCallback callback) {
			if (windowPosCallback != null) delete windowPosCallback;
			windowPosCallback = callback;

			if (callback != null) glfwSetWindowPosCallback((window, x, y) => windowPosCallback(window, x, y));
			else glfwSetWindowPosCallback((window, x, y) => {});
		}

		[CLink]
		private static extern RawWindowSizeCallback glfwSetWindowSizeCallback(GlfwWindow* window, RawWindowSizeCallback callback);
		public static void SetWindowSizeCallback(GlfwWindow* window, WindowSizeCallback calllback) {
			if (windowSizeCallback != null) delete windowSizeCallback;
			windowSizeCallback = calllback;

			if (calllback != null) glfwSetWindowSizeCallback(window, (window, width, height) => windowSizeCallback(window, width, height));
			else glfwSetWindowSizeCallback(window, (window, width, height) => {});
		}

		[CLink]
		private static extern RawWindowCloseCallback glfwSetWindowCloseCallback(RawWindowCloseCallback callback);
		public static void SetWindowCloseCallback(WindowCloseCallback callback) {
			if (windowCloseCallback != null) delete windowCloseCallback;
			windowCloseCallback = callback;

			if (callback != null) glfwSetWindowCloseCallback((window) => windowCloseCallback(window));
			else glfwSetWindowCloseCallback((window) => {});
		}

		[CLink]
		private static extern RawWindowRefreshCallback glfwSetWindowRefreshCallback(RawWindowRefreshCallback callback);
		public static void SetWindowRefreshCallback(WindowRefreshCallback callback) {
			if (windowRefreshCallback != null) delete windowRefreshCallback;
			windowRefreshCallback = callback;

			if (callback != null) glfwSetWindowRefreshCallback((window) => windowRefreshCallback(window));
			else glfwSetWindowRefreshCallback((window) => {});
		}

		[CLink]
		private static extern RawWindowFocusCallback glfwSetWindowFocusCallback(RawWindowFocusCallback callback);
		public static void SetWindowFocusCallback(WindowFocusCallback callback) {
			if (windowFocusCallback != null) delete windowFocusCallback;
			windowFocusCallback = callback;

			if (callback != null) glfwSetWindowFocusCallback((window, focus) => windowFocusCallback(window, focus == TRUE));
			else glfwSetWindowFocusCallback((window, focus) => {});
		}

		[CLink]
		private static extern RawWindowIconifyCallback glfwSetWindowIconifyCallback(RawWindowIconifyCallback callback);
		public static void SetWindowIconifyCallback(WindowIconifyCallback callback) {
			if (windowIconifyCallback != null) delete windowIconifyCallback;
			windowIconifyCallback = callback;

			if (callback != null) glfwSetWindowIconifyCallback((window, iconify) => windowIconifyCallback(window, iconify == TRUE));
			else glfwSetWindowIconifyCallback((window, iconify) => {});
		}

		[CLink]
		private static extern RawWindowMaximizeCallback glfwSetWindowMaximizeCallback(RawWindowMaximizeCallback callback);
		public static void SetWindowMaximizeCallback(WindowMaximizeCallback callback) {
			if (windowMaximizeCallback != null) delete windowMaximizeCallback;
			windowMaximizeCallback = callback;

			if (callback != null) glfwSetWindowMaximizeCallback((window, maximize) => windowMaximizeCallback(window, maximize == TRUE));
			else glfwSetWindowMaximizeCallback((window, maximize) => {});
		}

		[CLink]
		private static extern RawFramebufferSizeCallback glfwSetFramebufferSizeCallback(GlfwWindow* window, RawFramebufferSizeCallback callback);
		public static void SetFramebufferSizeCallback(GlfwWindow* window, FramebufferSizeCallback callback) {
			if (framebufferSizeCallback != null) delete framebufferSizeCallback;
			framebufferSizeCallback = callback;

			if (callback != null) glfwSetFramebufferSizeCallback(window, (window, width, height) => framebufferSizeCallback(window, width, height));
			else glfwSetFramebufferSizeCallback(window, (window, width, height) => {});
		}

		[CLink]
		private static extern RawWindowContentsScaleCallback glfwSetWindowContentScaleCallback(RawWindowContentsScaleCallback callback);
		public static void SetWindowContentScaleCallback(WindowContentsScaleCallback callback) {
			if (windowContentsScaleCallback != null) delete windowContentsScaleCallback;
			windowContentsScaleCallback = callback;

			if (callback != null) glfwSetWindowContentScaleCallback((window, xScale, yScale) => windowContentsScaleCallback(window, xScale, yScale));
			else glfwSetWindowContentScaleCallback((window, xScale, yScale) => {});
		}

		[CLink]
		private static extern void glfwPollEvents();
		public static void PollEvents() {
			glfwPollEvents();
		}

		[CLink]
		private static extern void glfwWaitEvents();
		public static void WaitEvents() {
			glfwWaitEvents();
		}

		[CLink]
		private static extern void glfwWaitEventsTimeout(double timeout);
		public static void WaitEventsTimeout(double timeout) {
			glfwWaitEventsTimeout(timeout);
		}

		[CLink]
		private static extern void glfwPostEmptyEvent();
		public static void PostEmptyEvent() {
			glfwPostEmptyEvent();
		}

		[CLink]
		private static extern void glfwSwapBuffers(GlfwWindow* window);
		public static void SwapBuffers(GlfwWindow* window) {
			glfwSwapBuffers(window);
		}

		// Context reference

		[CLink]
		private static extern void glfwMakeContextCurrent(GlfwWindow* window);
		public static void MakeContextCurrent(GlfwWindow* window) {
			glfwMakeContextCurrent(window);
		}

		[CLink]
		private static extern GlfwWindow* glfwGetCurrentContext();
		public static GlfwWindow* GetCurrentContext() {
			return glfwGetCurrentContext();
		}

		[CLink]
		private static extern void glfwSwapInterval(int interval);
		public static void SwapInterval(int interval) {
			glfwSwapInterval(interval);
		}

		[CLink]
		private static extern int glfwExtensionSupported(char8* extensionName);
		public static bool ExtensionSupported(StringView extensionName) {
			return glfwExtensionSupported(extensionName.ToScopeCStr!()) == TRUE;
		}

		[CLink]
		private static extern void* glfwGetProcAddress(char8* procname);
		public static void* GetProcAddress(StringView procname) {
			return glfwGetProcAddress(procname.ToScopeCStr!());
		}

		// Vulkan reference

		[CLink]
		private static extern int glfwVulkanSupported();
		public static int VulkanSupported() {
			return glfwVulkanSupported();
		}

		[CLink]
		private static extern char8* glfwGetRequiredInstanceExtensions(uint32* count);
		public static void GetRequiredInstanceExtensions(ref int count, String buffer) {
			char8* chars = glfwGetRequiredInstanceExtensions((uint32*) &count);
			buffer.Append(chars);
		}

		[CLink]
		private static extern void* glfwGetInstanceProcAddress(void* instance, char8* procname);
		public static void* GetInstanceProcAddress(void* instance, StringView procname) {
			return glfwGetInstanceProcAddress(instance, procname.ToScopeCStr!());
		}

		[CLink]
		private static extern int glfwGetPhysicalDevicePresentationSupport(void* instance, void* ddvice, uint32 queueFamily);
		public static int GetPhysicalDevicePresentationSupport(void* instance, void* device, uint32 queueFamily) {
			return glfwGetPhysicalDevicePresentationSupport(instance, device, queueFamily);
		}

		[CLink]
		private static extern void* glfwCreateWindowSurface(void* instance, GlfwWindow* window, void* allocator, void* surface);
		public static void* CreateWindowSurface(void* instance, GlfwWindow* window, void* allocator, void* surface) {
			return glfwCreateWindowSurface(instance, window, allocator, surface);
		}

		// Monitor reference

		[CLink]
		private static extern GlfwMonitor** glfwGetMonitors(int* count);
		public static GlfwMonitor** GetMonitors(ref int count) {
			return glfwGetMonitors(&count);
		}

		[CLink]
		private static extern GlfwMonitor* glfwGetPrimaryMonitor();
		public static GlfwMonitor* GetPrimaryMonitor() {
			return glfwGetPrimaryMonitor();
		}

		[CLink]
		private static extern void glfwGetMonitorPos(GlfwMonitor* monitor, int* x, int* y);
		public static void GetMonitorPos(GlfwMonitor* monitor, ref int x, ref int y) {
			glfwGetMonitorPos(monitor, &x, &y);
		}

		[CLink]
		private static extern void glfwGetMonitorWorkarea(GlfwMonitor* monitor, int* x, int* y, int* width, int* height);
		public static void GetMonitorWorkarea(GlfwMonitor* monitor, ref int x, ref int y, ref int width, ref int height) {
			glfwGetMonitorWorkarea(monitor, &x, &y, &width, &height);
		}

		[CLink]
		private static extern void glfwGetMonitorPhysicalSize(GlfwMonitor* monitor, int* width, int* height);
		public static void GetMonitorPhysicalSize(GlfwMonitor* monitor, ref int width, ref int height) {
			glfwGetMonitorPhysicalSize(monitor, &width, &height);
		}

		[CLink]
		private static extern void glfwGetMonitorContentScale(GlfwMonitor* monitor, float* xScale, float* yScale);
		public static void GetMonitorContentScale(GlfwMonitor* monitor, ref float xScale, ref float yScale) {
			glfwGetMonitorContentScale(monitor, &xScale, &yScale);
		}

		[CLink]
		private static extern char8* glfwGetMonitorName(GlfwMonitor* monitor);
		public  static void GetMonitorName(GlfwMonitor* monitor, String buffer) {
			char8* name = glfwGetMonitorName(monitor);
			buffer.Append(name);
		}

		[CLink]
		private static extern void glfwSetMonitorUserPointer(GlfwMonitor* monitor, void* ptr);
		public static void SetMonitorUserPointer(GlfwMonitor* monitor, void* ptr) {
			glfwSetMonitorUserPointer(monitor, ptr);
		}

		[CLink]
		private static extern void* glfwGetMonitorUserPointer(GlfwMonitor* monitor);
		public static void* GetMonitorUserPointer(GlfwMonitor* monitor) {
			return glfwGetMonitorUserPointer(monitor);
		}

		[CLink]
		private static extern RawMonitorCallback glfwSetMonitorCallback(RawMonitorCallback callback);
		public static void SetMonitorCallback(MonitorCallback callback) {
			if (monitorCallback != null) delete monitorCallback;
			monitorCallback = callback;

			if (callback != null) glfwSetMonitorCallback((monitor, event) => monitorCallback(monitor, (GlfwMonitor.Event) event));
			else glfwSetMonitorCallback((monitor, event) => {});
		}

		[CLink]
		private static extern GlfwVidMode* glfwGetVideoModes(GlfwMonitor* monitor, int* count);
		public static GlfwVidMode* GetVideoModes(GlfwMonitor* monitor, ref int count) {
			return glfwGetVideoModes(monitor, &count);
		}

		[CLink]
		private static extern GlfwVidMode* glfwGetVideoMode(GlfwMonitor* monitor);
		public static GlfwVidMode* GetVideoMode(GlfwMonitor* monitor) {
			return glfwGetVideoMode(monitor);
		}

		[CLink]
		private static extern GlfwGammaRamp* glfwGetGammaRamp(GlfwMonitor* monitor);
		public static GlfwGammaRamp* GetGammaRamp(GlfwMonitor* monitor) {
			return glfwGetGammaRamp(monitor);
		}

		[CLink]
		private static extern void glfwSetGammRamp(GlfwMonitor* monitor, GlfwGammaRamp* gammaRamp);
		public static void SetGammaRamp(GlfwMonitor* monitor, GlfwGammaRamp* gammaRamp) {
			glfwSetGammRamp(monitor, gammaRamp);
		}

		// Input reference

		[CLink]
		private static extern int glfwGetInputMode(GlfwWindow* window, int mode);
		public static int GetInputMode(GlfwWindow* window, GlfwInput.InputMode mode) {
			return glfwGetInputMode(window, mode.Underlying);
		}

		[CLink]
		private static extern void glfwSetInputMode(GlfwWindow* window, int mode, int value);
		public static void SetInputMode(GlfwWindow* window, GlfwInput.InputMode mode, int value) {
			glfwSetInputMode(window, mode.Underlying, value);
		}

		[CLink]
		private static extern int glfwRawMouseMotionSupported();
		public static bool RawMouseMotionSupported() {
			return glfwRawMouseMotionSupported() == TRUE;
		}

		[CLink]
		private static extern char8* glfwGetKeyName(int key, int scancode);
		public static void GetKeyName(GlfwInput.Key key, int scancode, String buffer) {
			char8* chars = glfwGetKeyName(key.Underlying, scancode);
			buffer.Append(chars);
		}

		[CLink]
		private static extern int glfwGetKeyScancode(int key);
		public static int GetKeyScancode(GlfwInput.Key key) {
			return glfwGetKeyScancode(key.Underlying);
		}

		[CLink]
		private static extern int glfwGetKey(GlfwWindow* window, int key);
		public static GlfwInput.Action GetKey(GlfwWindow* window, GlfwInput.Key key) {
			return (.) glfwGetKey(window, key.Underlying);
		}

		[CLink]
		private static extern int glfwGetMouseButton(GlfwWindow* window, int button);
		public static GlfwInput.Action GetMouseButton(GlfwWindow* window, GlfwInput.MouseButton button) {
			return (.) glfwGetMouseButton(window, button.Underlying);
		}

		[CLink]
		private static extern void glfwGetCursorPos(GlfwWindow* window, double* x, double* y);
		public static void GetCursorPos(GlfwWindow* window, ref double x, ref double y) {
			glfwGetCursorPos(window, &x, &y);
		}

		[CLink]
		private static extern void glfwSetCursorPos(GlfwWindow* window, double x, double y);
		public static void SetCursorPos(GlfwWindow* window, double x, double y) {
			glfwSetCursorPos(window, x, y);
		}

		[CLink]
		private static extern GlfwCursor* glfwCreateCursor(GlfwImage* image, int xHot, int yHot);
		public static GlfwCursor* CreateCursor(GlfwImage* image, int xHot, int yHot) {
			return glfwCreateCursor(image, xHot, yHot);
		}

		[CLink]
		private static extern GlfwCursor* glfwCreateStandardCursor(int shape);
		public static GlfwCursor* CreateStandardCursor(GlfwInput.CursorShape shape) {
			return glfwCreateStandardCursor(shape.Underlying);
		}

		[CLink]
		private static extern void glfwDestroyCursor(GlfwCursor* cursor);
		public static void DestroyCursor(GlfwCursor* cursor) {
			glfwDestroyCursor(cursor);
		}

		[CLink]
		private static extern void glfwSetCursor(GlfwWindow* window, GlfwCursor* cursor);
		public static void SetCursor(GlfwWindow* window, GlfwCursor* cursor) {
			glfwSetCursor(window, cursor); 
		}

		[CLink]
		private static extern RawKeyCallback glfwSetKeyCallback(GlfwWindow* window, RawKeyCallback callback);
		public static void SetKeyCallback(GlfwWindow* window, KeyCallback callback) {
			if (keyCallback != null) delete keyCallback;
			keyCallback = callback;

			if (callback != null) glfwSetKeyCallback(window, (window, key, scancode, action, mods) => keyCallback(window, (GlfwInput.Key) key, scancode, (GlfwInput.Action) action, mods));
			else glfwSetKeyCallback(window, (window, key, scancode, action, mods) => {});
		}

		[CLink]
		private static extern RawCharCallback glfwSetCharCallback(GlfwWindow* window, RawCharCallback callback);
		public static void SetCharCallback(GlfwWindow* window, CharCallback callback) {
			if (charCallback != null) delete charCallback;
			charCallback = callback;

			if (callback != null) glfwSetCharCallback(window, (window, char) => charCallback(window, char));
			else glfwSetCharCallback(window, (window, char) => {});
		}

		[CLink]
		private static extern RawCharModsCallback glfwSetCharModsCallback(GlfwWindow* window, RawCharModsCallback callback);
		public static void SetCharModsCallback(GlfwWindow* window, CharModsCallback callback) {
			if (charModsCallback != null) delete charModsCallback;
			charModsCallback = callback;

			if (callback != null) glfwSetCharModsCallback(window, (window, char, mods) => charModsCallback(window, char, mods));
			else glfwSetCharModsCallback(window, (window, char, mods) => {});
		}

		[CLink]
		private static extern RawMouseButtonCallback glfwSetMouseButtonCallback(GlfwWindow* window, RawMouseButtonCallback callback);
		public static void SetMouseButtonCallback(GlfwWindow* window, MouseButtonCallback callback) {
			if (mouseButtonCallback != null) delete mouseButtonCallback;
			mouseButtonCallback = callback;

			if (callback != null) glfwSetMouseButtonCallback(window, (window, button, action, mods) => mouseButtonCallback(window, (GlfwInput.MouseButton) button, (GlfwInput.Action) action, mods));
			else glfwSetMouseButtonCallback(window, (window, button, action, mods) => {});
		}

		[CLink]
		private static extern RawCursorPosCallback glfwSetCursorPosCallback(GlfwWindow* window, RawCursorPosCallback callback);
		public static void SetCursorPosCallback(GlfwWindow* window, CursorPosCallback callback) {
			if (cursorPosCallback != null) delete cursorPosCallback;
			cursorPosCallback = callback;

			if (callback != null) glfwSetCursorPosCallback(window, (window, x, y) => cursorPosCallback(window, x, y));
			else glfwSetCursorPosCallback(window, (window, x, y) => {});
		}

		[CLink]
		private static extern RawCursorEnterCallback glfwSetCursorEnterCallback(GlfwWindow* window, RawCursorEnterCallback callback);
		public static void SetCursorEnterCallback(GlfwWindow* window, CursorEnterCallback callback) {
			if (cursorEnterCallback != null) delete cursorEnterCallback;
			cursorEnterCallback = callback;

			if (callback != null) glfwSetCursorEnterCallback(window, (window, entered) => cursorEnterCallback(window, entered == TRUE));
			else glfwSetCursorEnterCallback(window, (window, entered) => {});
		}

		[CLink]
		private static extern RawScrollCallback glfwSetScrollCallback(GlfwWindow* window, RawScrollCallback callback);
		public static void SetScrollCallback(GlfwWindow* window, ScrollCallback callback) {
			if (scrollCallback != null) delete scrollCallback;
			scrollCallback = callback;

			if (callback != null) glfwSetScrollCallback(window, (window, xOffset, yOffset) => scrollCallback(window, xOffset, yOffset));
			else glfwSetScrollCallback(window, (window, xOffset, yOffset) => {});
		}

		[CLink]
		private static extern RawDropCallback glfwSetDropCallback(GlfwWindow* window, RawDropCallback callback);
		public static void SetDropCallback(GlfwWindow* window, DropCallback callback) {
			if (dropCallback != null) delete dropCallback;
			dropCallback = callback;

			if (callback != null) glfwSetDropCallback(window, (window, count, paths) => dropCallback(window, count, paths));
			else glfwSetDropCallback(window, (window, count, paths) => {});
		}

		[CLink]
		private static extern int glfwJoystickPresent(int id);
		public static bool JoystickPresent(int id) {
			return glfwJoystickPresent(id) == TRUE;
		}

		[CLink]
		private static extern float* glfwGetJoystickAxes(int id, int* count);
		public static float* getJoystickAxes(int id, ref int count) {
			return glfwGetJoystickAxes(id, &count);
		}

		[CLink]
		private static extern uint8* glfwGetJoystickButtons(int id, int* count);
		public static GlfwInput.Action* GetJoystickButtons(int id, ref int count) {
			return (.) glfwGetJoystickButtons(id, &count);
		}

		[CLink]
		private static extern uint8* glfwGetJoystickHats(int id, int* count);
		public static GlfwInput.JoystickHatState* GetJoystickHats(int id, ref int count) {
			return (.) glfwGetJoystickHats(id, &count);
		}

		[CLink]
		private static extern char8* glfwGetJoystickName(int id);
		public static void GetJoystickName(int id, String buffer) {
			char8* chars = glfwGetJoystickName(id);
			buffer.Append(chars);
		}

		[CLink]
		private static extern char8* glfwGetJoystickGuid(int id);
		public static  void GetJoystickGuid(int id, String buffer) {
			char8* chars = glfwGetJoystickGuid(id);
			buffer.Append(chars);
		}

		[CLink]
		private static extern void glfwSetJoystickUserPointer(int id, void* ptr);
		public static void SetJoystickUserPointer(int id, void* ptr) {
			glfwSetJoystickUserPointer(id, ptr);
		}

		[CLink]
		private static extern void* glfwGetJoystickUserPointer(int id);
		public static void* GetJoystickUserPointer(int id) {
			return glfwGetJoystickUserPointer(id);
		}

		[CLink]
		private static extern int glfwJoystickIsGamepad(int id);
		public static bool JoystickIsGamepad(int id) {
			return glfwJoystickIsGamepad(id) == TRUE;
		}

		[CLink]
		private static extern RawJoystickCallback glfwSetJoystickCallback(RawJoystickCallback callback);
		public static void SetJoystickCallback(JoystickCallback callback) {
			if (joystickCallback != null) delete joystickCallback;
			joystickCallback = callback;

			if (callback != null) glfwSetJoystickCallback((id, event) => joystickCallback(id, (GlfwInput.JoystickEvent) event));
			else glfwSetJoystickCallback((id, event) => {});
		}

		[CLink]
		private static extern int glfwUpdateGamepadMappings(char8* string);
		public static bool UpdateGamepadMappigns(StringView string) {
			return glfwUpdateGamepadMappings(string.ToScopeCStr!()) == TRUE;
		}

		[CLink]
		private static extern char8* glfwGetGamepadName(int id);
		public static void GetGamepadName(int id, String buffer) {
			char8* chars = glfwGetGamepadName(id);
			buffer.Append(chars);
		}

		[CLink]
		private static extern int glfwGetGamepadState(int id, GlfwGamepadState* state);
		public static bool GetGamepadState(int id, ref GlfwGamepadState state) {
			return glfwGetGamepadState(id, &state) == TRUE;
		}

		[CLink]
		private static extern void glfwSetClipboardString(GlfwWindow* window, char8* string);
		public static void SetClipboardString(GlfwWindow* window, StringView string) {
			glfwSetClipboardString(window, string.ToScopeCStr!());
		}

		[CLink]
		private static extern char8* glfwGetClipboardString(GlfwWindow* window);
		public static void GetClipboardString(GlfwWindow* window, String buffer) {
			char8* chars  = glfwGetClipboardString(window);
			buffer.Append(chars);
		}

		[CLink]
		private static extern double glfwGetTime();
		public static double GetTime() {
			return glfwGetTime();
		}

		[CLink]
		private static extern void glfwSetTime(double time);
		public static void SetTime(double time) {
			glfwSetTime(time);
		}

		[CLink]
		private static extern uint64 glfwGetTimerValue();
		public static uint64 GetTimerValue() {
			return glfwGetTimerValue();
		}

		[CLink]
		private static extern uint64 glfwGetTimerFrequency();
		public static uint64 GetTimeFrequency() {
			return glfwGetTimerFrequency();
		}

		// Native access
		[CLink]
		private static extern Windows.HWnd glfwGetWin32Window(GlfwWindow* window);
		public static Windows.HWnd GetWin32Window(GlfwWindow* window) {
			return glfwGetWin32Window(window);
		}
	}
}
