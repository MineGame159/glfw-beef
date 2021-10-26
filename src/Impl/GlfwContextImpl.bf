using System;
using System.Interop;

namespace GLFW {
	extension Glfw {
		[LinkName("glfwMakeContextCurrent")]
		/// Makes the context of the specified window current for the calling thread.
		public static extern void MakeContextCurrent(GlfwWindow* window);

		[LinkName("glfwGetCurrentContext")]
		/// Returns the window whose context is current on the calling thread.
		public static extern GlfwWindow* GetCurrentContext();

		[CLink]
		private static extern void glfwSwapInterval(c_int interval);
		/// Sets the swap interval for the current context.
		public static void SwapInterval(int interval) => glfwSwapInterval((.) interval);

		[CLink]
		private static extern c_int glfwExtensionSupported(c_char* name);
		/// Returns whether the specified extension is available.
		public static bool ExtensionSupported(StringView name) => glfwExtensionSupported(name.ToScopeCStr!()) == TRUE;

		[CLink]
		private static extern void* glfwGetProcAddress(c_char* procname);
		/// Returns the address of the specified function for the current context.
		public static void* GetProcAddress(StringView procname) => glfwGetProcAddress(procname.ToScopeCStr!());
	}
}
