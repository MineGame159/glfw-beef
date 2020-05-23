using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwGammaRamp {
		public uint16* red, green, blue;
		public uint32 size;
	}
}
