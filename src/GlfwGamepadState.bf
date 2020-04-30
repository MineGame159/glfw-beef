using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwGamepadState {
		GlfwInput.Action[15] buttons;
		float[6] axes;
	}
}
