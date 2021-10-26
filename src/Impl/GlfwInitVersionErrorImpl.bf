using System;
using System.Interop;

namespace GLFW {
	extension Glfw {
		// Callbacks

		private function void RawErrorCallback(c_int error_code, c_char* description);
		/// The delegate type for error callbacks.
		public delegate void ErrorCallback(Error error, StringView description);
		private static ErrorCallback errorCallback ~ delete _;

		// Functions

		[CLink]
		private static extern c_int glfwInit();
		/// Initializes the GLFW library.
		public static bool Init() => glfwInit() == TRUE;

		[LinkName("glfwTerminate")]
		/// Terminates the GLFW library.
		public static extern void Terminate();

		[CLink]
		private static extern void glfwInitHint(c_int hint, c_int value);
		/// Sets the specified init hint to the desired value.
		public static void InitHint(InitHint hint, int value) => glfwInitHint(hint.Underlying, (.) value);

		[CLink]
		private static extern void glfwGetVersion(c_intptr* major, c_intptr* minor, c_intptr* rev);
		/// Retrieves the version of the GLFW library.
		public static void GetVersion(ref int major, ref int minor, ref int rev) => glfwGetVersion(&major, &minor, &rev);

		[CLink]
		private static extern c_char* glfwGetVersionString();
		/// Returns a string describing the compile-time configuration.
		public static void GetVersionString(String buffer) => buffer.Append(glfwGetVersionString());

		[CLink]
		private static extern c_int glfwGetError(c_char** description);
		/// Returns and clears the last error for the calling thread.
		public static Error GetError(String buffer) {
			c_char* chars = scope .();
			int err = glfwGetError(&chars);

			if (chars != null) buffer.Append(chars);
			return (Error) err;
		}

		[CLink]
		private static extern RawErrorCallback glfwSetErrorCallback(RawErrorCallback callback);
		/// Sets the error callback.
		public static ErrorCallback SetErrorCallback(ErrorCallback callback, bool deletePrevCallback = true) {
			ErrorCallback prevCallback = errorCallback;

			if (errorCallback != null && deletePrevCallback) delete errorCallback;
			errorCallback = callback;					   

			if (callback != null) glfwSetErrorCallback((error, description) => errorCallback((Error) error, StringView(description)));
			else {
				 glfwSetErrorCallback((error, description) => {});
				 errorCallback = null;
			}

			return prevCallback;
		}
	}
}
