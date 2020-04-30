using System;

namespace glfw_beef {
	[CRepr]
	class GlfwImage {
		int width, height;
		char8* pixels;
	}
}
