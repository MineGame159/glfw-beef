using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwVidMode {
		int width, height;
		int redBits, greenBits, blueBits;
		int refreshRate;
	}
}
