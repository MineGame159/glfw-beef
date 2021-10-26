using System;
using System.Interop;

namespace GLFW {
	[CRepr]
	/// Gamma ramp.
	struct GlfwGammaRamp {
		public c_ushort* red, green, blue;
		public c_uint size;
	}
}
