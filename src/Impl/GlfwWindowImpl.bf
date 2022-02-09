using System;
using System.Interop;

namespace GLFW {
	extension Glfw {
		// Callbacks

		private function void RawWindowPosCallback(GlfwWindow* window, c_int x, c_int y);
		/// The delegate type for window position callbacks.
		public delegate void WindowPosCallback(GlfwWindow* window, int x, int y);
		private static WindowPosCallback windowPosCallback ~ delete _;

		private function void RawWindowSizeCallback(GlfwWindow* window, c_int width, c_int height);
		/// The delegate type for window size callbacks.
		public delegate void WindowSizeCallback(GlfwWindow* window, int width, int height);
		private static WindowSizeCallback windowSizeCallback ~ delete _;

		private function void RawWindowCloseCallback(GlfwWindow* window);
		/// The delegate type for window close callbacks.
		public delegate void WindowCloseCallback(GlfwWindow* window);
		private static WindowCloseCallback windowCloseCallback ~ delete _;

		private function void RawWindowRefreshCallback(GlfwWindow* window);
		/// The delegate type for window content refresh callbacks.
		public delegate void WindowRefreshCallback(GlfwWindow* window);
		private static WindowRefreshCallback windowRefreshCallback ~ delete _;

		private function void RawWindowFocusCallback(GlfwWindow* window, c_int focus);
		/// The delegate type for window focus callbacks.
		public delegate void WindowFocusCallback(GlfwWindow* window, bool focus);
		private static  WindowFocusCallback windowFocusCallback ~ delete _;

		private function void RawWindowIconifyCallback(GlfwWindow* window, c_int iconify);
		/// The delegate type for window iconify callbacks.
		public delegate void WindowIconifyCallback(GlfwWindow* window, bool iconify);
		private static WindowIconifyCallback windowIconifyCallback ~ delete _;

		private function void RawWindowMaximizeCallback(GlfwWindow* window, c_int maximize);
		/// The delegate type for window maximize callbacks.
		public delegate void WindowMaximizeCallback(GlfwWindow* window, bool maximize);
		private static WindowMaximizeCallback windowMaximizeCallback ~ delete _;

		private function void RawFramebufferSizeCallback(GlfwWindow* window, c_int width, c_int height);
		/// The delegate type for framebuffer size callbacks.
		public delegate void FramebufferSizeCallback(GlfwWindow* window, int width, int height);
		private static FramebufferSizeCallback framebufferSizeCallback ~ delete _;

		private function void RawWindowContentsScaleCallback(GlfwWindow* window, float xScale, float yScale);
		/// The delegate type for window content scale callbacks.
		public delegate void WindowContentsScaleCallback(GlfwWindow* window, float xScale, float yScale);
		private static WindowContentsScaleCallback windowContentsScaleCallback ~ delete _;

		// Functions

		[LinkName("glfwDefaultWindowHints")]
		/// Resets all window hints to their default values.
		public static extern void DefaultWindowHints();

		[CLink]
		private static extern void glfwWindowHint(c_int hint, c_int value);
		/// Sets the specified window hint to the desired value.
		public static void WindowHint(GlfwWindow.Hint hint, int value) => glfwWindowHint((.) hint, (.) value);
		/// Sets the specified window hint to the desired value.
		public static void WindowHint(GlfwWindow.Hint hint, bool value) => glfwWindowHint((.) hint, value ? TRUE : FALSE);
		/// Sets the specified window hint to the desired value.
		public static void WindowHint<T>(GlfwWindow.Hint hint, T value) where T : enum => glfwWindowHint((.) hint, (.) value);

		[CLink]
		private static extern void glfwWindowHintString(c_int hint, c_char* value);
		/// Sets the specified window hint to the desired value.
		public static void WindowHintString(GlfwWindow.Hint hint, StringView value) => glfwWindowHintString(hint.Underlying, value.ToScopeCStr!());

		[CLink]
		private static extern GlfwWindow* glfwCreateWindow(c_int width, c_int height, c_char* title, GlfwMonitor* monitor, GlfwWindow* share);
		/// Creates a window and its associated context.
		public static GlfwWindow* CreateWindow(int width, int height, StringView title, GlfwMonitor* monitor, GlfwWindow* share) => glfwCreateWindow((.) width, (.) height, title.ToScopeCStr!(), monitor, share);

		[LinkName("glfwDestroyWindow")]
		/// Destroys the specified window and its context.
		public static extern void DestroyWindow(GlfwWindow* window);

		[CLink]
		private static extern c_int glfwWindowShouldClose(GlfwWindow* window);
		/// Checks the close flag of the specified window.
		public static bool WindowShouldClose(GlfwWindow* window) => glfwWindowShouldClose(window) == 1;

		[CLink]
		private static extern void glfwSetWindowShouldClose(GlfwWindow* window, int value);
		/// Sets the close flag of the specified window.
		public static void SetWindowShouldClose(GlfwWindow* window, bool value) => glfwSetWindowShouldClose(window, value ? TRUE : FALSE);

		[CLink]
		private static extern void glfwSetWindowTitle(GlfwWindow* window, c_char* title);
		/// Sets the title of the specified window.
		public static void SetWindowTitle(GlfwWindow* window, StringView title) => glfwSetWindowTitle(window, title.ToScopeCStr!());

		[CLink]
		private static extern void glfwSetWindowIcon(GlfwWindow* window, c_int count, GlfwImage* images);
		/// Sets the icon for the specified window.
		public static void SetWindowIcon(GlfwWindow* window, int count, GlfwImage* images) => glfwSetWindowIcon(window, (.) count, images);

		[CLink]
		private static extern void glfwGetWindowPos(GlfwWindow* window, c_intptr* x, c_intptr* y);
		/// Retrieves the position of the content area of the specified window.
		public static void GetWindowPos(GlfwWindow* window, ref int x, ref int y) => glfwGetWindowPos(window, &x, &y);

		[CLink]
		private static extern void glfwSetWindowPos(GlfwWindow* window, c_int x, c_int y);
		/// Sets the position of the content area of the specified window.
		public static void SetWindowPos(GlfwWindow* window, int x, int y) => glfwSetWindowPos(window, (.) x, (.) y);

		[CLink]
		private static extern void glfwGetWindowSize(GlfwWindow* window, c_intptr* width, c_intptr* height);
		/// Retrieves the size of the content area of the specified window.
		public static void GetWindowSize(GlfwWindow* window, ref int width, ref int height) => glfwGetWindowSize(window, &width, &height);

		[CLink]
		private static extern void glfwSetWindowSizeLimits(GlfwWindow* window, c_int minWidth, c_int minHeight, c_int maxWidth, c_int maxHeight);
		/// Sets the size limits of the specified window.
		public static void SetWindowSizeLimits(GlfwWindow* window, int minWidth, int minHeight, int maxWidth, int maxHeight) => glfwSetWindowSizeLimits(window, (.) minWidth, (.) minHeight, (.) maxWidth, (.) maxHeight);

		[CLink]
		private static extern void glfwSetWindowAspectRation(GlfwWindow* window, c_int numer, c_int denom);
		/// Sets the aspect ratio of the specified window.
		public static void SetWindowAspectRation(GlfwWindow* window, int numer, int denom) => glfwSetWindowAspectRation(window, (.) numer, (.) denom);

		[CLink]
		private static extern void glfwSetWindowSize(GlfwWindow* window, c_int width, c_int height);
		/// Sets the size of the content area of the specified window.
		public static void SetWindowSize(GlfwWindow* window, int width, int height) => glfwSetWindowSize(window, (.) width, (.) height);

		[CLink]
		private static extern void glfwGetFramebufferSize(GlfwWindow* window, c_intptr* width, c_intptr* height);
		/// Retrieves the size of the framebuffer of the specified window.
		public static void GetFramebufferSize(GlfwWindow* window, ref int width, ref int height) => glfwGetFramebufferSize(window, &width, &height);

		[CLink]
		private static extern void glfwGetWindowFrameSize(GlfwWindow* window, c_intptr* top, c_intptr* left, c_intptr* right, c_intptr* bottom);
		/// Retrieves the size of the frame of the window.
		public static void GetWindowSize(GlfwWindow* window, ref int top, ref int left, ref int  right, ref int bottom) => glfwGetWindowFrameSize(window, &top, &left, &right, &bottom);

		[CLink]
		private static extern void glfwGetWindowContentScale(GlfwWindow* window, float* xScale, float* yScale);
		/// Retrieves the content scale for the specified window.
		public static void GetWindowContentScale(GlfwWindow* window, ref float xScale, ref float yScale) => glfwGetWindowContentScale(window, &xScale, &yScale);

		[LinkName("glfwGetWindowOpacity")]
		/// Returns the opacity of the whole window.
		public static extern float GetWindowOpacity(GlfwWindow* window);

		[LinkName("glfwSetWindowOpacity")]
		/// Sets the opacity of the whole window.
		public static extern void SetWindowOpacity(GlfwWindow* window, float opacity);

		[LinkName("glfwIconifyWindow")]
		/// Iconifies the specified window.
		public static extern void IconifyWindow(GlfwWindow* window);

		[LinkName("glfwRestoreWindow")]
		/// Restores the specified window.
		public static extern void RestoreWindow(GlfwWindow* window);

		[LinkName("glfwMaximizeWindow")]
		/// Maximizes the specified window.
		public static extern void MaximizeWindow(GlfwWindow* window);

		[LinkName("glfwShowWindow")]
		/// Makes the specified window visible.
		public static extern void ShowWindow(GlfwWindow* window);

		[LinkName("glfwHideWindow")]
		/// Hides the specified window.
		public static extern void HideWindow(GlfwWindow* window);

		[LinkName("glfwFocusWindow")]
		/// Brings the specified window to front and sets input focus.
		public static extern void FocusWindow(GlfwWindow* window);

		[LinkName("glfwRequestWindowAttention")]
		/// Requests user attention to the specified window.
		public static extern void RequestWindowAttention(GlfwWindow* window);

		[LinkName("glfwGetWindowMonitor")]
		/// Returns the monitor that the window uses for full screen mode.
		public static extern GlfwMonitor* GetWindowMonitor(GlfwWindow* window);

		[CLink]
		private static extern void glfwSetWindowMonitor(GlfwWindow* window, GlfwMonitor* monitor, c_int x, c_int y, c_int width, c_int height, c_int refreshRate);
		/// Sets the mode, monitor, video mode and placement of a window.
		public static void SetWindowMonitor(GlfwWindow* window, GlfwMonitor* monitor, int x, int y, int width, int height, int refreshRate) => glfwSetWindowMonitor(window, monitor, (.) x, (.) y, (.) width, (.) height, (.) refreshRate);

		[CLink]
		private static extern int glfwGetWindowAttrib(GlfwWindow* window, c_int attrib);
		/// Returns an attribute of the specified window.
		public static int GetWindowAttrib(GlfwWindow* window, GlfwWindow.Attribute attrib) => glfwGetWindowAttrib(window, (.) attrib);

		[CLink]
		private static extern void glfwSetWindowAttrib(GlfwWindow* window, c_int attrib, c_int value);
		/// Sets an attribute of the specified window.
		public static void glfwSetWindowAttrib(GlfwWindow* window, GlfwWindow.Attribute attrib, bool value) => glfwSetWindowAttrib(window, attrib, value ? TRUE : FALSE);
		/// Sets an attribute of the specified window.
		public static void glfwSetWindowAttrib(GlfwWindow* window, GlfwWindow.Attribute attrib, int value) => glfwSetWindowAttrib(window, (.) attrib, (.) value);

		[LinkName("glfwSetWindowUserPointer")]
		/// Sets the user pointer of the specified window.
		public static extern void SetWindowUserPointer(GlfwWindow* window, void* ptr);

		[LinkName("glfwGetWindowUserPointer")]
		/// Returns the user pointer of the specified window.
		public static extern void* GetWindowUserPointer(GlfwWindow* window);

		[CLink]
		private static extern RawWindowPosCallback glfwSetWindowPosCallback(GlfwWindow* window, RawWindowPosCallback callback);
		/// Sets the position callback for the specified window.
		public static WindowPosCallback SetWindowPosCallback(GlfwWindow* window, WindowPosCallback callback, bool deletePrevCallback = true) {
			WindowPosCallback prevCallback = windowPosCallback;

			if (windowPosCallback != null && deletePrevCallback) delete windowPosCallback;
			windowPosCallback = callback;

			if (callback != null) glfwSetWindowPosCallback(window, (window, x, y) => windowPosCallback(window, x, y));
			else {
				glfwSetWindowPosCallback(window, (window, x, y) => {});
				windowPosCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawWindowSizeCallback glfwSetWindowSizeCallback(GlfwWindow* window, RawWindowSizeCallback callback);
		/// Sets the size callback for the specified window.
		public static WindowSizeCallback SetWindowSizeCallback(GlfwWindow* window, WindowSizeCallback calllback, bool deletePrevCallback = true) {
			WindowSizeCallback prevCallback = windowSizeCallback;

			if (windowSizeCallback != null && deletePrevCallback) delete windowSizeCallback;
			windowSizeCallback = calllback;

			if (calllback != null) glfwSetWindowSizeCallback(window, (window, width, height) => windowSizeCallback(window, width, height));
			else {
				glfwSetWindowSizeCallback(window, (window, width, height) => {});
				windowSizeCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawWindowCloseCallback glfwSetWindowCloseCallback(GlfwWindow* window, RawWindowCloseCallback callback);
		/// Sets the close callback for the specified window.
		public static WindowCloseCallback SetWindowCloseCallback(GlfwWindow* window, WindowCloseCallback callback, bool deletePrevCallback = true) {
			WindowCloseCallback prevCallback = windowCloseCallback;

			if (windowCloseCallback != null && deletePrevCallback) delete windowCloseCallback;
			windowCloseCallback = callback;

			if (callback != null) glfwSetWindowCloseCallback(window, (window) => windowCloseCallback(window));
			else {
				glfwSetWindowCloseCallback(window, (window) => {});
				windowCloseCallback = null;
			}
			
			return prevCallback;
		}

		[CLink]
		private static extern RawWindowRefreshCallback glfwSetWindowRefreshCallback(GlfwWindow* window, RawWindowRefreshCallback callback);
		/// Sets the refresh callback for the specified window.
		public static WindowRefreshCallback SetWindowRefreshCallback(GlfwWindow* window, WindowRefreshCallback callback, bool deletePrevCallback = true) {
			WindowRefreshCallback prevCallback = windowRefreshCallback;

			if (windowRefreshCallback != null && deletePrevCallback) delete windowRefreshCallback;
			windowRefreshCallback = callback;

			if (callback != null) glfwSetWindowRefreshCallback(window, (window) => windowRefreshCallback(window));
			else {
				glfwSetWindowRefreshCallback(window, (window) => {});
				windowRefreshCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawWindowFocusCallback glfwSetWindowFocusCallback(GlfwWindow* window, RawWindowFocusCallback callback);
		/// Sets the focus callback for the specified window.
		public static WindowFocusCallback SetWindowFocusCallback(GlfwWindow* window, WindowFocusCallback callback, bool deletePrevCallback = true) {
			WindowFocusCallback prevCallback = windowFocusCallback;

			if (windowFocusCallback != null && deletePrevCallback) delete windowFocusCallback;
			windowFocusCallback = callback;

			if (callback != null) glfwSetWindowFocusCallback(window, (window, focus) => windowFocusCallback(window, focus == TRUE));
			else {
				glfwSetWindowFocusCallback(window, (window, focus) => {});
				windowFocusCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawWindowIconifyCallback glfwSetWindowIconifyCallback(GlfwWindow* window, RawWindowIconifyCallback callback);
		/// Sets the iconify callback for the specified window.
		public static WindowIconifyCallback SetWindowIconifyCallback(GlfwWindow* window, WindowIconifyCallback callback, bool deletePrevCallback = true) {
			WindowIconifyCallback prevCallback = windowIconifyCallback;

			if (windowIconifyCallback != null && deletePrevCallback) delete windowIconifyCallback;
			windowIconifyCallback = callback;

			if (callback != null) glfwSetWindowIconifyCallback(window, (window, iconify) => windowIconifyCallback(window, iconify == TRUE));
			else {
				glfwSetWindowIconifyCallback(window, (window, iconify) => {});
				windowIconifyCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawWindowMaximizeCallback glfwSetWindowMaximizeCallback(GlfwWindow* window, RawWindowMaximizeCallback callback);
		/// Sets the maximize callback for the specified window.
		public static WindowMaximizeCallback SetWindowMaximizeCallback(GlfwWindow* window, WindowMaximizeCallback callback, bool deletePrevCallback = true) {
			WindowMaximizeCallback prevCallback = windowMaximizeCallback;

			if (windowMaximizeCallback != null && deletePrevCallback) delete windowMaximizeCallback;
			windowMaximizeCallback = callback;

			if (callback != null) glfwSetWindowMaximizeCallback(window, (window, maximize) => windowMaximizeCallback(window, maximize == TRUE));
			else {
				glfwSetWindowMaximizeCallback(window, (window, maximize) => {});
				windowMaximizeCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawFramebufferSizeCallback glfwSetFramebufferSizeCallback(GlfwWindow* window, RawFramebufferSizeCallback callback);
		/// Sets the framebuffer resize callback for the specified window.
		public static FramebufferSizeCallback SetFramebufferSizeCallback(GlfwWindow* window, FramebufferSizeCallback callback, bool deletePrevCallback = true) {
			FramebufferSizeCallback prevCallback = framebufferSizeCallback;

			if (framebufferSizeCallback != null && deletePrevCallback) delete framebufferSizeCallback;
			framebufferSizeCallback = callback;

			if (callback != null) glfwSetFramebufferSizeCallback(window, (window, width, height) => framebufferSizeCallback(window, width, height));
			else {
				glfwSetFramebufferSizeCallback(window, (window, width, height) => {});
				framebufferSizeCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawWindowContentsScaleCallback glfwSetWindowContentScaleCallback(GlfwWindow* window, RawWindowContentsScaleCallback callback);
		/// Sets the window content scale callback for the specified window.
		public static WindowContentsScaleCallback SetWindowContentScaleCallback(GlfwWindow* window, WindowContentsScaleCallback callback, bool deletePrevCallback = true) {
			WindowContentsScaleCallback prevCallback = windowContentsScaleCallback;

			if (windowContentsScaleCallback != null && deletePrevCallback) delete windowContentsScaleCallback;
			windowContentsScaleCallback = callback;

			if (callback != null) glfwSetWindowContentScaleCallback(window, (window, xScale, yScale) => windowContentsScaleCallback(window, xScale, yScale));
			else {
				glfwSetWindowContentScaleCallback(window, (window, xScale, yScale) => {});
				windowContentsScaleCallback = null;
			}

			return prevCallback;
		}

		[LinkName("glfwPollEvents")]
		/// Processes all pending events.
		public static extern void PollEvents();

		[LinkName("glfwWaitEvents")]
		/// Waits until events are queued and processes them.
		public static extern void WaitEvents();

		[LinkName("glfwWaitEventsTimeout")]
		/// Waits with timeout until events are queued and processes them.
		public static extern void WaitEventsTimeout(double timeout);

		[LinkName("glfwPostEmptyEvent")]
		/// Posts an empty event to the event queue.
		public static extern void PostEmptyEvent();

		[LinkName("glfwSwapBuffers")]
		/// Swaps the front and back buffers of the specified window.
		public static extern void SwapBuffers(GlfwWindow* window);
	}
}
