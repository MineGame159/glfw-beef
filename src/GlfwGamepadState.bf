using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwGamepadState {
		public GlfwInput.Action[15] buttons;
		public float[6] axes;
	}
}
