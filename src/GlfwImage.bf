using System;
using System.Interop;

namespace GLFW {
	[CRepr]
	/// Image data.
	class GlfwImage {
		public c_int width, height;
		public c_char* pixels;
	}
}
