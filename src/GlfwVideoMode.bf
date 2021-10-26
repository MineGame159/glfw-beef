using System;
using System.Interop;

namespace GLFW {
	[CRepr]
	/// Video mode type.
	struct GlfwVideoMode {
		public c_int width, height;
		public c_int redBits, greenBits, blueBits;
		public c_int refreshRate;
	}
}
