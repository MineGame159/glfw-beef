using System;

namespace glfw_beef {
	[CRepr]
	struct GlfwMonitor {
		public enum Event {
			Connected = 0x00040001,
			Disconnected = 0x00040002
		}
	}
}
