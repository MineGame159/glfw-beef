using System;
using System.Interop;

namespace GLFW {
	static class GlfwInput {
		[AllowDuplicates]
		public enum MouseButton {
			Button1,
			Button2,
			Button3,
			Button4,
			Button5,
			Button6,
			Button7,
			Button8,

			ButtonLast = Button8,
			ButtonLeft = Button1,
			ButtonRight = Button2,
			ButtonMiddle = Button3
		}

		[AllowDuplicates]
		public enum Key {
			Unknown = -1,
			Space = 32,
			Apostrophe = 39,
			Comma = 44,
			Minus,
			Period,
			Slash,
			Num0,
			Num1,
			Num2,
			Num3,
			Num4,
			Num5,
			Num6,
			Num7,
			Num8,
			Num9,
			Semicolon = 59,
			Equal = 61,
			A = 65,
			B,
			C,
			D,
			E,
			F,
			G,
			H,
			I,
			J,
			K,
			L,
			M,
			N,
			O,
			P,
			Q,
			R,
			S,
			T,
			U,
			V,
			W,
			X,
			Y,
			Z,
			LeftBracket,
			Backslash,
			RightBracket,
			GraveAccent = 96,
			World1 = 161,
			World2,
			Escape = 256,
			Enter,
			Tab,
			Backspace,
			Insert,
			Delete,
			Right,
			Left,
			Down,
			Up,
			PageUp,
			PageDown,
			Home,
			End,
			CapsLock = 280,
			ScrollLock,
			NumLock,
			PrintScreen,
			Pause,
			F1 = 290,
			F2,
			F3,
			F4,
			F5,
			F6,
			F7,
			F8,
			F9,
			F10,
			F11,
			F12,
			F13,
			F14,
			F15,
			F16,
			F17,
			F18,
			F19,
			F20,
			F21,
			F22,
			F23,
			F24,
			F25,
			Kp0 = 320,
			Kp1,
			Kp2,
			Kp3,
			Kp4,
			Kp5,
			Kp6,
			Kp7,
			Kp8,
			Kp9,
			KpDecimal,
			KpDivide,
			KpMultiply,
			KpSubtract,
			KpAdd,
			KpEnter,
			KpEqual,
			LeftShift = 340,
			LeftControl,
			LeftAlt,
			LeftSuper,
			RightShift,
			RightControl,
			RightAlt,
			RightSuper,
			Menu,

			Last = Menu
		}

		public enum Modifiers {
			None = 0x0000,
			Shift = 0x0001,
			Control = 0x0002,
			Alt = 0x0004,
			Super = 0x0008,
			CapsLock = 0x0010,
			NumLock = 0x0020
		}

		public enum	CursorShape {
			Arrow = 0x00036001,
			IBeam = 0x00036002,
			Crosshair = 0x00036003,
			Hand = 0x00036004,
			HResize = 0x00036005,
			VResize = 0x00036006
		}

		[AllowDuplicates]
		public enum Joystick {
			Joystick1,
			Joystick2,
			Joystick3,
			Joystick4,
			Joystick5,
			Joystick6,
			Joystick7,
			Joystick8,
			Joystick9,
			Joystick10,
			Joystick11,
			Joystick12,
			Joystick13,
			Joystick14,
			Joystick15,
			Joystick16,

			Last = Joystick16
		}

		public enum JoystickHatState {
			Centered = 0,
			Up = 1,
			Right = 2,
			Down = 4,
			Left = 8,

			RightUp = Right | Up,
			RightDown = Right | Down,
			LeftUp = Left | Up,
			LeftDown = Left | Down
		}

		[AllowDuplicates]
		public enum GamepadButton {
			A,
			B,
			X,
			Y,
			LeftBumper,
			RightBumper,
			Back,
			Start,
			Guide,
			LeftThumb,
			RightThumb,
			DPadUp,
			DPadRight,
			DPadDown,
			DPadLeft,

			Last = DPadLeft,
			Cross = A,
			Circle = B,
			Square = X,
			Triangle = Y
		}

		[AllowDuplicates]
		public enum GamepadAxis {
			LeftX,
			LeftY,
			RightX,
			RightY,
			LeftTrigger,
			RightTrigger,

			Last = RightTrigger
		}

		public enum InputMode {
			Cursor = 0x00033001,
			StickyKeys = 0x00033002,
			StickyMouseButtons = 0x00033003,
			LockKeyMods = 0x00033004,
			RawMouseMotion = 0x00033005
		}

		public enum CursorInputMode {
			Normal = 0x00034001,
			Hidded = 0x00034002,
			Disabled = 0x00034003
		}

		public enum Action : c_uchar {
			Press = 1,
			Release = 0,
			Repeat = 2
		}

		public enum JoystickEvent {
			Connected = 0x00040001,
			Disconnected = 0x00040002
		}
	}
}
