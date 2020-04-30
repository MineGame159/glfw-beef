using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwGammaRamp {
		uint16* red, green, blue;
		uint size;
	}
}
