using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwVidMode {
		public int32 width, height;
		public int32 redBits, greenBits, blueBits;
		public int32 refreshRate;
	}
}
