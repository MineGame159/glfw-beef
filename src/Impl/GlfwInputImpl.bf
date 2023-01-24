using System;
using System.Interop;

namespace GLFW {
	extension Glfw {
		// Callbacks

		private function void RawKeyCallback(GlfwWindow* monitor, c_int key, c_int scancode, c_int action, c_int mods);
		/// The delegate type for keyboard key callbacks.
		public delegate void KeyCallback(GlfwWindow* window, GlfwInput.Key key, int scancode, GlfwInput.Action action, int mods);
		private static KeyCallback keyCallback ~ delete _;

		private function void RawCharCallback(GlfwWindow* window, c_uint char);
		/// The delegate type for Unicode character callbacks.
		public delegate void CharCallback(GlfwWindow* window, uint char);
		private static CharCallback charCallback ~ delete _;

		private function void RawCharModsCallback(GlfwWindow* window, c_uint char, c_int mods);
		/// The delegate type for Unicode character with modifiers callbacks.
		public delegate void CharModsCallback(GlfwWindow* window, uint char, int mods);
		private static CharModsCallback charModsCallback ~ delete _;

		private function void RawMouseButtonCallback(GlfwWindow* window, c_int button, c_int action, c_int mods);
		/// The delegate type for mouse button callbacks.
		public delegate void MouseButtonCallback(GlfwWindow* window, GlfwInput.MouseButton button, GlfwInput.Action action, int mods);
		private static MouseButtonCallback mouseButtonCallback ~ delete _;

		private function void RawCursorPosCallback(GlfwWindow* window, double x, double y);
		/// The delegate type for cursor position callbacks.
		public delegate void CursorPosCallback(GlfwWindow* window, double x, double y);
		private static CursorPosCallback cursorPosCallback ~ delete _;

		private function void RawCursorEnterCallback(GlfwWindow* window, c_int entered);
		/// The delegate type for cursor enter/leave callbacks.
		public delegate void CursorEnterCallback(GlfwWindow* window, bool entered);
		private static CursorEnterCallback cursorEnterCallback ~ delete _;

		private function void RawScrollCallback(GlfwWindow* window, double xOffset, double yOffset);
		/// The delegate type for scroll callbacks.
		public delegate void ScrollCallback(GlfwWindow* window, double xOffset, double yOffset);
		private static ScrollCallback scrollCallback ~ delete _;

		private function void RawDropCallback(GlfwWindow* window, c_int count, c_char*[] paths);
		/// The delegate type for path drop callbacks.
		public delegate void DropCallback(GlfwWindow* window, int count, char8*[] paths);
		private static DropCallback dropCallback ~ delete _;

		private function void RawJoystickCallback(c_int id, c_int event);
		/// The delegate type for joystick configuration callbacks.
		public delegate void JoystickCallback(int id, GlfwInput.JoystickEvent event);
		private static JoystickCallback joystickCallback ~ delete _;

		// Functions

		[CLink]
		private static extern int glfwGetInputMode(GlfwWindow* window, c_int mode);
		/// Returns the value of an input option for the specified window.
		public static int GetInputMode(GlfwWindow* window, GlfwInput.InputMode mode) => glfwGetInputMode(window, (.) mode);

		[CLink]
		private static extern void glfwSetInputMode(GlfwWindow* window, c_int mode, c_int value);
		/// Sets an input option for the specified window.
		public static void SetInputMode(GlfwWindow* window, GlfwInput.InputMode mode, int value) => glfwSetInputMode(window, (.) mode, (.) value);
		/// Sets an input option for the specified window.
		public static void SetInputMode(GlfwWindow* window, GlfwInput.InputMode mode, GlfwInput.CursorInputMode value) => glfwSetInputMode(window, (.) mode, (.) value);

		[CLink]
		private static extern int glfwRawMouseMotionSupported();
		/// Returns whether raw mouse motion is supported.
		public static bool RawMouseMotionSupported() => glfwRawMouseMotionSupported() == TRUE;

		[CLink]
		private static extern c_char* glfwGetKeyName(c_int key, c_int scancode);
		/// Returns the layout-specific name of the specified printable key.
		public static void GetKeyName(GlfwInput.Key key, int scancode, String buffer) {
			char8* chars = glfwGetKeyName((.) key, (.) scancode);
			if (chars != null) buffer.Append(chars);
		}

		[CLink]
		private static extern c_int glfwGetKeyScancode(c_int key);
		/// Returns the platform-specific scancode of the specified key.
		public static int GetKeyScancode(GlfwInput.Key key) => glfwGetKeyScancode((.) key);

		[CLink]
		private static extern c_int glfwGetKey(GlfwWindow* window, c_int key);
		/// Returns the last reported state of a keyboard key for the specified window.
		public static GlfwInput.Action GetKey(GlfwWindow* window, GlfwInput.Key key) => (.) glfwGetKey(window, (.) key);

		[CLink]
		private static extern int glfwGetMouseButton(GlfwWindow* window, c_int button);
		/// Returns the last reported state of a mouse button for the specified window.
		public static GlfwInput.Action GetMouseButton(GlfwWindow* window, GlfwInput.MouseButton button) => (.) glfwGetMouseButton(window, (.) button);

		[CLink]
		private static extern void glfwGetCursorPos(GlfwWindow* window, double* x, double* y);
		/// Retrieves the position of the cursor relative to the content area of the window.
		public static void GetCursorPos(GlfwWindow* window, ref double x, ref double y) => glfwGetCursorPos(window, &x, &y);

		[LinkName("glfwSetCursorPos")]
		/// Sets the position of the cursor, relative to the content area of the window.
		public static extern void SetCursorPos(GlfwWindow* window, double x, double y);

		[CLink]
		private static extern GlfwCursor* glfwCreateCursor(GlfwImage* image, c_int xHot, c_int yHot);
		/// Creates a custom cursor.
		public static GlfwCursor* CreateCursor(GlfwImage* image, int xHot, int yHot) => glfwCreateCursor(image, (.) xHot, (.) yHot);

		[CLink]
		private static extern GlfwCursor* glfwCreateStandardCursor(c_int shape);
		/// Creates a cursor with a standard shape.
		public static GlfwCursor* CreateStandardCursor(GlfwInput.CursorShape shape) => glfwCreateStandardCursor((.) shape);

		[LinkName("glfwDestroyCursor")]
		/// Destroys a cursor.
		public static extern void DestroyCursor(GlfwCursor* cursor);

		[LinkName("glfwSetCursor")]
		/// Sets the cursor for the window.
		public static extern void SetCursor(GlfwWindow* window, GlfwCursor* cursor);

		[CLink]
		private static extern RawKeyCallback glfwSetKeyCallback(GlfwWindow* window, RawKeyCallback callback);
		/// Sets the key callback.
		public static KeyCallback SetKeyCallback(GlfwWindow* window, KeyCallback callback, bool deletePrevCallback = true) {
			KeyCallback prevCallback = keyCallback;

			if (keyCallback != null && deletePrevCallback) delete keyCallback;
			keyCallback = callback;

			if (callback != null) glfwSetKeyCallback(window, (window, key, scancode, action, mods) => keyCallback(window, (GlfwInput.Key) key, scancode, (GlfwInput.Action) action, mods));
			else {
				glfwSetKeyCallback(window, (window, key, scancode, action, mods) => {});
				keyCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawCharCallback glfwSetCharCallback(GlfwWindow* window, RawCharCallback callback);
		/// Sets the Unicode character callback.
		public static CharCallback SetCharCallback(GlfwWindow* window, CharCallback callback, bool deletePrevCallback = true) {
			CharCallback prevCallback = charCallback;

			if (charCallback != null && deletePrevCallback) delete charCallback;
			charCallback = callback;

			if (callback != null) glfwSetCharCallback(window, (window, char) => charCallback(window, char));
			else {
				glfwSetCharCallback(window, (window, char) => {});
				charCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawCharModsCallback glfwSetCharModsCallback(GlfwWindow* window, RawCharModsCallback callback);
		/// Sets the Unicode character with modifiers callback.
		public static CharModsCallback SetCharModsCallback(GlfwWindow* window, CharModsCallback callback, bool deletePrevCallback = true) {
			CharModsCallback prevCallback = charModsCallback;

			if (charModsCallback != null && deletePrevCallback) delete charModsCallback;
			charModsCallback = callback;

			if (callback != null) glfwSetCharModsCallback(window, (window, char, mods) => charModsCallback(window, char, mods));
			else {
				glfwSetCharModsCallback(window, (window, char, mods) => {});
				charModsCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawMouseButtonCallback glfwSetMouseButtonCallback(GlfwWindow* window, RawMouseButtonCallback callback);
		/// Sets the mouse button callback.
		public static MouseButtonCallback SetMouseButtonCallback(GlfwWindow* window, MouseButtonCallback callback, bool deletePrevCallback = true) {
			MouseButtonCallback prevCallback = mouseButtonCallback;

			if (mouseButtonCallback != null && deletePrevCallback) delete mouseButtonCallback;
			mouseButtonCallback = callback;

			if (callback != null) glfwSetMouseButtonCallback(window, (window, button, action, mods) => mouseButtonCallback(window, (GlfwInput.MouseButton) button, (GlfwInput.Action) action, mods));
			else {
				glfwSetMouseButtonCallback(window, (window, button, action, mods) => {});
				mouseButtonCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawCursorPosCallback glfwSetCursorPosCallback(GlfwWindow* window, RawCursorPosCallback callback);
		/// Sets the cursor position callback.
		public static CursorPosCallback SetCursorPosCallback(GlfwWindow* window, CursorPosCallback callback, bool deletePrevCallback = true) {
			CursorPosCallback prevCallback = cursorPosCallback;

			if (cursorPosCallback != null && deletePrevCallback) delete cursorPosCallback;
			cursorPosCallback = callback;

			if (callback != null) glfwSetCursorPosCallback(window, (window, x, y) => cursorPosCallback(window, x, y));
			else {
				glfwSetCursorPosCallback(window, (window, x, y) => {});
				cursorPosCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawCursorEnterCallback glfwSetCursorEnterCallback(GlfwWindow* window, RawCursorEnterCallback callback);
		/// Sets the cursor enter/leave callback.
		public static CursorEnterCallback SetCursorEnterCallback(GlfwWindow* window, CursorEnterCallback callback, bool deletePrevCallback = true) {
			CursorEnterCallback prevCallback = cursorEnterCallback;

			if (cursorEnterCallback != null && deletePrevCallback) delete cursorEnterCallback;
			cursorEnterCallback = callback;

			if (callback != null) glfwSetCursorEnterCallback(window, (window, entered) => cursorEnterCallback(window, entered == TRUE));
			else {
				glfwSetCursorEnterCallback(window, (window, entered) => {});
				cursorEnterCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawScrollCallback glfwSetScrollCallback(GlfwWindow* window, RawScrollCallback callback);
		/// Sets the scroll callback.
		public static ScrollCallback SetScrollCallback(GlfwWindow* window, ScrollCallback callback, bool deletePrevCallback = true) {
			ScrollCallback prevCallback = scrollCallback;

			if (scrollCallback != null && deletePrevCallback) delete scrollCallback;
			scrollCallback = callback;

			if (callback != null) glfwSetScrollCallback(window, (window, xOffset, yOffset) => scrollCallback(window, xOffset, yOffset));
			else {
				glfwSetScrollCallback(window, (window, xOffset, yOffset) => {});
				scrollCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern RawDropCallback glfwSetDropCallback(GlfwWindow* window, RawDropCallback callback);
		/// Sets the path drop callback.
		public static DropCallback SetDropCallback(GlfwWindow* window, DropCallback callback, bool deletePrevCallback = true) {
			DropCallback prevCallback = dropCallback;

			if (dropCallback != null && deletePrevCallback) delete dropCallback;
			dropCallback = callback;

			if (callback != null) glfwSetDropCallback(window, (window, count, paths) => dropCallback(window, count, paths));
			else {
				glfwSetDropCallback(window, (window, count, paths) => {});
				dropCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern c_int glfwJoystickPresent(c_int id);
		/// Returns whether the specified joystick is present.
		public static bool JoystickPresent(int id) => glfwJoystickPresent((.) id) == TRUE;

		[CLink]
		private static extern float* glfwGetJoystickAxes(c_int id, c_intptr* count);
		/// Returns the values of all axes of the specified joystick.
		public static float* GetJoystickAxes(int id, ref int count) => glfwGetJoystickAxes((.) id, &count);

		[CLink]
		private static extern uint8* glfwGetJoystickButtons(c_int id, c_intptr* count);
		/// Returns the state of all buttons of the specified joystick.
		public static GlfwInput.Action* GetJoystickButtons(int id, ref int count) => (.) glfwGetJoystickButtons((.) id, &count);

		[CLink]
		private static extern uint8* glfwGetJoystickHats(c_int id, c_intptr* count);
		/// Returns the state of all hats of the specified joystick.
		public static GlfwInput.JoystickHatState* GetJoystickHats(int id, ref int count) => (.) glfwGetJoystickHats((.) id, &count);

		[CLink]
		private static extern c_char* glfwGetJoystickName(c_int id);
		/// Returns the name of the specified joystick.
		public static void GetJoystickName(int id, String buffer) {
			c_char* chars = glfwGetJoystickName((.) id);
			buffer.Append(chars);
		}

		[CLink]
		private static extern c_char* glfwGetJoystickGuid(c_int id);
		/// Returns the SDL compatible GUID of the specified joystick.
		public static  void GetJoystickGuid(int id, String buffer) {
			c_char* chars = glfwGetJoystickGuid((.) id);
			buffer.Append(chars);
		}

		[CLink]
		private static extern void glfwSetJoystickUserPointer(c_int id, void* ptr);
		/// Sets the user pointer of the specified joystick.
		public static void SetJoystickUserPointer(int id, void* ptr) => glfwSetJoystickUserPointer((.) id, ptr);

		[CLink]
		private static extern void* glfwGetJoystickUserPointer(c_int id);
		/// Returns the user pointer of the specified joystick.
		public static void* GetJoystickUserPointer(int id) => glfwGetJoystickUserPointer((.) id);

		[CLink]
		private static extern c_int glfwJoystickIsGamepad(c_int id);
		/// Returns whether the specified joystick has a gamepad mapping.
		public static bool JoystickIsGamepad(int id) => glfwJoystickIsGamepad((.) id) == TRUE;

		[CLink]
		private static extern RawJoystickCallback glfwSetJoystickCallback(RawJoystickCallback callback);
		/// Sets the joystick configuration callback.
		public static JoystickCallback SetJoystickCallback(JoystickCallback callback, bool deletePrevCallback = true) {
			JoystickCallback prevCallback = joystickCallback;

			if (joystickCallback != null && deletePrevCallback) delete joystickCallback;
			joystickCallback = callback;

			if (callback != null) glfwSetJoystickCallback((id, event) => joystickCallback(id, (GlfwInput.JoystickEvent) event));
			else {
				glfwSetJoystickCallback((id, event) => {});
				joystickCallback = null;
			}

			return prevCallback;
		}

		[CLink]
		private static extern c_int glfwUpdateGamepadMappings(c_char* string);
		/// Adds the specified SDL_GameControllerDB gamepad mappings.
		public static bool UpdateGamepadMappigns(StringView string) => glfwUpdateGamepadMappings(string.ToScopeCStr!()) == TRUE;

		[CLink]
		private static extern c_char* glfwGetGamepadName(c_int id);
		/// Returns the human-readable gamepad name for the specified joystick.
		public static void GetGamepadName(int id, String buffer) {
			c_char* chars = glfwGetGamepadName((.) id);
			buffer.Append(chars);
		}

		[CLink]
		private static extern c_int glfwGetGamepadState(c_int id, GlfwGamepadState* state);
		/// Retrieves the state of the specified joystick remapped as a gamepad.
		public static bool GetGamepadState(int id, ref GlfwGamepadState state) => glfwGetGamepadState((.) id, &state) == TRUE;

		[CLink]
		private static extern void glfwSetClipboardString(GlfwWindow* window, c_char* string);
		/// Sets the clipboard to the specified string.
		public static void SetClipboardString(GlfwWindow* window, StringView string) => glfwSetClipboardString(window, string.ToScopeCStr!());

		[CLink]
		private static extern c_char* glfwGetClipboardString(GlfwWindow* window);
		/// Returns the contents of the clipboard as a string.
		public static void GetClipboardString(GlfwWindow* window, String buffer) {
			char8* chars  = glfwGetClipboardString(window);
			buffer.Append(chars);
		}

		[LinkName("glfwGetTime")]
		/// Returns the GLFW time.
		public static extern double GetTime();

		[LinkName("glfwSetTime")]
		/// Sets the GLFW time.
		public static extern void SetTime(double time);

		[LinkName("glfwGetTimerValue")]
		/// Returns the current value of the raw timer.
		public static extern uint64 GetTimerValue();

		[LinkName("glfwGetTimerFrequency")]
		/// Returns the frequency, in Hz, of the raw timer.
		public static extern uint64 GetTimerFrequency();
	}
}
