using System;

namespace GLFW {
	[CRepr]
	/// Opaque monitor object.
	struct GlfwMonitor {
		public enum Event {
			Connected = 0x00040001,
			Disconnected = 0x00040002
		}
	}
}
