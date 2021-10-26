using System;

namespace GLFW {
	[CRepr]
	/// Opaque window object.
	struct GlfwWindow {
		public enum Hint {
			// Window related
			Resizable = 0x00020003,
			Visible = 0x00020004,
			Decorated = 0x00020005,
			Focused = 0x00020001,
			AutoIconify = 0x00020006,
			Floating = 0x00020007,
			Maximized = 0x00020008,
			CenterCursor = 0x00020009,
			TransparentFramebuffer = 0x0002000A,
			FocusOnShow = 0x0002000C,
			ScaleToMonitor = 0x0002200C,

			// Framebuffer related
			RedBits = 0x00021001,
			GreenBits = 0x00021002,
			BlueBits = 0x00021003,
			AlphaBits = 0x00021004,
			DepthBits = 0x00021005,
			StencilBits = 0x00021006,

			AccumRedBits = 0x00021007,
			AccumGreenBits = 0x00021008,
			AccumBlueBits = 0x00021009,
			AccumAlphaBits = 0x0002100A,

			AuxBuffers = 0x0002100B,
			Stereo = 0x0002100C,
			Samples = 0x0002100D,
			SRGBCapable = 0x0002100E,
			DoubleBuffer = 0x00021010,

			// Monitor related
			RefreshRate = 0x0002100F,

			// Context related
			ClientApi = 0x00022001,
			ContextCreationApi = 0x0002200B,
			ContextVersionMajor = 0x00022002,
			ContextVersionMinor = 0x00022003,
			OpenGlForwardCompat = 0x00022006,
			OpenGlDebugContext = 0x00022007,
			OpenGlProfile = 0x00022008,
			ContextRobustness = 0x00022005,
			ContextReleaseBehavior = 0x00022009,
			ContextNoError = 0x0002200A,

			// MacOS specific
			CocoaRetinaFramebuffer = 0x00023001,
			CocoaFrameName = 0x00023002,
			CocoaGraphicsSwitching = 0x00023003,

			// X11 specific
			X11ClassName = 0x00024001,
			X11InstanceName = 0x00024002
		}

		public enum Attribute {
			// Window related
			Focused = 0x00020001,
			Iconified = 0x00020002,
			Maximized = 0x00020008,
			Hovered = 0x0002000B,
			Visible = 0x00020004,
			Resizable = 0x00020003,
			Decorated = 0x00020005,
			AutoIconify = 0x00020006,
			Floating = 0x00020007,
			TransparentFramebuffer = 0x0002000A,
			FocusOnShow = 0x0002000C,

			// Context related
			ClientApi = 0x00022001,
			ContextCreationApi = 0x0002200B,
			ContextVersionMajor = 0x00022002,
			ContextVersionMinor = 0x00022003,
			ContextRevision = 0x00022004,
			OpenGlForwardCompat = 0x00022006,
			OpenGlDebugContext = 0x00022007,
			OpenGlProfile = 0x00022008,
			ContextReleaseBehavior = 0x00022009,
			ContextNoError = 0x0002200A,
			ContextRobustness = 0x00022005
		}
	}
}
