using System;

namespace GLFW {
	[CRepr]
	/// Gamepad input state.
	struct GlfwGamepadState {
		public GlfwInput.Action[15] buttons;
		public float[6] axes;
	}
}
