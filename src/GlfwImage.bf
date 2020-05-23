using System;

namespace glfw_beef {
	[CRepr]
	class GlfwImage {
		public int32 width, height;
		public char8* pixels;
	}
}
